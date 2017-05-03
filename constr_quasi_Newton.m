function [THETA] = constr_quasi_Newton(THETA,lambdas,lambdas_constr,L,P,my, tol, angle)
tic
max_iter = 200;
[n,s] = size(THETA);
%Dette er de to funksjonene
dd = constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle);
%Initialiazing values
I = eye(n*s);
H = I;
k = 0;
c1 = 10^-4;
rho = 1/2;
cnt = 0;
while norm(dd) > tol && k<=max_iter
%     if rok > 10^20
%         H = I;
%     end
    alpha = 1;
    k = k+1;
    %Initial step length and direction
    pk = -H*dd;
    %finding step length
    while constr_Lag(THETA+alpha*reshape(pk,n,s),lambdas,lambdas_constr,L,P,my,angle) > constr_Lag(THETA,lambdas,lambdas_constr,L,P,my,angle)+alpha*c1*dot(dd,pk) %Armijo condition
        alpha = rho*alpha;
    end
    if alpha < 10^-20
        fprintf('Break\n')
        break;
    end
    %Updating x
    %Updating H
    sk = alpha*pk;
    pk = reshape(pk,n,s);
    THETA = THETA + alpha*pk;
    yk = (constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle)-dd);
%     rok = 1/dot(yk,sk);
%     zk = (H*yk);
%     H = H - (sk*zk' + zk*sk')/dot(yk,sk) + (dot(yk,zk)+rok)*(sk*sk')/(dot(yk,sk)^2);
    
%     H = (I-1/dot(yk,sk)*sk*yk')*H*(I-1/dot(yk,sk)*yk*sk')+sk*sk'*rok;
    H = H - H*(sk*sk')*H/(sk'*H*sk)+yk*yk'/dot(yk,sk);
    if ~all(real(eig(H)>=0))
        H = I;
        cnt = cnt+1
    end
    %Updating dd
    dd = constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle);
end 
toc


end