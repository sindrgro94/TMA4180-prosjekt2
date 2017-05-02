function svar =  Px(THETA,lambdas, L, P, my, angle)
    
dL = dLag(THETA,lambdas,L,P,my);
THETA = reshape(THETA,size(dL));
g = THETA-dL;
lengde = length(g);
svar = zeros(size(g));
for i = 1:lengde
    if g(i) < -angle
        svar(i) = -angle;
    elseif g(i) >= -angle && g(i) <= angle
        svar(i) = g(i);
    elseif g(i) > angle;
        svar(i) = angle;
    end
end
end