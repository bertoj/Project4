function [My, Tby] = cumMinEngHor(e)
% e is the energy map.
% My is the cumulative minimum energy map along horizontal direction.
% Tby is the backtrack table along horizontal direction.
% My(i, j) = e(i, j) + min(My(i ? 1, j ? 1), My(i, j ? 1), My(i + 1, j ? 1))

%% Setup
[ny,nx] = size(e);
My = zeros(ny, nx);
Tby = zeros(ny, nx);
My(:,1) = e(:,1);

%% Calculate My and Tby
for j = 2:nx 
    for i = 1:ny
        if i==1  %left boundary case
            [val ind] = min([My(i,j-1),My(i+1,j-1)]);
            ind = ind+1;
        elseif i==ny %right boundary case
            [val ind] = min([My(i-1,j-1),My(i,j-1)]);
        else  %looking at all three
            [val ind] = min([My(i-1,j-1),My(i,j-1),My(i+1,j-1)]);
        end
        Tby(i,j) = ind;
        My(i,j) = e(i,j)+ val;
    end
end
end