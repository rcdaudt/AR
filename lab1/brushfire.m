function [value_map] = brushfire(map)
% Brushfire algorithm for repulsive potential
% Rodrigo Daudt

    % Initialise value_map
    value_map = map;

    % Find initial values
    s = size(map);
    initials = find(map==1);
    [queue(:,1) queue(:,2)] = ind2sub(s,initials);
    
    % Offsets for neighbours
    N = [1 0;-1 0;0 1;0 -1;1 1;1 -1;-1 1;-1 -1];
    
    cl = 2; % Current label
    next_queue = [];
    
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

end

