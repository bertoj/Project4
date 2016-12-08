function coefM = getCoefMatrix(indexes)

% non zeor indecies
ind = find(indexes);

% Size
[row, col] = size(indexes);

% number of replacement pixels
n = length(find(indexes));

% initialize sparse matrix
coefM = 4*speye(n);
coefM(1,1) = 4;
coefM(n,n) = 4;


in = indexes(ind);
c = sortrows([in,ind]);
in = c(:,1);

% fill in rest of matrix
for i = 1:n
    [y, x] = find(indexes==i);
    if i==1
        Np = [indexes(y+1,x),indexes(y,x+1)];
        Np(Np==0) = [];
        
        for j = 1:length(Np)
            coefM(Np(j),i) = -1;
        end
    elseif i==n
        Np = [indexes(y-1,x),indexes(y,x-1),];
        Np(Np==0) = [];
        
        for j = 1:length(Np)
            coefM(Np(j),i) = -1;
        end
    else
        
        % nonzeor neighboring pixels
        Np = [indexes(y+1,x),indexes(y-1,x),indexes(y,x-1),indexes(y,x+1)];
        Np(Np==0) = [];
        
        for j = 1:length(Np)
            coefM(Np(j),i) = -1;
        end
    end
end
end