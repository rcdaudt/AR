function [vertices,edges,path]=rrt(map,q_start,q_goal,k,delta_q,p);
% RRT trajectory planning implementation
% Rodrigo Daudt
% 01/04/16

map = map'; % To solve problems between carthesian and matricial coordinates
s = size(map);

% Initialise arrays for outputs
vertices = zeros(k+1,2); vertices(1,:) = q_start;
edges = zeros(k,2);
path = zeros(1,k);
last_added_vertex = 1;

% Loop through RRT k times
for i = 1:k
    
    
    if rand() <= p
        q_rand = q_goal;
    else
        % New random point in considered range
        q_rand = max(rand(1,2).*s,[1,1]); % max function used to avoid eventual 0 index
    end
%     vertices(i+1,:) = q_rand;
    
    % Find index of closest vertex to q_rand
    min_d = sum(s);
    index = 0;
    for vertex = 1:last_added_vertex
        dist_v = norm(q_rand - vertices(vertex,:));
        if dist_v < min_d
            min_d = dist_v;
            index = vertex;
        end
    end
    
    
    % Generate q_new at distance delta_q from closest vertex in direction
    % of q_rand and add to vertices list
    dxy = q_rand - vertices(index,:);
    q_new = vertices(index,:) + delta_q*dxy/norm(dxy);
    
    added = false;
    if is_visible(map,vertices(index,:),q_new)
        last_added_vertex = last_added_vertex + 1;
        vertices(last_added_vertex,:) = q_new;
        edges(last_added_vertex-1,:) = [last_added_vertex, index];
        added = true;
    end
    
    % TODO: Check if we reached the end
    % check distance from q_new to q_goal
    % if distance < delta_q create edge between q_new and q_goal
    if added == true
        if norm(q_new - q_goal) < delta_q
            if is_visible(map,q_new,q_goal)
                last_added_vertex = last_added_vertex + 1;
                vertices(last_added_vertex,:) = q_goal;
                edges(last_added_vertex-1,:) = [last_added_vertex, last_added_vertex-1];
                break;
            end
        end
    end
    

end

% Clean vertices and edges arrays
vertices = vertices(find(vertices(:,1) ~= 0),:);
edges = edges(find(edges(:,1) ~= 0),:);

% TODO: find trajectory
path = last_added_vertex;
vertex = last_added_vertex;
while edges(vertex-1,2) ~= 1
    vertex = edges(vertex-1,2);
    path = [path vertex];
end
path = [path 1];

% If we want the trajectory from start to goal, uncomment:
path = fliplr(path);

end



function visible = is_visible(map,q,q_new)

x = linspace(q(1),q_new(1),11);
y = linspace(q(2),q_new(2),11);

visible = true;
for i = 2:11
    if map(ceil(x(i)),ceil(y(i))) == 1
        visible = false;
        break;
    end
end

end