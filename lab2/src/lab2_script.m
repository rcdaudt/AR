% AR Lab 2
% Daudt
% 11/03/16

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
        
vertices4 = [0.1406	0.8843	0;
            0.3151  0.8183  1;
            0.1885  0.4039  1;
            0.5511  0.7418  1;
            0.2873  0.6360  1;
            0.3410  0.7189  2;
            0.7599  0.9815  2;
            0.6267  0.4587  2;
            0.5882  0.8374  2;
            0.6993	0.3798	3];
        
%% Plot environment

vertices = vertices4;

figure;
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

%% RPS

visibility_graph = RPS(vertices);
for i = 1:size(visibility_graph,1)
    x1 = vertices(visibility_graph(i,1),1);
    x2 = vertices(visibility_graph(i,2),1);
    y1 = vertices(visibility_graph(i,1),2);
    y2 = vertices(visibility_graph(i,2),2);
    if vertices(visibility_graph(i,1),3) ~= vertices(visibility_graph(i,2),3)
        plot([x1 x2],[y1 y2],'r');
    end
end

































