close all; clear;clc

vidObj = VideoReader('easy1.mp4');

[frames,edgeMaps] = getMaps(vidObj);

trainingImage = imread('model7.png');
[row, col, d] = size(trainingImage);

CB = createCodebook(trainingImage);
for i = 1:5
    CtrPts2(i,:) = CB(i).pos;
end
mask = rgb2gray(trainingImage);
mask = mask==0;
for i = 1:2
    
    frame = frames{i};
    fram = imgaussfilt(frame,2);
    faces = getFaces(frame);
    
    for j = 1:2
        face = faces{1,i};
        face = imresize(face,[row,col]);
        features = getFeatures(face);
        CtrPts = genCtrPts(features,CB,face);
        CtrPts(:,[1 2]) = CtrPts(:,[2 1]);
        warp = Warp2(face,trainingImage, CtrPts,CtrPts2);
        mask = rgb2gray(warp);
        mask = mask==0;
        warp = im2double(face).*mask + im2double(warp);
        figure;
        imshow(warp);
    end
    
end