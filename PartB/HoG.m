close all; clear;clc

img = imread('cameraman.tif');
[featureVector,hogVisualization] = extractHOGFeatures(img);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
plot(hogVisualization);