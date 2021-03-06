function indexes = getIndexes(mask, targetH, targetW, offsetX, offsetY)

    % initialize matrix size
    indexes = zeros(targetH, targetW);

    % account for offset
    mask2 = padarray(mask,[offsetY, offsetX],'pre');
    
    [row col] = size(mask2);
    
    % pad to achieve desired size
    mask3 = padarray(mask2,[targetH-row,targetW-col],'post');

    % nonzeor elemtns
    [y x] = find(mask3);
    sorted_pairs = sortrows([y x]);
    ind = sub2ind(size(mask3),sorted_pairs(:,1),sorted_pairs(:,2));
    indexes(ind(1)) = mask3(ind(1));
    
    % indexing left to right
    for i=2:length(ind)
       indexes(ind(i)) =  mask3(ind(i)) + indexes(ind(i-1));
    end
    
    
end