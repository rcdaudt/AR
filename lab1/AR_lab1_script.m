% AR lab1

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

%% Apply brushfire

tic
basic_bf = brushfire(basic);
toc
figure;
imagesc(basic_bf);

tic
maze_bf = brushfire(maze);
toc
figure;
imagesc(maze_bf);

tic
mazeBig_bf = brushfire(mazeBig);
toc
figure;
imagesc(mazeBig_bf);

tic
obstaclesBig_bf = brushfire(obstaclesBig);
toc
figure;
imagesc(obstaclesBig_bf);

%% Apply wavefront

tic
[basic_wf,basic_tr] = wavefront(mazeBig, [671 16], [18 788]);
toc
figure;
imagesc(basic_wf);
hold on;

plot(basic_tr(:,2),basic_tr(:,1),'r','LineWidth',3);

%% 

tic
[basic_wf,basic_tr] = wavefront(obstaclesBig, [15 16], [668 788]);
toc
figure;
imagesc(basic_wf);
hold on;

plot(basic_tr(:,2),basic_tr(:,1),'r','LineWidth',3);