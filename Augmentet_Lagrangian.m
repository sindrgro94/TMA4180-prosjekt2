function svar = Augmentet_Lagrangian(THETA,L,P,tol,max_iter)
TOL = 0.01;
my = 1;
[n,s] = size(THETA);
lambdas = ones(s,2);
k = 0;
while norm(dLag(THETA,lambdas,L,P,my)) > TOL && max_iter > k
    k = k+1;
    [THETA,rounds] = gradient_descent(THETA,lambdas,L,P,my, tol, max_iter);
    for j = 1:s
        [c_x,c_y] = c(j,THETA,L, P);
        lambdas(j,1) = lambdas(j,1)-my*c_x;
        lambdas(j,2) = lambdas(j,2)-my*c_y;
    end
    my = my*2;
    tol = tol/2;
    norm(dLag(THETA,lambdas,L,P,my))
end
svar = THETA;
end