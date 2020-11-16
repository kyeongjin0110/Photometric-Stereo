function output = preprocessing(faceImages,ambientImage)

% PREPAREDATA prepares the images for photometric stereo
%   OUTPUT = PREPAREDATA(faceImages, AMBIENTIMAGE)
%
%   Input:
%       faceImages - [h w n] image array
%       AMBIENTIMAGE - [h w] image 
%
%   Output:
%       OUTPUT - [h w n] image, suitably processed
%

[imageHeight,imageWidth,image_N] = size(faceImages);

output = zeros(imageHeight,imageWidth,image_N);

for index = 1:image_N
    output(:,:,index) = (faceImages(:,:,index)-ambientImage);
    output(output<0) = 0;
end

output = output./max(output(:));
 