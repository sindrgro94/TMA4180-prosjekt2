function bool = is_outside(L,P)
R = sum(L);
r = max(L) - (sum(L)-max(L));
[~,s] = size(P);
for j = 1:s
    if R <= norm(P(:,j))
        bool = true;
    elseif r >= norm(P(:,j))
        bool = true;
    else
        bool = false;
    end
end
end
