function svar = lag(THETA,lambdas,L,P,my)
%Lagrangian (17.36 i N&W)
%Sum c and l
[~,s] = size(THETA);
svar = E(THETA);
summen = 0;
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    summen = summen + ( - lambdas(j,1)*c_x - lambdas(j,2)*c_y + my/2*c_x^2 + my/2*c_y^2);
end
svar = svar + summen;
end
