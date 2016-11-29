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
n = max(max(indexes));
coefM = spalloc(n,n,4*n);
%coefM = zeros(n);
coefM(1,1) = 4;
coefM(n,n) = 4;


in = indexes(ind);
c = sortrows([in,ind]);
in = c(:,1);
for i = 2:n-1
    [y x] = find(indexes==i);
    coefM(i,i) = 4;
    Np = [indexes(y+1,x),indexes(y-1,x),indexes(y,x-1),indexes(y,x+1)];
    Np(Np==0) = [];
    
    for j = 1:length(Np)
       coefM(Np(j),i) = -1; 
    end
%     coefM(i+1,i) = -1;
%     coefM(i-1,i) = -1;
%     coefM(i,i-1) = -1;
%     coefM(i,i+1) = -1;
    
end

% coefM = sparse(coefM);

end