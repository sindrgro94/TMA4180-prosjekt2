function alpha = find_alpha_constrained(pk, theta,lambdas,lambdas_constr,L,P,my,angle)
%% Preconditions
% pk - Step direction
% theta - current angles
% La - the Lagrangian function
% dLa - the derivative of the Lagrangian
%% Postconditions 
%alpha - steplength fullfilling Wolfe condidions
al = 0;
ar = 1;
c2 = 0.3;
c1 = 10^-4;
increase = 2;
if(wolfe2(pk, theta,lambdas,lambdas_constr,L,P,my,angle,ar,c2) && wolfe1(pk, theta,lambdas,lambdas_constr,L,P,my,angle,ar,c1))
    alpha = ar;
    return
else
    while wolfe1(pk, theta,lambdas,lambdas_constr,L,P,my,angle,ar,c1)
        ar = ar*increase;
    end
end
alpha = (ar+al)/2;
while ~(wolfe1(pk, theta,lambdas,lambdas_constr,L,P,my,angle,alpha,c1) && wolfe2(pk, theta,lambdas,lambdas_constr,L,P,my,angle,alpha,c2))
    if ~wolfe1(pk, theta,lambdas,lambdas_constr,L,P,my,angle,alpha,c1)
        ar = alpha;
    else
        al = alpha;
    end
    alpha = (ar+al)/2;
    if alpha < 10^-20
        break;
    end
end
end
function bool = wolfe1(pk, THETA,lambdas,lambdas_constr,L,P,my,angle, alpha, c1)
    [n,s] = size(THETA);
    if (constr_Lag(THETA+alpha*reshape(pk,n,s),lambdas,lambdas_constr,L,P,my,angle)...
            <= constr_Lag(THETA,lambdas,lambdas_constr,L,P,my,angle) + c1 * alpha *...
            constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle)' * pk)
        bool = true;
    else
        bool = false;
    end
end
%constr_Lag(THETA+alpha*reshape(pk,n,s),lambdas,lambdas_constr,L,P,my,angle)
%constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle)
function bool = wolfe2(pk,THETA,lambdas,lambdas_constr,L,P,my,angle, alpha, c2)
    [n,s] = size(THETA);
    if (constr_dLag(THETA+alpha*reshape(pk,n,s),lambdas,lambdas_constr,L,P,my,angle)'*pk...
            >= c2 * constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle)' * pk)
        bool = true;
    else
        bool = false;
    end
end