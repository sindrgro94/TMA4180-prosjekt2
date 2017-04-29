function [THETA,k] = gradient_descent(THETA,lambdas,L,P,my, tol, max_iter)
%% Preconditions 
%p - point desired
%L - Column vector of length segments
%tol - Toleration for the norm of the gradient
%max_iter - Max iterations
% Do not call this function with max_iter less than 1000 if you want to
% plot the solution.
%% Postconditions
%theta - Column vector of the angle between the length segments
%n - Number of iterations
%% Case 2 - point within reach
[n,s] = size(THETA);
%theta = ones(length(n*s),1).*pi/2;
%Dette er de to funksjonene
%lag(THETA,l,L,P)
dd = dLag(THETA,lambdas,L,P,my);
alpha0 = 1;
rho = 1/2;
c = 1/4;
k = 0;
while norm(dd) > tol && k<=max_iter
    k = k+1;
    pk = -dd; %Gradient descent
    alpha = alpha0;
    c_dd_dot_pk = c*dot(dd,pk);
    pk = reshape(pk,n,s);
    while lag(THETA+alpha*pk,lambdas,L,P,my) > lag(THETA,lambdas,L,P,my)+alpha*c_dd_dot_pk %Armijo condition
        alpha = rho*alpha;
    end
    THETA = THETA + alpha * pk;
    dd = dLag(THETA,lambdas,L,P,my);
end
end