function svar = dLag(THETA,l,L,P)
[~,s] = size(THETA);
svar = gradE(THETA);
my = 1;
for j = 1:s
    [c_x,c_y] = c(j,THETA,L, P);
    [dc_x,dc_y] = gradC(j,THETA,L, P);
    svar = svar + (l(j,1)-my*c_x)*dc_x + (l(j,2)-my*c_y)*dc_y;
end
end