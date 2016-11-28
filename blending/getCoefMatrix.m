function coefM = getCoefMatrix(indexes)

[row col] = size(indexes);
n = row*col;
coefM = spalloc(n,n,10*n);

zero_ind = find(indexes==0);
ind = find(indexes);
for i = 1:length(zero_ind)
    coefM(zero_ind(i),zero_ind(i)) = 1;
end

for i = 1:length(ind)
    
    coefM(ind(i),ind(i)) = 4;
    coefM(ind(i)+1,ind(i)) = -1;
    coefM(ind(i)-1,ind(i)) = -1;
    coefM(ind(i),ind(i)-1) = -1;
    coefM(ind(i),ind(i)+1) = -1;
    
end

% coefM = sparse(coefM);

end