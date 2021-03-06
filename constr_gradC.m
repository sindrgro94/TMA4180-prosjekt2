function [grad_u,grad_l] = constr_gradC(THETA,angle)
% Tar inn THETA og angle 
% Returnerer gradientene sl�tt sammen i hver sin vector, hhv grad_u og
% grad_l. Skulle egt returnert en matrise, men siden kun diagonalelementene
% kunne ta verdier ulik 0 er det like greit med en vektor ogs� bruke .*
    upper = angle;
    lower = -angle;
    [n,s] = size(THETA);
    grad_u = zeros(n*s,1);
    grad_l = zeros(n*s,1);
    for i = 1:n*s
        %% nytt
        if THETA(i) >= upper
            grad_u(i) = 1;
        elseif THETA(i) <= lower
            grad_l(i) = -1;
        end
        %%
%         grad_u(i) = -1;
%         grad_l(i) = 1;
    end
end