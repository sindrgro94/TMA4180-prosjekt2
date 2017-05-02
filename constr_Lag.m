function svar = constr_Lag(THETA,lambdas,lambdas_constr,L,P,my,angle)
[~,s] = size(THETA);
summen = 0;
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    summen = summen + ( - lambdas(j,1)*c_x - lambdas(j,2)*c_y + my/2*c_x^2 + my/2*c_y^2);
end
summen = summen -sum(lambdas_constr.*constr_c(THETA,angle)) + my/2*sum(constr_c(THETA,angle).^2);
svar =  E(THETA) + summen;
end