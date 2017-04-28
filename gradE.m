function Vec = gradE(THETA)
%% Preconditions
% THETA     a matrix with columns of angles for one point
% P         a matrix with columns being the point wanting to reach
%%
[n,s] = size(THETA);
Vec = zeros(s*n,1);
cnt = 1;
for i = 1:n
    Vec(cnt) = -THETA(i,s) + 2*THETA(i,1)-THETA(i,2);
    cnt = cnt+1;
end
    
for j = 2:s-1
    for i = 1:n
        Vec(cnt) = -THETA(i,j-1) + 2*THETA(i,j) - THETA(i,j+1);
        cnt = cnt+1;
    end
end

for i = 1:n
    Vec(cnt) = -THETA(i,s-1) + 2*THETA(i,s)-THETA(i,1);
    cnt = cnt+1;
end
end




        
        
        
        
        
        