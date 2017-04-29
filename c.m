function [c_x,c_y] = c(j,THETA,L, P)
    F = robot_arm2(THETA(:,j),L(:,j));
    c_x = F(1)-P(1,j);
    c_y = F(2)-P(2,j);
end
function final_pos = robot_arm2(theta,L)
% Kan sende in theta = [30,30,30] og L = [1,1,1]
%Plotter en graf som visualiserer robotarmen
q = zeros(length(theta),2);
THETA = cumsum(theta);
for i = 1:length(theta)
    q(i+1,1:2) = q(i,1:2)+L(i).*[cos(THETA(i)),sin(THETA(i))];
end
final_pos = [sum(L.*cos(THETA)),sum(L.*sin(THETA))];
end