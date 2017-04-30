function grad = gradLag(THETA,lambdas,L,P,my)
%%Initialiserer
 [n,s] = size(THETA);
 grad = zeros(s*n,1);
 cnt = 1;
 x = min(min(abs(THETA)));
 h = x/100;
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
         grad(cnt) = (1/12*lag(THETAm2,lambdas,L,P,my)-2/3*lag(THETAm1,lambdas,L,P,my)+2/3*lag(THETAp1,lambdas,L,P,my)-1/12*lag(THETAp2,lambdas,L,P,my))/(h);
         cnt = cnt+1;
     end
 end
end
