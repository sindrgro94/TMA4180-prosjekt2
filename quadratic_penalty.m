function quadratic_penalty(THETA,L,P,tol,max_iter)
my = 1;
k = 0;
while norm(dQ(THETA,L,P,my)) > 0.01 && max_iter > k
    THETA = gradient_descent_Q(THETA,L,P,my,0.1);
    my = my*1.5;
    k = k+1;
    dd = norm(dQ(THETA,L,P,my))
end

end
function svar = Q(THETA,L,P,my)
    [~,s] = size(THETA);
    svar = 0;
        for j = 1:s
            [c_x,c_y] = c(j,THETA,L,P);
            svar = svar + my/2*(c_x)^2 + my/2*c_y^2;
        end
    svar = svar + E(THETA);
end

function svar = dQ(THETA,L,P,my)
    [~,s] = size(THETA);
    svar = 0;
        for j = 1:s
            [c_x,c_y] = c(j,THETA,L,P);
            [dc_x,dc_y] = gradC(j,THETA,L);
            svar = svar + my*(c_x*dc_x + c_y*dc_y);
        end
    svar = svar +gradE(THETA);
end
        