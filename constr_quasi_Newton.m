function [THETA] = constr_quasi_Newton(THETA,lambdas,lambdas_constr,L,P,my, tol, angle)
tic
max_iter = 1000;
[n,s] = size(THETA);
%Dette er de to funksjonene
dd = dLag(THETA,lambdas,L,P,my);
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
    while constr_Lag(THETA+alpha*reshape(pk,n,s),lambdas,lambdas_constr,L,P,my,angle) > constr_Lag(THETA,lambdas,lambdas_constr,L,P,my,angle)+alpha*c1*dot(-pk,pk) %Armijo condition
        alpha = rho*alpha;
    end
    if alpha < 10^-12
        fprintf('Break\n')
        break;
    end
    %Updating x
    %Updating H
    sk = alpha*pk;
    pk = reshape(pk,n,s);
    THETA = THETA + alpha*pk;
    yk = (dLag(THETA+alpha*pk,lambdas,L,P,my)-dd);
    rok = 1/dot(yk,sk);
    zk = (H*yk);
    H = H - rok*(sk*zk' + zk*sk') + (rok^2*dot(yk,zk)+rok)*(sk*sk');
    %Updating dd
    dd = dLag(THETA,lambdas,L,P,my);
end 
toc


end