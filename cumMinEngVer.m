function [Mx, Tbx] = cumMinEngVer(e)
% e is the energy map.
% Mx is the cumulative minimum energy map along vertical direction.
% Tbx is the backtrack table along vertical direction.

%% Setup
[ny,nx] = size(e);
Mx = zeros(ny, nx);
Tbx = zeros(ny, nx);
Mx(1,:) = e(1,:);
% Mx = padarray(e,[0 1]);% We could avoid border element calculations
%there is also a cummin option
%Mx = cummin(e,1);

%% Compute Mx and Tbx
for i = 2:ny
    for j = 1:nx
        if j~=1
            [val ind] = min([Mx(i-1,j-1),My(i-1,j),My(i-1,j+1)]);
        else
            [val ind] = min([Mx(i-1,j),My(i-1,j+1)]);
            ind = ind+1;
        end
        Tbx(i,j) = ind;
        Mx(i,j) = e(i,j)+ val;
    end
end
end