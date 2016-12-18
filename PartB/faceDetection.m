close all;clear;clc

obj=vision.VideoFileReader('easy1.mp4', 'VideoOutputDataType', 'uint8',...
    'ImageColorSpace', 'Intensity');
FaceDetect = vision.CascadeObjectDetector('MinSize', [64 64]);

for k=0:10
    videoFrame = step(obj);
    %using viola-jones algorithm
    
    %FaceDetect
    BB = step(FaceDetect,videoFrame);
    BB(:,1:2) = BB(:,1:2);
    BB(:,3:4) = BB(:,3:4);
    %BB
    figure(2),imshow(videoFrame);
    
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','r');
    end
    
    %crop faces and convert it to gray
    for i = 1:size(BB,1)
        I= imcrop(videoFrame,BB(i,:));
        %%I=rgb2gray(imresize(J,[292,376]));
        
        %save cropped faces in database folder
        filename = ['faces' num2str(i+k*(size(BB,1))) '.jpg'];
        imwrite(I,filename);
    end
end