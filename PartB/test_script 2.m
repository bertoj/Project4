close all;clear;clc

img_input{1} = imread('I1.jpg');
img_input{2} = imread('I2.jpg');
img_input{3} = imread('I3.jpg');

figure
imshow(img_input{1});
title('Image 1');

figure
imshow(img_input{2});
title('Image 2');

figure
imshow(img_input{3});
title('Image 3');


im1 = img_input{1};
gray1 = rgb2gray(im1);
[cimg1] = corner_detector(gray1);
[x1, y1, rmax1] = anms(cimg1, 300);
descs1 = feat_desc(im1, x1, y1);
visual_feat(gray1, 255*cimg1, y1, x1);

[img_mosaic] = mymosaic(img_input);
imwrite(img_mosaic,'Final Mosaic.jpg');
figure
imshow(img_mosaic)
title('Final Mosaic')