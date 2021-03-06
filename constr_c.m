function c_vec = constr_c(THETA,angle)
%Tar inn THETA og vinkelbegrensninger
%Sender tilbake om constrintsene er brutt og med hvor mye i henhold til
%Forelesningsnotatet.
% Sender ut upper-constraintene ogs� lower-constraints
    lower = -angle;
    upper = angle;
    [n,s] = size(THETA);
    THETA = reshape(THETA,n*s,1);  
    c_vec_u = zeros(size(THETA));
    c_vec_l = zeros(size(THETA));
    for i = 1:n*s
        if THETA(i) > upper
            c_vec_u(i) = abs(angle - THETA(i));
        elseif THETA(i) < lower
            c_vec_l(i) = abs(THETA(i) - lower);
        end
    end
    c_vec = [c_vec_u;c_vec_l];
%     X = (abs(THETA) >= angle);
%     c_vec = X.*abs(THETA);
end