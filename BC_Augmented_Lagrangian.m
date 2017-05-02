function THETA = BC_Augmented_Lagrangian(THETA,L,P,angle,max_iter)
[~,s] = size(THETA);
lambdas = ones(s,2);
eta_s = 0.01; w_s = 0.01;
my = 1; w = 1/my; eta = 1/my^0.1;

while stop_condition(THETA,lambdas,L,P,my,angle) > w_s;
%     THETA = set_THETA(THETA,angle);
    THETA = quasi_Newton(THETA,lambdas,L,P,my, 0.00001);
    if norm(c_vec(THETA,L,P)) <= eta
        if norm(c_vec(THETA,L,P)) <= eta_s && stop_condition(THETA,lambdas,L,P,my,angle) <= w_s
            break
        end
        lambdas = update_lambdas(THETA,lambdas,L,P,my);
        my = my;
        eta = eta/my^0.9;
        w = w/my;
    else
        lambdas = lambdas;
        my = 2*my;
        eta = eta/my^0.1;
        w = w/my;
    end
    disp(stop_condition(THETA,lambdas,L,P,my,angle))
end
end

function svar = c_vec(THETA,L,P)
    [~,s] = size(THETA);
    svar = zeros(2*s,1);
    for j = 1:s
        [c_x,c_y] = c(j,THETA,L,P);
        svar(2*j-1) = c_x;
        svar(2*j) = c_y;
    end
end

function lambdas = update_lambdas(THETA,lambdas,L,P,my)
    [~,s] = size(THETA);
        for j = 1:s
            [c_x,c_y] = c(j,THETA,L, P);
            lambdas(j,1) = lambdas(j,1)-my*c_x;
            lambdas(j,2) = lambdas(j,2)-my*c_y;
        end
end
function svar = stop_condition(THETA,lambdas,L,P,my,angle)
    [n,s] = size(THETA);
    dl = dLag(THETA,lambdas,L,P,my);
    dl = reshape(dl,size(THETA));
    svar = norm(reshape(THETA,n*s,1)-Px(THETA-dl,lambdas, L, P, my, angle));
end

function THETA = set_THETA(THETA,angle)
    [n,s] = size(THETA);
    for j = 1:s
        for i = 1:n
            if THETA(i,j)> angle
                THETA(i,j) = angle;
            elseif THETA(i,j) < -angle
                THETA(i,j) = -angle;
            end
        end
    end   
end