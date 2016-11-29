function solVector = getSolutionVect(indexes, source, target, offsetX, offsetY)

%
% zero_ind = find(indexes==0);
% solVector(zero_ind) = target(zero_ind);

ind = find(indexes);
% [row col] = size(indexes);

n = max(max(indexes));
solVector = zeros(n,1);
% [y x] = ind2sub(size(target),ind);

for i = 1:n
    [y x] = find(indexes==i);
    Np = [indexes(y+1,x),indexes(y-1,x),indexes(y,x-1),indexes(y,x+1)];
    Npind = [y+1,x;y-1,x;y,x-1;y,x+1];
    Npind(Np~=0,:) = [];
    
    y = y - offsetY;
    x = x - offsetX;
    
    solVector(i) = 4*source(y,x) - source(y+1,x) ...
        -source(y-1,x) - source(y,x+1) - source(y,x-1);
    
    for j = 1:size(Npind,1)
        solVector(i) = solVector(i) + target(Npind(j,1),Npind(j,2));
    end
end

end