function [Ix, E] = rmVerSeam(I, Mx, Tbx)
% I is the image. Note that I could be color or grayscale image.
% Mx is the cumulative minimum energy map along vertical direction.
% Tbx is the backtrack table along vertical direction.
% Ix is the image removed one column.
% E is the cost of seam removal

[ny, nx, nz] = size(I);
rmIdx = zeros(ny, 1);
mask = ones(ny,nx);
Ix = uint8(zeros(ny, nx-1, nz));
%% Add your code here

Tbx = Tbx - 2;
[val,rmIdx(ny)] = min(Mx(ny,:));
E = val;
for i = 1:(ny-1)
    rmIdx(ny-i) = rmIdx((ny-i)+1) + Tbx((ny-i)+1,rmIdx((ny-i)+1));
end

% Linear ind to remove
lin_rmIdx = sub2ind([ny,nx],(1:ny)',rmIdx);
mask(lin_rmIdx) = 0;

% ind to keep
[row,col] = find(mask);
sorted = sortrows([row,col]);

% corresponding ind in new image
[row1,col1] = find(ones(ny,nx-1));
sorted1 = sortrows([row1,col1]);

% new image
for i = 1:(ny*(nx-1))
    Ix(sorted1(i,1),sorted1(i,2),:) = I(sorted(i,1),sorted(i,2),:);
end

end