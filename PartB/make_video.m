%% Generate video

% If trig = 1 use triangulation
% If trig = 0 use tps

for do_trig = 1
  
        fname = 'new_face.avi';
        
    try
        % VideoWriter based video creation
        h_avi = VideoWriter(fname, 'Uncompressed AVI');
        h_avi.FrameRate = 24;
        h_avi.open();
    catch
        % Fallback deprecated avifile based video creation
        h_avi = avifile(fname,'fps',24);
    end
    

    for i = 1:length(new_frame)

        % if image type is double, modify the following line accordingly if necessary
        imagesc(new_frame{i});
        axis image; axis off;drawnow;
        try
            % VideoWriter based video creation
            h_avi.writeVideo(getframe(gcf));
        catch
            % Fallback deprecated avifile based video creation
            h_avi = addframe(h_avi, getframe(gcf));
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
end
