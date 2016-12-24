function faces = getFaces(frame)

faceDetector = vision.CascadeObjectDetector('MinSize', [210 210]);
bboxes = step(faceDetector, frame);
%figure, imshow(frame), title('Detected faces');hold on

bboxes(3) = bboxes(3)+30;
bboxes(4) = bboxes(4)+30;
for i=1:1
    rectangle('Position',bboxes(end,:),'LineWidth',2,'EdgeColor','y');
    faces{1,i} = imcrop(frame,bboxes(end,:));  
    faces{2,i} = bboxes(i,:);
end
end