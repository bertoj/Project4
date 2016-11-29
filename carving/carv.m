function [Ic, T] = carv(I, nr, nc)
% I is the image being resized
% [nr, nc] is the numbers of rows and columns to remove.
% Ic is the resized image
% T is the transport map

[ny, nx, nz] = size(I);
T = zeros(nr+1, nc+1);
TI = cell(nr+1, nc+1);
TI{1,1} = I;
% TI is a trace table for images. TI{r+1,c+1} records the image removed r rows and c columns.

%% Add your code here
T(1,1) = 0;
for i = 2:nr+1
    e = genEngMap(TI{i-1,1});
    [My, Tby] = cumMinEngHor(e);
    [Iy, E] = rmHorSeam(TI{i-1,1}, My, Tby);
    
    TI{i,1} = Iy;
    T(i,1) = E + T(i-1,1);
end

for i = 2:nc+1
    e = genEngMap(TI{1,i-1});
    [Mx, Tbx] = cumMinEngVer(e);
    [Ix, E] = rmVerSeam(TI{1,i-1}, Mx, Tbx);
    
    TI{1,i} = Ix;
    T(1,i) = E + T(1,i-1);
end

for i = 2:nr+1
    
    for j = 2:nc+1
        
        % Energy Maps
        e_rmrow = genEngMap(TI{i-1,j});
        e_rmcol = genEngMap(TI{i,j-1});
        
        % Cumulative Energy maps
        [My, Tby] = cumMinEngHor(e_rmrow);
        [Mx, Tbx] = cumMinEngVer(e_rmcol);
        
        % Calculate optimal seam to remove
        [Iy, E_rmrow] = rmHorSeam(TI{i-1,j}, My, Tby);
        [Ix, E_rmcol] = rmVerSeam(TI{i,j-1}, Mx, Tbx);
        im = {Iy,Ix};
        [T(i,j), ind] = min([T(i-1,j)+E_rmrow,T(i,j-1)+E_rmcol]);
        TI{i,j} = im{ind};
    end
end

Ic = TI{nr+1,nc+1};

end