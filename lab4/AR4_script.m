% AR4 script
% Daudt
% 18/04/16

clear all
close all
clc

%% Build environment

vertices1 = [0.7807 9.0497  0;
            3.0322  8.9912  1.0000;
            1.3655  6.7105  1.0000;
            4.1140  4.0497  1.0000;
            6.2778  8.2310  1.0000;
            8.2953  5.8333  2.0000;
            5.6345  2.6170  2.0000;
            9.1433  1.9152  2.0000;
            11.4825 6.9444  2.0000;
            10.2544 0.5702  3.0000];

vertices2 = [0.6053  7.9971  0;
            1.0439  6.8567	1.0000;
            2.9737  8.2602  1.0000;
            3.9386  6.3304  1.0000;
            1.9795  5.3655  1.0000;
            6.4532  8.3187  2.0000;
            5.1959  6.6228  2.0000;
            8.7339  6.2719  2.0000;
            8.4708  7.8801  2.0000;
            3.2368  4.8684  3.0000;
            0.8684  3.9620  3.0000;
            1.2485  2.5585  3.0000;
            3.3538  2.4123  3.0000;
            4.8450  4.0497  3.0000;
            6.5994  3.9327  4.0000;
            6.5409  2.0906  4.0000;
            8.5877  2.2076  4.0000;
            8.6170  4.6053  4.0000;
            9.4357  7.2368  5.0000;
            11.1608 4.0789  5.0000;
            10.3129 7.9094  5.0000;
            10.3713 1.5351  6.0000];
        
vertices3 = [0.7807 9.0497  0;
            3.0322  8.9912  1.0000;
            1.3655  6.7105  1.0000;
            4.1140  4.0497  1.0000;
            6.2778  8.2310  1.0000;
            8.2953  5.8333  2.0000;
            5.6345  2.6170  2.0000;
            9.1433  1.9152  2.0000;
            7       3       2.0000;
            10.2544 0.5702  3.0000];
        
vertices4 = [0.1	0.7	0;
            0.3  0.8  1;
            0.2  0.2  1;
            0.55  0.75  1;
            0.35  0.5  1;
            0.37  0.65  2;
            0.3  0.95  2;
            0.6  0.9  2;
            0.5	0.5	3];
        
%% Setup environment and plotting

% Apply RPS
vertices = vertices4;
edges = RPS(vertices);

% Plot scene
close all;
figure(1);
hold on;
grid on;
N = max(vertices(:,3)); % Find range of objects (number of objects+1, start=0, goal=N)
for i = 0:N
    poly_ind = find(vertices(:,3)==i); % Find indices of polygon
    poly_coords = vertices(poly_ind,[1 2]); % Extract point coordinates
    poly_coords = [poly_coords;poly_coords(1,:)]; % Repeat initial point to close polygon
    plot(poly_coords(:,1),poly_coords(:,2),'b','LineWidth',2);
end
for i = 2:size(vertices,1)-1
    text(vertices(i,1),vertices(i,2),num2str(i));
end
scatter(vertices(1,1),vertices(1,2),'r+','LineWidth',3);
text(vertices(1,1),vertices(1,2),'Start');
scatter(vertices(end,1),vertices(end,2),'g+','LineWidth',3);
text(vertices(end,1),vertices(end,2),'Goal');
axis('equal');

% Plot visible connexions
for i = 1:size(edges,1)
    x1 = vertices(edges(i,1),1);
    x2 = vertices(edges(i,2),1);
    y1 = vertices(edges(i,1),2);
    y2 = vertices(edges(i,2),2);
    plot([x1 x2],[y1 y2],'r');
end

%% Apply A*

[path,minCost] = Astar(vertices,edges);

for i = 1:(numel(path)-1)
    x1 = vertices(path(i),1);
    y1 = vertices(path(i),2);
    x2 = vertices(path(i+1),1);
    y2 = vertices(path(i+1),2);
    plot([x1 x2],[y1 y2],'g','linewidth',2);
end










































