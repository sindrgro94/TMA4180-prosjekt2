%% Correct form for different variables:
% theta = mxn matrix where each column are all the angles to reach a point 
% and each row are the angle at each joint.
% L = row vector with all the robot arm lengths
% p = 2xn matrix that contains all the n points the robot arm reaches.
% first row is x-value, second is y-value.
% lambda = sx2 matrix with first column for x and second for y. s points
% gives s rows.

% THETA = [-0.7299, 0.393, -0.7299, 0.393; 2.6720, 0.6102, -0.7299, 0.393; 4.1429, 2.2085, -0.7299, 0.393];
% P = [1,1,0.5,-0.5;1,2,0.5,-1];
% L = [1;2;1];
close all
clear all
clc
L = [3,2,2]';
% P = [5,4,6,4;0,2,0.5,-2];
P = [-1,-3,-3,0,5;5,3,-4,5,2];
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
%svar = Augmentet_Lagrangian(THETA,L,P,max_iter);
svar = BC_Augmented_Lagrangian(THETA,L,P,angle,max_iter);
% plotHandMovement(svar,L,P)
%makeRobotPlot4(svar,L,P);
makeRobotPlot5(svar,L,P);