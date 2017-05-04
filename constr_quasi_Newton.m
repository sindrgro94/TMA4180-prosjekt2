function [THETA] = constr_quasi_Newton(THETA,lambdas,lambdas_constr,L,P,my, tol, angle,stepSelection)
tic
max_iter = 200;
[n,s] = size(THETA);
%Dette er de to funksjonene
dd = constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle);
%Initialiazing values
I = eye(n*s);
H = sparse(I);
k = 0;
c1 = 10^-4;
rho = 1/2;
cnt = 0;
while norm(dd) > tol && k<=max_iter
    if ~stepSelection
        H = I;
    end
    alpha = 1;
    k = k+1;
    %Initial step length and direction
    pk = -H*dd;
    %finding step length
    if stepSelection
        alpha = find_alpha_constrained(pk, THETA,lambdas,lambdas_constr,L,P,my,angle);
    else
        while constr_Lag(THETA+alpha*reshape(pk,n,s),lambdas,lambdas_constr,L,P,my,angle) > constr_Lag(THETA,lambdas,lambdas_constr,L,P,my,angle)+alpha*c1*dot(dd,pk) %Armijo condition
            alpha = rho*alpha;
        end
    end 
    %Updating x
    %Updating H
    sk = alpha*pk;
    pk = reshape(pk,n,s);
    THETA = THETA + alpha*pk;
    yk = (constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle)-dd);
    rok = 1/dot(yk,sk);
    if alpha < 10^-100 || rok > 10^100
       fprintf('Break\n')
       break;
    end
    if stepSelection
        zk = (H*yk);
        H = H - (sk*zk' + zk*sk')/dot(yk,sk) + (dot(yk,zk)+rok)*(sk*sk')/(dot(yk,sk)^2);

        H = (I-1/dot(yk,sk)*sk*yk')*H*(I-1/dot(yk,sk)*yk*sk')+sk*sk'*rok;
    %   H = H - H*(sk*sk')*H/(sk'*H*sk)+yk*yk'/dot(yk,sk);
        if ~all(real(eig(H)>=0))
            H = I;
            fprintf('H is reset to identity matrix.\n')
            cnt = cnt+1;
        end
    end
    %Updating dd
    for i = 1:n*s
        if THETA(i) < -angle && THETA(i) > -angle - 10^-7
            THETA(i) = -angle + 10^-7;
            
        elseif THETA(i) > angle && THETA(i) < angle + 10^-7
            THETA(i) = angle - 10^-7;
        end
    end
    dd = constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle);
end 
toc


end