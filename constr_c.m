function c_vec = constr_c(THETA,angle)
    [n,s] = size(THETA);
    THETA = reshape(THETA,n*s,1);    
    X = (abs(THETA) >= angle);
    c_vec = X.*abs(THETA);
end