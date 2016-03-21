function [value_map, trajectory] = wavefront(map, start, goal)
% Wavefront path planning
% Rodrigo Daudt
    
    % Initialise value_map
    value_map = map;
    value_map(goal(1),goal(2)) = 2;
    
    % Find map size
    s = size(map);
    
    % Offsets for neighbours
    N = [1 0;-1 0;0 1;0 -1;1 1;1 -1;-1 1;-1 -1];
    
    
    cl = 3; % Current label
    queue = [goal(1) goal(2)]; % Current level queue
    next_queue = []; % Next level queue
    
    while size(queue,1) > 0
        for i = 1:size(queue,1)
            for neigh = 1:size(N,1)
                v = queue(i,1) + N(neigh,1);
                h = queue(i,2) + N(neigh,2);
                if v>=1 && v<= s(1) && h>=1 && h<=s(2)
                    if value_map(v,h)==0
                        value_map(v,h) = cl;
                        next_queue = [next_queue;v h];
                    end
                end
            end
        end
        cl = cl + 1;
        queue = next_queue;
        next_queue = [];
    end
    
    % Find trajectory
    cp = start; % current point
    trajectory = [start(1) start(2)];
    
    while value_map(cp(1),cp(2)) ~= 2
        for i = 1:size(N,1)
            % Neighbour coordinates
            v = cp(1) + N(i,1);
            h = cp(2) + N(i,2);
            if v>=1 && v<= s(1) && h>=1 && h<=s(2)
                if value_map(v,h) == (value_map(cp(1),cp(2))-1)
                    cp = [v h];
                    trajectory = [trajectory;cp];
                    break;
                end
            end
        end
    end

end

