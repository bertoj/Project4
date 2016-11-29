function coefM = getCoefMatrix(indexes)

% non zeor indecies
ind = find(indexes);

% Size
[row, col] = size(indexes);

% number of replacement pixels
n = max(max(indexes));

% initialize sparse matrix
coefM = spalloc(n,n,4*n);
coefM(1,1) = 4;
coefM(n,n) = 4;


in = indexes(ind);
c = sortrows([in,ind]);
in = c(:,1);

% fill in rest of matrix
for i = 2:n-1
    [y, x] = find(indexes==i);
    
    % diagonal element
    coefM(i,i) = 4;
    
    % nonzeor neighboring pixels
    Np = [indexes(y+1,x),indexes(y-1,x),indexes(y,x-1),indexes(y,x+1)];
    Np(Np==0) = [];
    
    for j = 1:length(Np)
        coefM(Np(j),i) = -1;
    end
    
end
end