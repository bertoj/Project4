% img = double (height)x(width) array (grayscale image) with values in the
% range 0-255
% x = nx1 vector representing the column coordinates of corners
% y = nx1 vector representing the row coordinates of corners
% descs = 64xn matrix of double values with column i being the 64 dimensional
% descriptor computed at location (xi, yi) in im
function [descs] = feat_desc(img, x, y)
num  = length(y);

% Pad in case feature is near the bounds of the image
img = im2double(padarray(img, [20, 20])); % pad around with zeros
kernel = fspecial('gaussian'); % gaussian kernel to filter patch

for i = 1:num
    % Define 40x40 window
    % Take 20 points to the left of feature point, and 19 points to the
    % left. Displace by 20 because of padding 
    window = img((y(i)+20)-20 : (y(i)+20)+19, (x(i)+20)-20 : (x(i)+20)+19);
    % Apply gausian filter
    window = imfilter(window, kernel, 'same');
    % sampple every 5 pixels to make 8x8 window
    sub_sample = window(1:5:40, 1:5:40);
    descs(: , i) = reshape(sub_sample, [64, 1]);
    % Normalize 8x8 window 
    descs(: , i) = (descs(: , i) - mean(descs(: , i)));
    descs(: , i) =  descs(: , i)./std(descs(: , i));
end
end
