function svar = constr_Lag(THETA,lambdas,lambdas_constr,L,P,my,angle)
[~,s] = size(THETA);
summen = 0;
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    summen = summen + ( - lambdas(j,1)*c_x - lambdas(j,2)*c_y + my/2*c_x^2 + my/2*c_y^2);
end
summen = summen -dot(lambdas_constr,constr_c(THETA,angle)) + my/2*dot(constr_c(THETA,angle),constr_c(THETA,angle));
svar =  E(THETA) + summen;
end