function svar = Augmentet_Lagrangian(THETA,L,P,max_iter)
%Framework 17.3
%%Tester om noen punkter er utenfor
if is_Outside(L,P) == true
    fprintf('At least one of the points are outside, no solution exist.\n');
    return
else

%%Initialiserer 
TOL = 0.01;
my = 1;
[~,s] = size(THETA);
lambdas = ones(s,2);
tol = 0;
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    tol = tol +abs(c_x)+abs(c_y);
end
k = 0;
%%Augmentet Lagrangian
while norm(dLag(THETA,lambdas,L,P,my)) > TOL && max_iter > k
    k = k+1;
    %[THETA,rounds] = gradient_descent(THETA,lambdas,L,P,my, tol);
    [THETA] = quasi_Newton(THETA,lambdas,L,P,my, tol);
    %tol_old = tol;
    tol = 0;
    for j = 1:s
        [c_x,c_y] = c(j,THETA,L, P);
        lambdas(j,1) = lambdas(j,1)-my*c_x;
        lambdas(j,2) = lambdas(j,2)-my*c_y;
        tol = (tol +abs(c_x)+abs(c_y));
    end
    my = my*2;
    dd = norm(dLag(THETA,lambdas,L,P,my))
    
end
svar = THETA;
plotHandMovement(THETA,L,P)
end