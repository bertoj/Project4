files = dir('video');
nframe=3000;
writerObj = VideoWriter( 'MINALIVE .avi' );
writerObj.FrameRate = N;
open(writerObj);
for i=3:numel(files) %number of images to be read
    a = imread(files(i).name);  
    a = uint8(a);%convert the images into unit8 type
     f.cdata = a;
    f.colormap = [];
    writeVideo(writerObj,f);
end
close(writerObj);
% render video
fname = 'MINALIVE.avi';
try
    % VideoWriter based video creation
    h_avi = VideoWriter(fname, 'Uncompressed AVI');
    h_avi.FrameRate = 10;
    h_avi.open();
catch
    % Fallback deprecated avifile based video creation
    h_avi = avifile(fname,'fps',10);
end

for i=1:110
    imagesc(imgs{i});
    axis image; axis off;drawnow;
    try
        % VideoWriter based video creation
        h_avi.writeVideo(imgs{i});
    catch
        % Fallback deprecated avifile based video creation
        h_avi = addframe(h_avi, imgs{i});
    end
end
try
    % VideoWriter based video creation
    h_avi.close();
catch
    % Fallback deprecated avifile based video creation
    h_avi = close(h_avi);
end
clear h_avi;