function features = getFeatures(face)

face = imgaussfilt(face);
% size of mask/2
length = 16;
width = 16;

face = rgb2gray(face);
[m, n] = size(face);
BW = edge(face,'canny');

[X,Y] = (meshgrid(linspace(16,n-16,100),linspace(16,m-16,100)));
X = round(X);
Y = round(Y);
features = struct('edgeMap',[],'feature',[]);
for i = 1:10000
    % Creat nose mask
    x_c = (X(i));
    y_c = (Y(i));
    
    x = [x_c-width x_c+width x_c+width x_c-width x_c-width];
    y = [y_c-length y_c-length y_c+length y_c+length y_c-length];
    mask = poly2mask(x,y,m,n);
    
    % edgemap
    features(i).edgeMap = mask.*BW;
    eMap = imcrop(features(i).edgeMap,[x_c-width,y_c-length,33,33]);
    %HoG vect0r
    [featureVector,~] = extractHOGFeatures(eMap);
    features(i).feature = featureVector/sqrt(norm(featureVector)^2+.001);
    features(i).mask = mask;
    features(i).loc = [x_c,y_c];
end
end