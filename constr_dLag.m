function svar = constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle)
%gradienten til lagrangian (17.37 i N&W)
[n,s] = size(THETA);
svar = gradE(THETA);
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    [dc_x,dc_y] = gradC(j,THETA,L);
    svar = svar - ((lambdas(j,1)-my*c_x)*dc_x + (lambdas(j,2)-my*c_y)*dc_y);
end
%Inequality constraints
[grad_u,grad_l] = constr_gradC(THETA,angle);
gradient = [grad_u;grad_l];
temp = (lambdas_constr-my*constr_c(THETA,angle)).*gradient;
svar = svar -(temp(1:n*s)+temp(n*s+1:2*n*s));
% svar = svar -(gradienten til c_u + gradienten til c_l) s�nn cirka.
end
