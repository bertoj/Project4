function [My, Tby] = cumMinEngHor(e)
% e is the energy map.
% My is the cumulative minimum energy map along horizontal direction.
% Tby is the backtrack table along horizontal direction.

[ny,nx] = size(e);
My = zeros(ny, nx);
Tby = zeros(ny, nx);
My(:,1) = e(:,1);
%My = cummin(e,2);

for i = 2:ny
    for j = 2:nx-1
        My(i,j) = e(i,j)+ min(My(i-1,j-1),My(i,j-1),My(i-1,j+1));
    end
end
%min entry on My in the last column
[min_entry,ind] = min(My(:,nx));

%backtrack from min entry on My
for i = nx:-1:2
    backing = [My(i-1,ind-1) My(i-1,ind) My(i-1,ind+1)];
    [value,inc] = min(backing);
    min_entry = min_entry + value;
    ind = ind + inc -2;
end
end