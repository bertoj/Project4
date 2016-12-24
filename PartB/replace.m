function new_frame = replace(frame,new_face,location)

x = location(1);
y = location(2);
width = location(3);
height = location(4);
for i = 1:height+1
    for j = 1:width+1
        
        
        frame(y+i,x+j,:) = new_face(i,j,:);
      
        
    end
end
new_frame = frame;

end