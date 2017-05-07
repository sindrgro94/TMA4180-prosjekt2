function svar = barrier_method(THETA,L,P,angle,max_iter)
%Framework 17.3
%%Tester om noen punkter er utenfor
%%Initialiserer 
TOL = 0.01;
my = 0.1;
beta = 1;
[~,s] = size(THETA);
lambdas = ones(s,2);
[~,tol] = update_lambdas_tol(THETA,lambdas,L,P,my);
k = 0;
Augmentet Lagrangian
while norm(bar_dLag(THETA,lambdas,L,P,my,beta, angle)) > TOL && max_iter > k
    k = k+1;
    %THETA = Augmentet_Lagrangian(THETA,L,P,max_iter);
    [THETA] = bar_quasi_Newton(THETA,lambdas,L,P,my, beta, angle, tol);
    [lambdas,tol] = update_lambdas_tol(THETA,lambdas,L,P,my);
    beta = beta/5;
    my = my*1.5;
    %my = my*2;
    dd = norm(bar_dLag(THETA,lambdas,L,P,my,beta, angle))
    
end
svar = THETA;
plotHandMovement(THETA,L,P)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [lambdas,tol] = update_lambdas_tol(THETA,lambdas,L,P,my)
    [~,s] = size(THETA);
    tol = 0;
        for j = 1:s
            [c_x,c_y] = c(j,THETA,L, P);
            lambdas(j,1) = lambdas(j,1)-my*c_x;
            lambdas(j,2) = lambdas(j,2)-my*c_y;
            tol = (tol +abs(c_x)+abs(c_y));
        end
end