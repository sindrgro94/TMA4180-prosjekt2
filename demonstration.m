%% Demonstration
% This script can run different parts of the project. Each section is
% independent with its own description.
close all
clear all
clc
%% Task 1 Augmented lagrangian for only equality constraints
close all
clear all
clc
L = [3;2;2];
P = [5,4,6,4,5;0,2,0.5,-2,-1];
THETA = ones(length(L),length(P));
[~,points] = size(P);
for point = 1:points
    if P(2,point)<0
        THETA(:,point) = THETA(:,point)*(-0.1);
    else
        THETA(:,point) = THETA(:,point)*(0.1);
    end
end
max_iter = 1000;
answer = Augmentet_Lagrangian(THETA,L,P,max_iter);
plotHandMovement(answer,L,P);

%% Task2 Augmented lagrangian for both equality and inequality
% To make the method terminate and don't use too long time, the tolerance for the 2-norm of the gradient
% to the lagrangian is set to 0.15 and stepSelection is false meaning we use
% only backtracking. If stepSelection is set to true, the method uses
% find_alpha_constrained.m wich should choose better stepsizes but after
% some iterations it will manage to find a stepsize to make both
% wolfe-conditions satisfied.
close all
clear all
clc
stepSelection = true;
L = [3;2;2];
P = [5,4,6,4,5;0,2,0.5,-2,-1];
% P = [9,4,6,4,5;0,2,0.5,-2,-1]; %this will terminate early because of the first point (9,0)
% P = [-1,-3,-3,0,5;5,3,-4,5,2];
THETA = ones(length(L),length(P));
[~,points] = size(P);
for point = 1:points
    if P(2,point)<0
        THETA(:,point) = THETA(:,point)*(-0.1);
    else
        THETA(:,point) = THETA(:,point)*(0.1);
    end
end
max_iter = 1000;
angle = pi/2;
answer = BC_Augmented_Lagrangian(THETA,L,P,angle,max_iter,stepSelection); %time?1min
if sum([1 1] == size(answer)) ~= 2
    plotHandMovement(answer,L,P);
end
%% function plotting the configuration space for a general arm and angle
% The function uses brute force meaning arms with four joints takes
% approximately 1min to draw the config. space and more joints than this is
% not recommended.
close all
clear all
clc
L = [3;2;2]; %arm lengths
P = [5,4,6,4,5;0,2,0.5,-2,-1]; %checking points
c = pi/3; %angular con
plotOrNot = true;
countdown = true;
configSpaceGeneral(L,c,P,plotOrNot,countdown)