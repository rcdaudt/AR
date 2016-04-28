function edges = RPS(vertices)
% Rotational Plane Sweep implementation
% Daudt

% Initialize stuff
num_v = size(vertices,1);
num_obj = max(vertices(:,3))-1;
ang_to_v = [zeros(num_v,1) (1:num_v)'];
visibility_graph = [];




% Create list of edges coordinates and list of edges connected to each
% vertex
edge_list = zeros(num_v-2,4);
edge_counter = 0;
edges_connected_to_v = zeros(num_v,2);
for i = 1:num_obj
    indices = find(vertices(:,3) == i);
    for j = 1:size(indices,1)-1
        x1 = vertices(indices(j),1);
        y1 = vertices(indices(j),2);
        x2 = vertices(indices(j+1),1);
        y2 = vertices(indices(j+1),2);
        edge_counter = edge_counter + 1;
        edge_list(edge_counter,:) = [x1, y1, x2, y2];
        edges_connected_to_v(indices(j),1) = edge_counter;
        edges_connected_to_v(indices(j+1),2) = edge_counter;
    end
    x1 = vertices(indices(end),1);
    y1 = vertices(indices(end),2);
    x2 = vertices(indices(1),1);
    y2 = vertices(indices(1),2);
    edge_counter = edge_counter + 1;
    edge_list(edge_counter,:) = [x1, y1, x2, y2];
    edges_connected_to_v(indices(end),1) = edge_counter;
    edges_connected_to_v(indices(1),2) = edge_counter;
end


for v = 1:num_v % For each vertex
    % Create sorted angle to vertex list
    for other_v = 1:num_v
        if v == other_v
            ang_to_v(other_v,1) = 0;
        else
            dx = vertices(other_v,1) - vertices(v,1);
            dy = vertices(other_v,2) - vertices(v,2);
            ang_to_v(other_v,1) = mod(atan2(dy,dx),2*pi);
        end
    end
    
    % Create list of all edges that intersect horizontal half-line starting
    % at v
    x1 = vertices(v,1);
    x2 = max(vertices(:,1))+1;
    y1 = vertices(v,2);
    y2 = vertices(v,2);
    
    hor_intersect = [];
    
    for i = 1:edge_counter
        if (i ~= edges_connected_to_v(v,1)) && (i ~= edges_connected_to_v(v,2)) 
            x3 = edge_list(i,1);
            x4 = edge_list(i,3);
            y3 = edge_list(i,2);
            y4 = edge_list(i,4);
            [XI,YI] = polyxpoly([x1 x2],[y1 y2],[x3 x4],[y3 y4]);
            if size(XI,1)
                dis = norm([(XI-x1), (YI-y1)]);
                if (XI ~= x1)
                    if (YI == y3)
                        if (YI < y4)
                            hor_intersect = [hor_intersect;dis, i];
                        end
                    elseif (YI == y4)
                        if (YI < y3)
                            hor_intersect = [hor_intersect;dis, i];
                        end
                    else
                        hor_intersect = [hor_intersect;dis, i];
                    end
                end
            end
            hor_intersect = sortrows(hor_intersect);
        end
    end
    
    sorted_list = sortrows(ang_to_v);
    
    % Initialize S with edges that intersect the horizontal line
    if size(hor_intersect,1) > 0
        S = hor_intersect(:,2)';
    else
        S = zeros(1,0);
    end
    
    % Check visibility to other vertices considering edges in S list
    for i = 1:num_v
        % Get vertex index
        other_v = sorted_list(i,2);
        if (v ~= other_v)   
            is_visible = true;
            % Check if visible, if visible add to visible list
            if numel(S) > 0 % If S list is not empty
                for S_element = 1:numel(S) % Check each edge in S list
                    x1 = vertices(v,1);
                    y1 = vertices(v,2);
%                     x2 = 2*vertices(other_v,1) - vertices(v,1); % extend
%                     y2 = 2*vertices(other_v,2) - vertices(v,2); % extend
                    x2 = vertices(other_v,1); % extend
                    y2 = vertices(other_v,2); % extend
                    x3 = edge_list(S(S_element),1);
                    y3 = edge_list(S(S_element),2);
                    x4 = edge_list(S(S_element),3);
                    y4 = edge_list(S(S_element),4);

                    [XI,YI] = polyxpoly([x1 x2],[y1 y2],[x3 x4],[y3 y4]);

                    dis_to_other_v = norm([(x1-x2),(y1-y2)]);
                    dis_to_edge = norm([(x1-XI),(y1-YI)]);

                    % If edge is found, add to visibility_graph
                    if (dis_to_other_v > dis_to_edge) && (dis_to_edge ~= 0)
                        is_visible = false;
                        break;
                    end
                end
            end 
            
            % Add to visibility graph
            if is_visible == true
                % To avoid duplicates, check for mirrored version
                found = false;
                for j = 1:size(visibility_graph,1)
                    if (visibility_graph(j,1) == other_v) && (visibility_graph(j,2) == v)
                        found = true;
                        break;
                    end
                end
                if found == false
                    visibility_graph = [visibility_graph;v other_v];
                end
            end

            % Add and remove edges from S list as necessary avoiding
            % duplicates
            for j = 1:2
                edge = edges_connected_to_v(other_v,j);
                if (edge ~= 0) && (edge ~= edges_connected_to_v(v,1)) && (edge ~= edges_connected_to_v(v,2))
                    index = find(S==edge);
                    if numel(index) == 0
                        S = [S edge];
                    else
                        S = [S(1:index-1), S(index+1:end)];
                    end
                end
            end
        end

    end
    clear S;
end

edges = [];

% Clean edges inside polygons
for e = 1:size(visibility_graph,1)
    % If vertices belong to same polygon
    if vertices(visibility_graph(e,1),3) == vertices(visibility_graph(e,2),3)
        % Add only if vertices are adjascent
        px = (vertices(visibility_graph(e,1),1)+vertices(visibility_graph(e,2),1))/2;
        py = (vertices(visibility_graph(e,1),2)+vertices(visibility_graph(e,2),2))/2;
        polygon = vertices(visibility_graph(e,1),3);
        poly_vertices = find(vertices(:,3) == polygon);
        polygon_x = vertices(poly_vertices,1);
        polygon_y = vertices(poly_vertices,2);
        [in, on] = inpolygon(px,py,polygon_x,polygon_y);
        if on == 1
            edges = [edges; visibility_graph(e,:)];
        elseif in == 0
            edges = [edges; visibility_graph(e,:)];
        end
    else
        edges = [edges; visibility_graph(e,:)];
    end
end

end