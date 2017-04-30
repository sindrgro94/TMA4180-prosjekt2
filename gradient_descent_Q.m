function THETA = gradient_descent_Q(THETA,L,P,my, tol)
max_iter = 1000;
[n,s] = size(THETA);
%Dette er de to funksjonene
%lag(THETA,l,L,P)
dd = dQ(THETA,L,P,my);
alpha0 = 2*s*pi;
rho = 1/2;
c = 10^-4;
k = 0;
while norm(dd) > tol && k<=max_iter
    k = k+1;
    pk = -dd; %Gradient descent
    alpha = alpha0;
    c_dd_dot_pk = c*dot(dd,pk);
    pk = reshape(pk,n,s);
    cnt = 0;
    while Q(THETA+alpha*pk,L,P,my) > Q(THETA,L,P,my)+alpha*c_dd_dot_pk %Armijo condition
        alpha = rho*alpha;
        cnt = cnt+1;
    end
    if alpha < 10^-12
        break;
    end
    THETA = THETA + alpha * pk;
    dd = dQ(THETA,L,P,my);
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
        