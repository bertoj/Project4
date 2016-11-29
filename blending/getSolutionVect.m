function solVector = getSolutionVect(indexes, source, target, offsetX, offsetY)

% nonzeor elements
ind = find(indexes);

% number of replacement pixels
n = max(max(indexes));

solVector = zeros(n,1);

for i = 1:n
    [y, x] = find(indexes==i);
    
    % index of sorrounding pixls on target
    Np = [indexes(y+1,x),indexes(y-1,x),indexes(y,x-1),indexes(y,x+1)];
    Npind = [y+1,x;y-1,x;y,x-1;y,x+1];
    Npind(Np~=0,:) = [];
    
    % account for offset
    y = y - offsetY;
    x = x - offsetX;
    
    % take gradient
    solVector(i) = 4*source(y,x) - source(y+1,x) ...
        -source(y-1,x) - source(y,x+1) - source(y,x-1);
    
    % add value of sorrounding pixels in target
    for j = 1:size(Npind,1)
        solVector(i) = solVector(i) + target(Npind(j,1),Npind(j,2));
    end
end

end