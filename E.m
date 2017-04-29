function svar = E(THETA)
%Gir E(THETA) fra oppgaven
[n,s] = size(THETA);
svar = 0;
for i = 1:n
    for j = 1:(s-1)
        svar = svar+(THETA(i,j+1)-THETA(i,j))^2;
    end
end

for i = 1:n
    svar = svar + (THETA(i,1)-THETA(i,s))^2;
end
svar = 1/2*svar;
end
        