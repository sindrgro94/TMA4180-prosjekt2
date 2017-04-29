function svar = Lagrangian(THETA,l,L,P)

%Sum c and l
[~,s] = size(THETA);
svar = E(THETA);
my = 1;
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    svar = svar - l(j,1)*c_x + my/2 * c_x^2; % s constraints on x
    svar = svar - l(j,2)*c_y + my/2 * c_y^2; % s constraints on y
end

end
