function resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY)

% Convert to Double`
sourceImg = im2double(sourceImg);
targetImg = im2double(targetImg);

% Size
[targetH, targetW] = size(targetImg(:,:,1));
[indexes] = getIndexes(mask, targetH, targetW, offsetX, offsetY);

% Get coefficient matrix
[coefM] = getCoefMatrix(indexes);

% isolate RGB values
sourceRed = sourceImg(:,:,1);
sourceBlue = sourceImg(:,:,2);
sourceGreen = sourceImg(:,:,3);

targetRed = targetImg(:,:,1);
targetBlue = targetImg(:,:,2);
targetGreen = targetImg(:,:,3);

% Get solutions vectors
[solRed] = getSolutionVect(indexes, sourceRed, targetRed, offsetX, offsetY);
[solBlue] = getSolutionVect(indexes, sourceBlue, targetBlue, offsetX, offsetY);
[solGreen] = getSolutionVect(indexes, sourceGreen, targetGreen, offsetX, offsetY);

% Solve equation
red = mldivide(coefM,solRed);
blue = mldivide(coefM,solBlue);
green = mldivide(coefM,solGreen);

%final im
resultImg = reconstructImg(indexes, red, green, blue, targetImg);
end