function [grad_u,grad_l] = constr_gradC(THETA)
    [n,s] = size(THETA);
    grad_u = zeros(n*s,1);
    grad_l = zeros(n*s,1);
    for i = 1:n*s
        grad_u(i) = -1;
        grad_l(i) = 1;
    end
end