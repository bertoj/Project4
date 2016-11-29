function resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY)

sourceImg = im2double(sourceImg);
targetImg = im2double(targetImg);

[targetH, targetW] = size(targetImg(:,:,1));
[indexes] = getIndexes(mask, targetH, targetW, offsetX, offsetY);

[coefM] = getCoefMatrix(indexes);

sourceRed = sourceImg(:,:,1);
sourceBlue = sourceImg(:,:,2);
sourceGreen = sourceImg(:,:,3);

targetRed = targetImg(:,:,1);
targetBlue = targetImg(:,:,2);
targetGreen = targetImg(:,:,3);


[solRed] = getSolutionVect(indexes, sourceRed, targetRed, offsetX, offsetY);
[solBlue] = getSolutionVect(indexes, sourceBlue, targetBlue, offsetX, offsetY);
[solGreen] = getSolutionVect(indexes, sourceGreen, targetGreen, offsetX, offsetY);

red = coefM\solRed;
blue = coefM\solBlue;
green = coefM\solGreen;

resultImg = reconstructImg(indexes, red, green, blue, targetImg);
end