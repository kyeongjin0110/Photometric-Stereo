function [albedoImage,recoveringSurfaceNormal] = photometric_stereo(faceImages,lightVectors)

[imageHeight, imageWidth, image_N] = size(faceImages);
faceImages_for_mldivide = zeros(image_N,imageWidth*imageHeight);

% faceImages = (192, 168, 64)
for image_N = 1:image_N
    faceImages_for_mldivide(image_N,:) = reshape(faceImages(:,:,image_N),1,[]);
end

% faceImages_for_mldivide = (64, 32256)
% lightVectors = (64, 3)

% mldivide: \
% A*x = B
% x = A\B
g = lightVectors\faceImages_for_mldivide;

% g = (3, 32256)

temp_albedo = zeros(1,imageHeight*imageWidth);
normal = zeros(3,imageHeight*imageWidth);
for j=1:imageHeight*imageWidth
    temp_albedo(1,j) = norm(g(:,j));
    normal(:,j) = g(:,j)./norm(g(:,j));
end

albedoImage = reshape(temp_albedo,imageHeight,imageWidth);
% recovering a surface from normal
recoveringSurfaceNormal = cat(3,reshape(normal(1,:),imageHeight,imageWidth),reshape(normal(2,:),imageHeight,imageWidth),reshape(normal(3,:),imageHeight,imageWidth));

