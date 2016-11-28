function resultImg = reconstructImg(indexes, red, green, blue, targetImg)

[row col] = size(indexes);

red = reshape(red,[row col]);
blue = reshape(blue,[row col]);
green = reshape(green,[row col]);

imshow(red);

resultImg = zeros(row,col,3);
resultImg(:,:,1) = red;
resultImg(:,:,2) = blue;
resultImg(:,:,3) = green;

end