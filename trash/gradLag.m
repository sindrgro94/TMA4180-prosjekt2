function grad = gradLag(THETA,lambdas,lambdas_constr,L,P,my,angle)
%%Initialiserer
 [n,s] = size(THETA);
 grad = zeros(s*n,1);
 cnt = 1;
 x = min(min(abs(THETA)));
 h = x*10^-9;
 %%Fjerde ordens approksimasjon
 for j = 1:s
     for i = 1:n
         THETAp1 = THETA;
         THETAp2 = THETA;
         THETAm1 = THETA;
         THETAm2 = THETA;
         THETAp1(i,j) = THETA(i,j)+h;
         THETAp2(i,j) = THETA(i,j)+2*h;
         THETAm1(i,j) = THETA(i,j)-h;
         THETAm2(i,j) = THETA(i,j)-2*h;
         grad(cnt) = (1/12*constr_Lag(THETAm2,lambdas,lambdas_constr,L,P,my,angle)...
             -2/3*constr_Lag(THETAm1,lambdas,lambdas_constr,L,P,my,angle)...
             +2/3*constr_Lag(THETAp1,lambdas,lambdas_constr,L,P,my,angle)...
             -1/12*constr_Lag(THETAp2,lambdas,lambdas_constr,L,P,my,angle))/(h);
         cnt = cnt+1;
     end
 end
end
