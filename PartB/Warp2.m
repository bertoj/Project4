function morphed = Warp2(face,trainingImage, CtrPts,CtrPts2)

[tform, ~, ~] = estimateGeometricTransform(...
    CtrPts2, CtrPts, 'projective');

Tinv  = tform.invert.T;


outputView = imref2d(size(face));
morphed  = imwarp(trainingImage,tform,'OutputView',outputView);
end