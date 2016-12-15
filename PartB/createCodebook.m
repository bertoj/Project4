function codebook = createCodebook(trainingImage)
 
trainingImage = rgb2gray(trainingImage);
BW = edge(trainingImage,'canny');

image = imshow(trainingImage);
mask_region1 = imfreehand;
mask1 = createMask(mask_region1,image);
mask_region2 = imfreehand;
mask2 = createMask(mask_region2,image);

feature{1} = mask1.*BW; %left eye
feature{2} = mask2.*BW; %right eye


codebook = feature;
end