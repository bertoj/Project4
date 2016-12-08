close all; clear; clc;

% Read Images
sourceImg = imread('cookie.jpg');
targetImg = imread('mac.jpg');

% Measured Offset
offsetX = 210;
offsetY = 170;

% Generate Blended Image
mask = maskImage(sourceImg);
resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY);
imwrite(resultImg,'BlendedImage.jpg');
imshow(resultImg)
