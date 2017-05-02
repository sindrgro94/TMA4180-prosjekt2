function THETA = BC_Augmented_Lagrangian(THETA,L,P,angle,max_iter)
[n,s] = size(THETA);
lambdas = ones(s,2);
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
    dd = norm(dLag(THETA,lambdas,L,P,my))
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