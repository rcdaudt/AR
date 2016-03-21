% AR lab1
% Daudt

clear all
close all
clc

%% Load data

data = load('basic.mat');
basic = data.map;
data = load('maze.mat');
maze = data.map;
data = load('mazeBig.mat');
mazeBig = data.map;
data = load('obstaclesBig.mat');
obstaclesBig = data.map;
clear data;
display('Loaded data');

%% Apply brushfire

tic
basic_bf = brushfire(basic);
toc
figure;
imagesc(basic_bf);
% imwrite(255*(basic_bf-1)/(max(max(basic_bf))-1),jet(256),'basic_bf.png');
display('Brushfire basic');

tic
maze_bf = brushfire(maze);
toc
figure;
imagesc(maze_bf);
% imwrite(255*(maze_bf-1)/(max(max(maze_bf))-1),jet(256),'maze_bf.png');
display('Brushfire maze');

tic
mazeBig_bf = brushfire(mazeBig);
toc
figure;
imagesc(mazeBig_bf);
% imwrite(255*(mazeBig_bf-1)/(max(max(mazeBig_bf))-1),jet(256),'mazeBig_bf.png');
display('Brushfire mazeBig');

tic
obstaclesBig_bf = brushfire(obstaclesBig);
toc
figure;
imagesc(obstaclesBig_bf);
% imwrite(255*(obstaclesBig_bf-1)/(max(max(obstaclesBig_bf))-1),jet(256),'obstaclesBig_bf.png');
display('Brushfire obstaclesBig');

%% Apply wavefront

tic
[basic_wf,basic_tr] = wavefront(basic, [13, 2], [3, 18]);
toc
figure;
imagesc(basic_wf);
hold on;
plot(basic_tr(:,2),basic_tr(:,1),'r','LineWidth',3);
scatter(basic_tr(1,2),basic_tr(1,1),'k','filled');
scatter(basic_tr(end,2),basic_tr(end,1),'y','filled');

% basic_rt = 1-cat(3,basic,basic,basic);
% for i = 2:size(basic_tr,1)-1
%     basic_rt(basic_tr(i,1),basic_tr(i,2),[2 3]) = [0 0];
% end
% basic_rt(basic_tr(1,1),basic_tr(1,2),[1 3]) = [0 0];
% basic_rt(basic_tr(end,1),basic_tr(end,2),[1 2]) = [0 0];
% imshow(basic_rt)

%%

tic
[maze_wf,maze_tr] = wavefront(maze, [45, 4], [5, 150]);
toc
figure;
imagesc(maze_wf);
hold on;
plot(maze_tr(:,2),maze_tr(:,1),'r','LineWidth',3);
scatter(maze_tr(1,2),maze_tr(1,1),'k','filled');
scatter(maze_tr(end,2),maze_tr(end,1),'y','filled');

% maze_rt = 1-cat(3,maze,maze,maze);
% for i = 2:size(maze_tr,1)-1
%     maze_rt(maze_tr(i,1),maze_tr(i,2),[2 3]) = [0 0];
% end
% maze_rt(maze_tr(1,1),maze_tr(1,2),[1 3]) = [0 0];
% maze_rt(maze_tr(end,1),maze_tr(end,2),[1 2]) = [0 0];
% imshow(maze_rt)

%%

tic
[mazeBig_wf,mazeBig_tr] = wavefront(mazeBig, [671 16], [18 788]);
toc
figure;
imagesc(mazeBig_wf);
hold on;
plot(mazeBig_tr(:,2),mazeBig_tr(:,1),'r','LineWidth',3);
scatter(mazeBig_tr(1,2),mazeBig_tr(1,1),'k','filled');
scatter(mazeBig_tr(end,2),mazeBig_tr(end,1),'y','filled');

% mazeBig_rt = 1-cat(3,mazeBig,mazeBig,mazeBig);
% for i = 2:size(mazeBig_tr,1)-1
%     mazeBig_rt(mazeBig_tr(i,1),mazeBig_tr(i,2),[2 3]) = [0 0];
% end
% mazeBig_rt(mazeBig_tr(1,1),mazeBig_tr(1,2),[1 3]) = [0 0];
% mazeBig_rt(mazeBig_tr(end,1),mazeBig_tr(end,2),[1 2]) = [0 0];
% imshow(mazeBig_rt)

%% 

tic
[obstaclesBig_wf,obstaclesBig_tr] = wavefront(obstaclesBig, [15 16], [668 788]);
toc
figure;
imagesc(obstaclesBig_wf);
hold on;
plot(obstaclesBig_tr(:,2),obstaclesBig_tr(:,1),'r','LineWidth',3);
scatter(obstaclesBig_tr(1,2),obstaclesBig_tr(1,1),'k','filled');
scatter(obstaclesBig_tr(end,2),obstaclesBig_tr(end,1),'y','filled');

% obstaclesBig_rt = 1-cat(3,obstaclesBig,obstaclesBig,obstaclesBig);
% for i = 2:size(obstaclesBig_tr,1)-1
%     obstaclesBig_rt(obstaclesBig_tr(i,1),obstaclesBig_tr(i,2),[2 3]) = [0 0];
% end
% obstaclesBig_rt(obstaclesBig_tr(1,1),obstaclesBig_tr(1,2),[1 3]) = [0 0];
% obstaclesBig_rt(obstaclesBig_tr(end,1),obstaclesBig_tr(end,2),[1 2]) = [0 0];
% imshow(obstaclesBig_rt)