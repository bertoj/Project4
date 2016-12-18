function recovered = Warp2(face,trainingImage, CtrPts,CtrPts2)

[tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(...
    CtrPts2, CtrPts, 'similarity');

Tinv  = tform.invert.T;

ss = Tinv(2,1);
sc = Tinv(1,1);
scaleRecovered = sqrt(ss*ss + sc*sc);
thetaRecovered = atan2(ss,sc)*180/pi;

outputView = imref2d(size(face));
recovered  = imwarp(trainingImage,tform,'OutputView',outputView);
recovered = imfuse(face,recovered,'blend');
%figure, imshowpair(face,recovered,'montage');
%figure, imshowpair(face,trainingImage,'montage');
end