function [Mx, Tbx] = cumMinEngVer(e)
% e is the energy map.
% Mx is the cumulative minimum energy map along vertical direction.
% Tbx is the backtrack table along vertical direction.
%Mx(i, j) = e(i, j) + min(Mx(i ? 1, j ? 1), Mx(i ? 1, j), Mx(i ? 1, j + 1))

%% Setup
[ny,nx] = size(e);
Mx = zeros(ny, nx);
Tbx = zeros(ny, nx);
Mx(1,:) = e(1,:);

%% Compute Mx and Tbx
for i = 2:ny 
    for j = 1:nx
        if j==1 %left boundary case
            [val ind] = min([Mx(i-1,j),Mx(i-1,j+1)]);
            ind = ind+1;
        elseif j==nx %right boundary case
            [val ind] = min([Mx(i-1,j-1),Mx(i-1,j)]);
        else
            [val ind] = min([Mx(i-1,j-1),Mx(i-1,j),Mx(i-1,j+1)]);
        end
        Tbx(i,j) = ind;
        Mx(i,j) = e(i,j)+ val;
    end
end
end