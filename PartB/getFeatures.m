function [features num] = getFeatures(face)

%face = imgaussfilt(face);
% size of mask/2
length1 = 30;
width = 30;

face = rgb2gray(face);
[m, n] = size(face);
BW = edge(face,'canny');
I = find(BW);
[y,x] = ind2sub(size(BW),I);

N=1;
Y=y(1:N:length(y));
X=x(1:N:length(x));
s = X<30;
X(s) = [];
Y(s) = [];

s1 = Y<30;
X(s1) = [];
Y(s1) = [];

s2 = X>length(x)-30;
X(s2) = [];
Y(s2) = [];

s3 = y>length(x)-30;
X(s3) = [];
Y(s3) = [];
% [X,Y] = (meshgrid(linspace(30,n-30,100),linspace(30,m-30,100)));
% X = round(X);
% Y = round(Y);
features = struct('edgeMap',[],'feature',[]);
num = length(X);
for i = 1:length(X)
    x_c = (X(i));
    y_c = (Y(i));
    
    x = [x_c-width x_c+width x_c+width x_c-width x_c-width];
    y = [y_c-length1 y_c-length1 y_c+length1 y_c+length1 y_c-length1];
    mask = poly2mask(x,y,m,n);
    
    % edgemap
    features(i).edgeMap = mask.*BW;
    %eMap = imcrop(features(i).edgeMap,[x_c-width,y_c-length1,61,61]);
    %HoG vect0r
    %      [featureVector,~] = extractHOGFeatures(eMap);
    I = find(features(i).edgeMap);
    [row,col] = ind2sub(size(features(i).edgeMap),I);
    SC = getSC([row,col],[x_c,y_c],1,40,8,4);
    features(i).feature = SC;
    features(i).mask = mask;
    features(i).loc = [x_c,y_c];
end
end