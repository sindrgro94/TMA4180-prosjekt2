function svar = Augmentet_Lagrangian(THETA,L,P,tol,max_iter)
%Framework 17.3
TOL = 0.01;
my = 1;
[~,s] = size(THETA);
lambdas = ones(s,2);
k = 0;
while norm(dLag(THETA,lambdas,L,P,my)) > TOL && max_iter > k
    k = k+1;
    [THETA,rounds] = gradient_descent(THETA,lambdas,L,P,my, tol, max_iter);
    norm(dLag(THETA,lambdas,L,P,my))
    for j = 1:s
        [c_x,c_y] = c(j,THETA,L, P);
        lambdas(j,1) = lambdas(j,1)-my*c_x;
        lambdas(j,2) = lambdas(j,2)-my*c_y;
    end
    my = max(max(abs(lambdas)));
    tol = tol/2;
    norm(dLag(THETA,lambdas,L,P,my))
end
svar = THETA;
end