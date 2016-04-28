function [path_smooth] = smooth(map_in,path,vertices,delta)
% Smoothes path given by RRT function

if numel(path) == 0
    path_smooth = [];
    return;
end

map = map_in';
path_smooth = path(1);
N = size(path,2);
reached_end = false;
last_added = 1;

while reached_end == false
    
    added = false;
    for i = N:-1:(last_added+2)
        if is_visible(map,vertices(path(last_added),:),vertices(path(i),:),delta)
            path_smooth = [path_smooth path(i)];
            last_added = i;
            added = true;
            break;
        end
    end
    
    if added == false
        path_smooth = [path_smooth path(last_added+1)];
        last_added = last_added + 1;
    end
    
    reached_end = last_added == N;
end
end

function visible = is_visible(map,q,q_new,delta)
d = norm(q - q_new);
num_steps = ceil(d/delta) + 2;

x = ceil(linspace(q(1),q_new(1),num_steps));
y = ceil(linspace(q(2),q_new(2),num_steps));

visible = true;
for i = 1:num_steps
    if map(x(i),y(i)) == 1
        visible = false;
        break;
    end
end
end