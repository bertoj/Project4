function faces = getFaces(frame)

faceDetector = vision.CascadeObjectDetector('MinSize', [64 64]);
bboxes = step(faceDetector, frame);
%figure, imshow(frame), title('Detected faces');hold on


for i=1:size(bboxes,1)
    rectangle('Position',bboxes(i,:),'LineWidth',2,'EdgeColor','y');
    faces{1,i} = imcrop(frame,bboxes(i,:));  
    faces{2,i} = bboxes(i,:);
end
end