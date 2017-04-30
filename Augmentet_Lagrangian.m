function svar = Augmentet_Lagrangian(THETA,L,P,tol,max_iter)
%Framework 17.3
%%Tester om noen punkter er utenfor
if is_Outside(L,P) == true
    fprintf('Et av punktene er utenfor, ingen løsning finnes.\n');
    return
else
%%Initialiserer 
TOL = 0.01;
my = 1;
[~,s] = size(THETA);
lambdas = ones(s,2);
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    tol = tol +abs(c_x)+abs(c_y);
end
k = 0;
%%Augmentet Lagrangian
while norm(gradLag(THETA,lambdas,L,P,my)) > TOL && max_iter > k
    k = k+1;
    [THETA,~] = gradient_descent(THETA,lambdas,L,P,my, tol);
    tol_old = tol;
    tol = 0;
    for j = 1:s
        [c_x,c_y] = c(j,THETA,L, P);
        lambdas(j,1) = lambdas(j,1)-my*c_x;
        lambdas(j,2) = lambdas(j,2)-my*c_y;
        tol = tol +abs(c_x)+abs(c_y);
    end
    if tol/tol_old > 0.95
        my = my*1.5;
    end
    %dd = norm(gradLag(THETA,lambdas,L,P,my))
    
end
svar = THETA;
end