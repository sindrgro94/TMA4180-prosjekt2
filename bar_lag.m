function svar = bar_lag(THETA,lambdas,L,P,my,beta,angle)
svar = lag(THETA,lambdas,L,P,my);
[vec_u,vec_l] = constraints(THETA, angle);
svar = svar - beta*sum(log());
end



% function vec = constraints(THETA, angle)
%     [n,s] = size(THETA);
%     vec_u = zeros(n*s,1);
%     vec_l = zeros(n*s,1);
%     for i = 1:s*n
%         vec_u(i) = angle-THETA(i);
%         vec_l(i) = THETA(i) - (-angle);
%     end
%     vec = [vec_u;vec_l];
% end