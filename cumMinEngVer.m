function [Mx, Tbx] = cumMinEngVer(e)
% e is the energy map.
% Mx is the cumulative minimum energy map along vertical direction.
% Tbx is the backtrack table along vertical direction.

%edit
[ny,nx] = size(e);
Mx = zeros(ny, nx);
Tbx = zeros(ny, nx);
Mx(1,:) = e(1,:);
% Mx = padarray(e,[0 1]);% We could avoid border element calculations
%there is also a cummin option
%Mx = cummin(e,1);

for i = 2:ny
    for j = 2:nx-1
        Mx(i,j) = e(i,j)+ min(Mx(i-1,j-1),Mx(i-1,j),Mx(i-1,j+1));
    end
end
%min entry on Mx in the last row
[min_entry,ind] = min(Mx(ny,:));

%backtrack from min entry on Mx
for i = ny:-1:2
    backing = [Mx(i-1,ind-1) M(i-1,ind) M(i-1,ind+1)];
    [value,inc] = min(backing);
    min_entry = min_entry + value;
    ind = ind + inc -2;
end
end