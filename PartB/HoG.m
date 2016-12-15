close all; clear;clc

vidObj = VideoReader('easy1.mp4');

vidHeight = vidObj.Height;
vidWidth = vidObj.Width;

s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);


k = 1;
while hasFrame(vidObj)
    s(k).cdata = rgb2gray(readFrame(vidObj));
    BW = edge(s(k).cdata,'canny');
    [H{k},theta{k},rho{k}] = hough(BW);
    k = k+1;
end

% image(s(90).cdata)
imshow(s(90).cdata);

% 
% set(gcf,'position',[150 150 vidObj.Width vidObj.Height]);
% set(gca,'units','pixels');
% set(gca,'position',[0 0 vidObj.Width vidObj.Height]);
% movie(s,1,vidObj.FrameRate);

% 
% img = imread('cameraman.tif');
% [featureVector,hogVisualization] = extractHOGFeatures(img);
% 
% subplot(1,2,1);
% imshow(img);
% subplot(1,2,2);
% plot(hogVisualization);