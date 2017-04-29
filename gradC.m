function [vec_C_x,vec_C_y] = gradC(j,THETA,L, P)
%Her er mye gjenbrukt fra forrige prosjekt. Forskjellen er at det er flere
%variable i E(THETA) enn i F(THETA) s� gradienten f�r flere nuller. Det er
%forresten verdt � merke seg at disse m v�re uavhengige ettersom at alle C_i
%har verdier der C_j (j~=i) er null. Jeg kan ogs� p�st� at C_ix og C_iy er
%uavhengige ettersom at cos og sin aldri kan bli null s� lenge alle theta
%ikke er lik pi/4+k*2*pi

[n,s] = size(THETA);
vec_C_x = zeros(n*s,1);
vec_C_y = zeros(n*s,1);

thetasum = cumsum(THETA(:,j));
L_cos_thetasum = L.*cos(thetasum);
L_sin_thetasum = L.*sin(thetasum);

vec_C_x(n*(j-1)+1:n*j) = flip(cumsum(L_cos_thetasum));
vec_C_y(n*(j-1)+1:n*j) = flip(cumsum(L_sin_thetasum));


end