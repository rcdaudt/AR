function edges = RPS(vertices)
% Rotational Plane Sweep implementation

num_v = size(vertices,1);

% Initialize stuff
ang_to_v = zeros(num_v);
hor_intersect = cell(num_v,1);

for v = 1:num_v % For each vertex
    % Create sorted angle to vertex list
    for other_v = 1:num_v
        dx = vertices(other_v,1) - vertices(v,1);
        dy = vertices(other_v,2) - vertices(v,2);
        ang_to_v(v,other_v) = atan2(dy,dx);
    end
    
    % Create list of all edges that intersect horizontal half-line starting
    % at v
    
    % Use polyxpoly
    
end


edges = ang_to_v;


end

