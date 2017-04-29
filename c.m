function [c_x,c_y] = c(j,THETA,L, P)
    c1 = @(theta,L,p) [sum(L.*cos(cumsum(theta)));sum(L.*sin(cumsum(theta)))]-p;
    
    C = c1(THETA(:,j),L,P(:,j));
    c_x = C(1);
    c_y = C(2);
end