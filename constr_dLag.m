function svar = constr_dLag(THETA,lambdas,lambdas_constr,L,P,my,angle)
%gradienten til lagrangian (17.37 i N&W)
[~,s] = size(THETA);
svar = gradE(THETA);
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    [dc_x,dc_y] = gradC(j,THETA,L);
    svar = svar - ((lambdas(j,1)-my*c_x)*dc_x + (lambdas(j,2)-my*c_y)*dc_y);
end
%Inequality constraints
svar = svar -(lambdas_constr-my*constr_c(THETA,angle)).*constr_gradC(THETA);
end
