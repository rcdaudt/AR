function [path,minCost]=Astar(vertices, edges)
    % Implementation of A* graph search algorithm
    % Daudt - 15/04/16
    % Variables:
    % vertices - list of vertices of the objects in the map
    % edges - visibility graph edges
    % path - sequential list of vertices to move optimally from start to goal
    % minCost - minimum distance from start to goal

    % Only coordinates are important for A*
    vertices = vertices(:,1:2);

    % Number of vertices
    N = size(vertices,1);

    % Get start and goal points
    start = vertices(1,:);
    goal = vertices(end,:);

    % Initialize variables for A*
    path = -1; minCost = -1;
    closedset = [];
    openset = 1; % Uses indices from vertices variable
    came_from = zeros(1,size(vertices,1));
    g_score = zeros(1,size(vertices,1));
    f_score = zeros(1,size(vertices,1));
    f_score(1) = heuristic(start,goal);

    while numel(openset) > 0
        % Get current vertex
        current = openset(1);

        % Check if goal has been reached
        if current == N
            path = reconstruct_path(came_from,N);
            break;
        end

        % Move current from openset to closedset
        openset = openset(2:end);
        closedset = [closedset current];

        % Find neighbours
        [r,c] = find(edges == current);

        % For each neighbour
        for i = 1:numel(r)
            % Get neighbour index
            neighbour = edges(r(i),3-c(i));

            tentative_g_score = g_score(current) + norm(vertices(current,:) - vertices(neighbour,:));

            in_closed = find(closedset == neighbour);
            if numel(in_closed) > 0
                if tentative_g_score >= g_score(neighbour)
                    continue;
                end
            end

            in_open = find(openset == neighbour);
            if numel(in_open)==0 || tentative_g_score < g_score(neighbour)
                came_from(neighbour) = current;
                g_score(neighbour) = tentative_g_score;
                f_score(neighbour) = g_score(neighbour) + heuristic(vertices(neighbour,:),goal);

                if numel(in_open) == 0
                    if numel(openset) == 0
                        openset = neighbour;
                    else
                        added = false;
                        for j = 1:numel(openset)
                            if f_score(openset(j)) > f_score(neighbour)
                                openset = [openset(1:(j-1)) neighbour openset(j:end)];
                                added = true;
                                break;
                            end
                        end
                        if added == false
                            openset = [openset neighbour];
                        end
                    end
                end
            end
        end
    end

    % Get minCost for calculated path
    for i = 1:(numel(path)-1)
        minCost = minCost + norm(vertices(path(i),:) - vertices(path(i+1),:));
    end

end

function h = heuristic(p,goal)
    h = norm(p-goal);
end

function path = reconstruct_path(came_from, current_node)
    if came_from(current_node) > 0
        p = reconstruct_path(came_from,came_from(current_node));
        path = [p current_node];
    else
        path = current_node;
    end
end

























