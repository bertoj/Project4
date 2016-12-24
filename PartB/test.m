close all; clear;clc

% read in video
vidObj = VideoReader('easy2.mp4');

[frames] = getMaps(vidObj);

% read in training image to create codebook
trainingImage = imread('head.png');
[row, col, d] = size(trainingImage);

% %Create code book
%CB = createCodebook(trainingImage);
load('CB.mat'); % load training image

% ctr points in training image
for i = 1:5
    CtrPts2(i,:) = CB(i).pos;
end

% remove noise from training image
mask = ones(row, col);
cont=activecontour(rgb2gray(trainingImage),mask);
trainingImage = im2double(trainingImage).*cont;

new_frame = cell(length(frames),1);

for i = 1:length(frames)
    
    % Get frames and faces
    frame = frames{i};
    %frame = imgaussfilt(frame,2);
    faces = getFaces(frame);
    
    % work on individual faces
    close all;
    for j = 1:1
        
        % current face
        face = faces{1,1};
        
        % resize face to match codebook image
        [row1,col1,~] = size(face);
        face = imresize(face,[row,col]);
        
        mask = ones(row, col);
        %mask(25:end-25,25:end-25) = 1;
        cont=activecontour(rgb2gray(face),mask,'edge');
        
        % extract shape context features
        [features num] = getFeatures(face);
        
        % get control points for warping
        CtrPts = genCtrPts(features,CB,face,num);
        CtrPts(:,[1 2]) = CtrPts(:,[2 1]);
        
        % warp images
        im = im2double(trainingImage);
        warp = Warp2(face,trainingImage, CtrPts,CtrPts2);
        mask = rgb2gray(warp);
        mask = mask==0;
        warp = im2double(warp);
        
        warp = mask.*im2double(face) + (warp);
        
        % resize to original size
        warp = imresize(warp,[row1,col1]);
        warp = imgaussfilt(warp,2);
        warp = im2uint8(warp);
    end
    % put back in frame and store
    new_frame{i} = replace(frame,warp,faces{2,1});
end