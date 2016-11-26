function [Iy, E] = rmHorSeam(I, My, Tby)
% I is the image. Note that I could be color or grayscale image.
% My is the cumulative minimum energy map along horizontal direction.
% Tby is the backtrack table along horizontal direction.
% Iy is the image removed one row.
% E is the cost of seam removal

[ny, nx, nz] = size(I);
rmIdx = zeros(1, nx);
mask = ones(ny,nx);
Iy = uint8(zeros(ny-1, nx, nz));

%% Add your code here

Tby = Tby - 2;
[val,rmIdx(nx)] = min(My(nx,:));
E = val;
for i = 1:(nx-1)
    rmIdx(nx-i) = rmIdx((nx-i)+1) + Tbx((nx-i)+1,rmIdx((nx-i)+1));
end

% Linear ind to remove
lin_rmIdx = sub2ind([ny,nx],rmIdx,(1:nx));
mask(lin_rmIdx) = 0;

% ind to keep
[row,col] = find(mask);
sorted = sortrows(fliplr([row,col]));

% corresponding ind in new image
[row1,col1] = find(ones(ny-1,nx));
sorted1 = sortrows(fliplr([row1,col1]));

% new image
for i = 1:((ny-1)*(nx))
    Ix(sorted1(i,2),sorted1(i,1),:) = I(sorted(i,2),sorted(i,1),:);
end

end