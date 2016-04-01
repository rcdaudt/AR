% AR Lab 3
% Rodrigo Daudt
% 01/04/16

clear all
close all
clc

file  = load('map.mat');
map = file.map;
q_start_map = [80, 70]; % start is map(70,80)
q_goal_map = [707, 615]; % goal is map(615,707)
% figure(1);
% imshow(map);
% title('map');
% hold on;
% scatter(q_start_map(1),q_start_map(2),'r+','LineWidth',2);
% scatter(q_goal_map(1),q_goal_map(2),'g+','LineWidth',2);

pause(0.2)

file  = load('maze.mat');
maze = file.map;
q_start_maze = [206, 198]; % start is maze(198,206)
q_goal_maze = [416, 612]; % goal is maze(612,416)
% % maze(q_start_maze(2),q_start_maze(1)) = 1;
% % maze(q_goal_maze(2),q_goal_maze(1)) = 1;
% figure(2);
% imshow(maze);
% title('maze');
% hold on;
% scatter(q_start_maze(1),q_start_maze(2),'r+','LineWidth',2);
% scatter(q_goal_maze(1),q_goal_maze(2),'g+','LineWidth',2);


clear file;
display('Data was loaded');

%% Apply RRT - map

[vertices,edges,path]=rrt(map,q_start_map,q_goal_map,500,100,0.25);
figure(1);
imshow(1-map);
title('map');
hold on;

% Plot stuff to test
for i = 1:size(edges)
%     if edges(i,1) ~= 0
        x = [vertices(edges(i,1),1) vertices(edges(i,2),1)];
        y = [vertices(edges(i,1),2) vertices(edges(i,2),2)];
        plot(x,y,'b');
%     end
end

for i = 2:(size(vertices,1)-1)
    text(vertices(i,1),vertices(i,2),num2str(i));
end
text(vertices(1,1),vertices(1,2),'1 - Start');
text(vertices(end,1),vertices(end,2),[num2str(size(vertices,1)) ' - Goal']);

x = vertices(path,1);
y = vertices(path,2);
plot(x,y,'r','LineWidth',3);


scatter(q_start_map(1),q_start_map(2),'c+','LineWidth',2);
scatter(q_goal_map(1),q_goal_map(2),'g+','LineWidth',2);

%% Apply RRT - maze

[vertices,edges,path]=rrt(maze,q_start_maze,q_goal_maze,1000,100,0.25);
figure(1);
imshow(1-maze);
title('maze');
hold on;

% Plot stuff to test
for i = 1:size(edges)
%     if edges(i,1) ~= 0
        x = [vertices(edges(i,1),1) vertices(edges(i,2),1)];
        y = [vertices(edges(i,1),2) vertices(edges(i,2),2)];
        plot(x,y,'b');
%     end
end

for i = 2:(size(vertices,1)-1)
    text(vertices(i,1),vertices(i,2),num2str(i));
end
text(vertices(1,1),vertices(1,2),'1 - Start');
text(vertices(end,1),vertices(end,2),[num2str(size(vertices,1)) ' - Goal']);

x = vertices(path,1);
y = vertices(path,2);
plot(x,y,'r','LineWidth',3);


scatter(q_start_maze(1),q_start_maze(2),'c+','LineWidth',2);
scatter(q_goal_maze(1),q_goal_maze(2),'g+','LineWidth',2);
























