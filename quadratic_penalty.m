function quadratic_penalty(THETA,L,P,tol,max_iter)
tol = 0.1;
my = 1;
k = 0;
while norm(dQ(THETA,L,P,my)) > 0.01 && max_iter > k
    [THETA,n,flag] = gradient_descent_Q(THETA,L,P,my,tol);
    if n < 10 && flag == false
        my = my*1.5;
        tol = 0.9*tol;
    elseif flag == true || n >= 10
        my = my*1.5;
        tol = tol*0.9;
        
    end
    k = k+1;
    norm_dd = norm(dQ(THETA,L,P,my))
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
        