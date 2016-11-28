function solVector = getSolutionVect(indexes, source, target, offsetX, offsetY)
     
% 
% zero_ind = find(indexes==0);
% solVector(zero_ind) = target(zero_ind);

ind = find(indexes);
[row col] = size(indexes);
n= indexes(ind(end));
solVector = zeros(n,1);
[y x] = ind2sub(size(target),ind);

for i = 1:length(ind)
    
    y(i) = y(i) - offsetY;
    x(i) = x(i) - offsetX;
    solVector(ind(i)) = 4*source(y(i),x(i)) - source(y(i)+1,x(i)) ...
        -source(y(i)-1,x(i)) - source(y(i),x(i)+1) - source(y(i),x(i)-1);
end

end