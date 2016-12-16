function CB = createCodebook(trainingImage)
 
trainingImage = rgb2gray(trainingImage);
BW = edge(trainingImage,'canny');

CB = struct('edgeMap',[],'feature',[],'distance',[]);

image = imshow(trainingImage);
mask_region = imfreehand;
mask = createMask(mask_region,image);
CB(1).edgeMap = mask.*BW; %Nose

[featureVector,hogVisualization] = extractHOGFeatures(BW);
CB(1).feature = featureVector;

s = regionprops(mask.*BW,'centroid');
face_center = cat(1, s.Centroid);
CB(1).distance = 0;

for i = 2:5
image = imshow(trainingImage);
mask_region = imfreehand;
mask = createMask(mask_region,image);
CB(i).edgeMap = mask.*BW;

[featureVector,hogVisualization] = extractHOGFeatures(BW);
CB(i).feature = featureVector;

s = regionprops(mask.*BW,'centroid');
feat_center = cat(1, s.Centroid);

CB(i).distance = norm([face_center(1)-feat_center(1), face_center(2)-feat_center(2)]);
end

end