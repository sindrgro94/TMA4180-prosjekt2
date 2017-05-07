function [THETA] = bar_quasi_Newton(THETA,lambdas,L,P,my, beta, angle, tol)
tic

max_iter = 1000;
[n,s] = size(THETA);
%Dette er de to funksjonene
dd = bar_dLag(THETA,lambdas,L,P,my,beta, angle);
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
    while bar_lag(THETA+alpha*reshape(pk,n,s),lambdas,L,P,my,beta,angle) > bar_lag(THETA,lambdas,L,P,my,beta,angle)+alpha*c1*dot(-pk,pk) %Armijo condition
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
    yk = (bar_dLag(THETA+alpha*pk,lambdas,L,P,my,beta, angle)-dd);
    rok = 1/dot(yk,sk);
    zk = (H*yk);
    H = H - rok*(sk*zk' + zk*sk') + (rok^2*dot(yk,zk)+rok)*(sk*sk');
    %Updating dd
    dd = bar_dLag(THETA,lambdas,L,P,my,beta, angle);
end 
toc


end