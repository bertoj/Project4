close all; clear; clc;


sourceImg = imread('bear.png');
targetImg = imread('pool.png');
offsetX = 25;
offsetY = 150;
mask = maskImage(sourceImg);
resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY);
