function THETA = BC_Augmented_Lagrangian(THETA,L,P,angle,max_iter)
[n,s] = size(THETA);
lambdas = ones(s,2);
THETA = getInitialValues(THETA,L,P,angle);
lambdas_constr = zeros(n*s,1);
my = 1;
TOL = 0.01;
[lambdas,lambdas_constr,tol] = update_lambdas_tol(THETA,lambdas,lambdas_constr,L,P,my, angle);
k = 0;
dd = norm(dLag(THETA,lambdas,L,P,my));
while norm(dd) > TOL;
    [THETA] = constr_quasi_Newton(THETA,lambdas,lambdas_constr,L,P,my, tol, angle);
    tol_old = tol;
    [lambdas,lambdas_constr,tol] = update_lambdas_tol(THETA,lambdas,lambdas_constr,L,P,my, angle);
    if tol > tol_old
        my = my*1.5;
    end
    k = k+1;
end

end

function [lambdas,lambdas_constr,tol] = update_lambdas_tol(THETA,lambdas,lambdas_constr,L,P,my, angle)
[~,s] = size(THETA);
tol = 0;
    for j = 1:s
        [c_x,c_y] = c(j,THETA,L, P);
        lambdas(j,1) = lambdas(j,1)-my*c_x;
        lambdas(j,2) = lambdas(j,2)-my*c_y;
        tol = (tol +abs(c_x)+abs(c_y));
    end
    lambdas_constr = lambdas_constr-my*constr_c(THETA,angle);
end

function THETA = getInitialValues(THETA,L,p,angle)
[joints,points] = size(THETA);
TOL = 0.01;
max_iter = 1000;
for point = 1:points    
    k = 0;
    beta = 1;
    while norm(derivativeP(THETA(:,point),beta,L,p(:,point),angle)) > TOL && max_iter > k
        k = k+1;
        [THETA(:,point)] = quasiNewton(THETA(:,point),L,p(:,point), beta, angle, TOL);
        beta = beta/5;
    end
end
end
function [THETA] = quasiNewton(THETA,L,p, beta, angle, tol)
max_iter = 1000;
[n,s] = size(THETA);
%Dette er de to funksjonene
dd = derivativeP(THETA,beta,L,p,angle);

fx = @(theta,L,p,beta,vec_u,vec_l) 1/2*norm([sum(L.*cos(cumsum(theta))),...
    sum(L.*sin(cumsum(theta)))]-p')^2 - beta*sum(log([vec_u;vec_l]));
%Initialiazing values
I = eye(n*s)*0.001;
H = I;
k = 0;
c1 = 10^-4;
rho = 1/2;
rok = 0;
while norm(dd) > tol && k<=max_iter
    if rok > 10^12
        H = I;
    end
    alpha = 1;
    k = k+1;
    %Initial step length and direction
    pk = -H*dd;
    %finding step length
    [vec_u,vec_l] = constraints(THETA, angle);
    while fx(THETA+alpha*reshape(pk,n,s),L,p,beta,vec_u,vec_l) > fx(THETA,L,p,beta,vec_u,vec_l)+alpha*c1*dot(-pk,pk) %Armijo condition
        alpha = rho*alpha;
    end
    %Updating x
    %Updating H
    if alpha < 10^-12
        break;
    end
    sk = alpha*pk;
    pk = reshape(pk,n,s);
    THETA = THETA + alpha*pk;
    yk = (derivativeP(THETA+alpha*pk,beta,L,p, angle)-dd);
    rok = 1/dot(yk,sk);
    zk = (H*yk);
    H = H - rok*(sk*zk' + zk*sk') + (rok^2*dot(yk,zk)+rok)*(sk*sk');
    %Updating dd
    dd = derivativeP(THETA,beta,L,p, angle);
end 
end
function answer = derivativeP(THETA,beta,L,P,angle)
    [vec_u,vec_l] = constraints(THETA, angle);
    answer = robot_gradient(THETA,L,P) - beta*(-vec_u.^-1+vec_l.^-1);
end
function dtheta = robot_gradient(theta, L ,p)
%% Preconditions 
%theta - the angels between each segment
%L - Column ector of length segments
%p - desired point
%% Postconditions
%dtheta - the gradient of the function
%% Finding the gradient
THETA = cumsum(theta);
L_cos_theta = L.*cos(THETA);
L_sin_theta = L.*sin(THETA);
pos_arm = [sum(L_cos_theta),sum(L_sin_theta)];

X = flip(L_sin_theta);
X = -cumsum(X); %Flippes senere i dtheta

Y = flip(L_cos_theta);
Y = cumsum(Y); %Flippes senere i dtheta


dtheta = (flip(X.*(pos_arm(1)-p(1))+Y.*(pos_arm(2)-p(2))));

end