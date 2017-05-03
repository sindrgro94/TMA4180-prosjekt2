function [grad_u,grad_l] = constr_gradC(THETA,angle)
upper = angle;
lower = -angle;
    [n,s] = size(THETA);
    grad_u = zeros(n*s,1);
    grad_l = zeros(n*s,1);
    for i = 1:n*s
        %% nytt
        if THETA(i) > upper
            grad_u(i) = 1;
        elseif THETA(i) < lower
            grad_l(i) = -1;
        end
        %%
%         grad_u(i) = -1;
%         grad_l(i) = 1;
    end
end