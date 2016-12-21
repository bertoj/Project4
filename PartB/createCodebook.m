function CB = createCodebook(trainingImage)

% size of mask/2
length = 16;
width = 16;

trainingImage = rgb2gray(trainingImage);
[m, n] = size(trainingImage);
BW = edge(trainingImage,'canny');

CB = struct('edgeMap',[],'feature',[],'distance',[],'offset',[],'pos',[]);

% Creat nose mask
[x_c,y_c,P] = impixel(BW);
close all;
X = [x_c-width x_c+width x_c+width x_c-width x_c-width];
Y = [y_c-length y_c-length y_c+length y_c+length y_c-length];
mask = poly2mask(X,Y,m,n);
% nose distance from center
CB(1).distance = 0;
CB(1).offset = [0,0];
CB(1).pos = [x_c,y_c];
% nose edgemap
CB(1).edgeMap = mask.*BW; %Nose
eMap = imcrop(CB(1).edgeMap,[x_c-width,y_c-length,33,33]);
[x_c,y_c,P] = impixel(eMap);
close all;
% nose HoG vect0r
% [featureVector,hogVisualization] = extractHOGFeatures(eMap);
figure;
I = find(eMap);
[row,col] = ind2sub(size(eMap),I);
SC = getSC([row,col],[x_c,y_c],.1,20,8,4);


CB(1).feature = featureVector/sqrt(norm(featureVector)^2+.001);

for i = 2:5
% Creat feature mask
[x,y,P] = impixel(trainingImage);
X = [x-width x+width x+width x-width x-width];
Y = [y-length y-length y+length y+length y-length];
mask = poly2mask(X,Y,m,n);

% feature edgemap
CB(i).edgeMap = mask.*BW; %Nose
eMap = imcrop(CB(i).edgeMap,[x-width,y-length,33,33]);

% feature HoG vect0r
[featureVector,hogVisualization] = extractHOGFeatures(eMap);
CB(i).feature = featureVector/sqrt(norm(featureVector)^2+.001);

% distance from center
CB(i).distance = norm([(x-x_c),(y-y_c)]);
CB(i).offset = [x_c-x,y_c-y];
CB(i).pos = [x,y];
end

end