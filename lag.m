function svar = lag(THETA,lambdas,L,P,my)
%Lagrangian (17.36 i N&W)
%Sum c and l
[~,s] = size(THETA);
svar = E(THETA);
summen = 0;
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    summen = summen + ( - lambdas(1,j)*c_x - lambdas(2,j)*c_y + my/2*c_x^2 + my/2*c_y^2);
end
svar = svar + summen;
end
