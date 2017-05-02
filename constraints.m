function [vec_u,vec_l] = constraints(THETA, angle)
    [n,s] = size(THETA);
    vec_u = zeros(n*s,1);
    vec_l = zeros(n*s,1);
    for i = 1:s*n
        vec_u(i) = angle-THETA(i);
        if vec_u(i) < 0
            vec_u(i) = 0;
        end
        vec_l(i) = THETA(i) - (-angle);
        if vec_l(i) < 0
            vec_l(i) = 0;
        end
    end
end