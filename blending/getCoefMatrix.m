function coefM = getCoefMatrix(indexes)
% 
% [row col] = size(indexes);
% n = row*col;
% coefM = spalloc(n,n,10*n);

% zero_ind = find(indexes==0);
ind = find(indexes);
% for i = 1:length(zero_ind)
%     coefM(zero_ind(i),zero_ind(i)) = 1;
% end

[row col] = size(indexes);
n = indexes(ind(end));
coefM = spalloc(n,n,4*n);
%coefM = zeros(n);
coefM(1,1) = 4;
coefM(n,n) = 4;
for i = 2:length(ind)-1
    
    coefM(indexes(ind(i)),indexes(ind(i))) = 4;
    coefM(indexes(ind(i))+1,indexes(ind(i))) = -1;
    coefM(indexes(ind(i))-1,indexes(ind(i))) = -1;
    coefM(indexes(ind(i)),indexes(ind(i))-1) = -1;
    coefM(indexes(ind(i)),indexes(ind(i))+1) = -1;
    
end

% coefM = sparse(coefM);

end