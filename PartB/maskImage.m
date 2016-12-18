function mask = maskImage(Img)

image = imshow(Img);
mask_region = imfreehand;
mask = createMask(mask_region,image);

end

