function [frames,edgeMaps] = getMaps(vidObj)

vidHeight = vidObj.Height;
vidWidth = vidObj.Width;

% frames = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
%     'colormap',[]);

k = 1;
while hasFrame(vidObj)
    frames{k} = (readFrame(vidObj));
    edgeMaps{k} = edge(rgb2gray(frames{k}),'canny');
    k = k+1;
end

% set(gcf,'position',[150 150 vidObj.Width vidObj.Height]);
% set(gca,'units','pixels');
% set(gca,'position',[0 0 vidObj.Width vidObj.Height]);
% movie(s,1,vidObj.FrameRate);

% img = imread('cameraman.tif');
% [featureVector,hogVisualization] = extractHOGFeatures(img);

% subplot(1,2,1);
% imshow(img);
% subplot(1,2,2);
% plot(hogVisualization);