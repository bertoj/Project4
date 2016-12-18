
% Read Images
sourceImg = recovered;
targetImg = face;

% Measured Offset
offsetX = 0;
offsetY = 0;

% Generate Blended Image
%mask = maskImage(sourceImg);
resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask2, offsetX, offsetY);
imwrite(resultImg,'BlendedImage.jpg');
imshow(resultImg)
