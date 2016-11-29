function resultImg = reconstructImg(indexes, red, green, blue, targetImg)

[row col] = size(indexes);
red = im2uint8(red);
blue = im2uint8(blue);
green = im2uint8(green);

% red = reshape(red,[row col]);
% blue = reshape(blue,[row col]);
% green = reshape(green,[row col]);
%
% imshow(red);

resultImg = zeros(row,col,3);
resultImg = im2uint8(resultImg);
targetImg = im2uint8(targetImg);
for i = 1:row
    for j = 1:col
        
        if indexes(i,j)
            ind = indexes(i,j);
            resultImg(i,j,1) = red(ind);
            resultImg(i,j,2) = blue(ind);
            resultImg(i,j,3) = green(ind);
            
        else
            resultImg(i,j,1) = targetImg(i,j,1);
            resultImg(i,j,2) = targetImg(i,j,2);
            resultImg(i,j,3) = targetImg(i,j,3);
        end
        
        
    end
end

end