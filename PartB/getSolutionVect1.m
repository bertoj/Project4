function solVector1 = getSolutionVect1(indexes, source, target, offsetX, offsetY)
    
    n = nnz(indexes);
    %[row,col] = find(indexes);
    solVector1 = zeros(1,n); 
    
    %indexes = padarray(indexes,[1 1]);
    %source = padarray(source,[1 1]);
    source = padarray(source,[offsetY, offsetX],'pre');
    [x,y] = size(indexes);
    [xs,ys] = size(source);
    source = padarray(source,[x-xs, y-ys],'post');
    
    bin = indexes;
    bin(bin > 0) = 1;
    
    temp = source.*bin;
  
    %ind = find(indexes);
    [row,col] = find(indexes);
    [row, I] = sort(row,'ascend');
    col = col(I);
    
    for i = 1:length(row)
        Np = [temp(row(i) - 1, col(i)),...
             temp(row(i), col(i) + 1),...
             temp(row(i) + 1, col(i)),...
             temp(row(i), col(i) - 1)];
        
        g = 4*temp(row(i),col(i)) - sum(Np);
        
        check = [temp(row(i)-1,col(i)), temp(row(i),col(i)+1),...
            temp(row(i)+1,col(i)), temp(row(i),col(i)-1)];
        check = ~check;
        
        f = [target(row(i) - 1, col(i)),...
             target(row(i), col(i) + 1),...
             target(row(i) + 1, col(i)),...
             target(row(i), col(i) - 1)];
        
        f = f.*double(check);
        
        solVector1(1,i) = g + sum(f);
        
    end

end