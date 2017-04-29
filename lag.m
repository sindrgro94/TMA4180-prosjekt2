function svar = lag(THETA,lambdas,L,P,my)
%Lagrangian (17.36 i N&W)
%Sum c and l
[~,s] = size(THETA);
svar = E(THETA);
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    svar = svar - lambdas(j,1)*c_x + my/2 * c_x^2; % s constraints on x
    svar = svar - lambdas(j,2)*c_y + my/2 * c_y^2; % s constraints on y
end

end
