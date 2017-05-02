function grad = gradQ(THETA,L,P,my)

[n,s] = size(THETA);
 grad = zeros(s*n,1);
 cnt = 1;
 x = min(min(abs(THETA)));
 if x ~= 0
 h = x/100;
 end
 h = 0.01;
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
         grad(cnt) = (1/12*Q(THETAm2,L,P,my)-2/3*Q(THETAm1,L,P,my)+2/3*Q(THETAp1,L,P,my)-1/12*Q(THETAp2,L,P,my))/(h);
         cnt = cnt+1;
     end
 end
end