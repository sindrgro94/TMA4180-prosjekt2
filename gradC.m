function [vec_C_x,vec_C_y] = gradC(j,THETA,L, P)
[n,s] = size(THETA);
vec_C_x = zeros(n*s,1);
vec_C_y = zeros(n*s,1);
thetasum = cumsum(THETA(:,j));
L_cos_theta = L(:,j).*cos(thetasum);
L_sin_theta = L(:,j).*sin(thetasum);
pos_arm = [sum(L_cos_theta),sum(L_sin_theta)];

X = flip(L_sin_theta);
X = -cumsum(X); %Flippes senere i dtheta

Y = flip(L_cos_theta);
Y = cumsum(Y); %Flippes senere i dtheta


temp_x = flip(X.*(pos_arm(1)-P(1,j)));
temp_y = flip(Y.*(pos_arm(2)-P(2,j)));

vec_C_x(n*(j-1)+1:n*j) = temp_x;
vec_C_x(n*(j-1)+1:n*j) = temp_y;

end