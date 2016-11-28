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
    y = y - offsetY;
    x = x - offsetX;
    solVector(i) = 4*source(y,x) - source(y+1,x) ...
        -source(y-1,x) - source(y,x+1) - source(y,x-1);
    
end

end