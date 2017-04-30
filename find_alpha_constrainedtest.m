function alpha = find_alpha_constrainedtest(pk, theta, lambdas,L,P,my)
%% Preconditions
% pk - Step direction
% theta - current angles
% La - the Lagrangian function
% dLa - the derivative of the Lagrangian
%% Postconditions 
%alpha - steplength fullfilling Wolfe condidions
La = 1;
dLa = 1;
al = 0;
ar = 1;
c2 = 0.9;
c1 = 10^-4;
increase = 2;
if(~wolfe2(theta, pk,La,dLa,ar,c2) && wolfe1(theta, pk,La,dLa,ar,c1))
    while ~wolfe1(theta, pk,La,dLa,ar,c1)
        ar = ar*increase;
    end
end
alpha = (ar+al)/2;
while ~(wolfe1(theta, pk,La,dLa,alpha,c1) && wolfe2(theta, pk,La,dLa,alpha,c2))
    if ~wolfe2(theta, pk,La,dLa,alpha,c2)
        ar = alpha;
    else
        al = alpha;
    end
    alpha = (ar+al)/2;
end
end
function bool = wolfe1(theta, pk, lambdas, L,P,my, alpha, c1)
    if (lag(theta + alpha * pk,lambdas,L,P,my) <= lag(theta) + c1 * alpha * dLag(theta, lambdas,L,P,my)' * pk)
        bool = true;
    else
        bool = false;
    end
end
function bool = wolfe2(theta, pk, lambdas, L,P,my, alpha, c2)
    if (dLag(theta + alpha * pk,lambdas, L,P,my) >= c2 * dLag(theta,lambdas,L,P,my)' * pk)
        bool = true;
    else
        bool = false;
    end
end