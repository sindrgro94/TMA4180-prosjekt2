function svar = bar_dLag(THETA,lambdas,L,P,my,beta, angle)
[~,s] = size(THETA);
svar = gradE(THETA);
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    [dc_x,dc_y] = gradC(j,THETA,L);
    svar = svar - ((lambdas(j,1)-my*c_x)*dc_x + (lambdas(j,2)-my*c_y)*dc_y);
end
[vec_u,vec_l] = constraints(THETA, angle);
%[grad_u,grad_l] = constr_gradC(THETA);
svar = svar - beta*(-vec_u.^-1+vec_l.^-1);
end

% function [vec_u,vec_l] = constraints(THETA, angle)
%     [n,s] = size(THETA);
%     vec_u = zeros(n*s,1);
%     vec_l = zeros(n*s,1);
%     for i = 1:s*n
%         vec_u(i) = angle-THETA(i);
%         vec_l(i) = THETA(i) - (-angle);
%     end
% end