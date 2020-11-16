% Load face images, ambient Image, lightdir
[ambientImage,faceImages,lightVectors] = LoadFaceImages();

%faceImages = cat(3, faceImages(:,:,1:10), faceImages(:,:,20:40), faceImages(:,:,55:64));
%lightVectors = cat(2, lightVectors(:,1:10), lightVectors(:,20:40), lightVectors(:,55:64));
%size(faceImages)
%size(lightVectors)

% Transpose lightVectors
lightVectors = lightVectors'; % (3, 64) -> (64, 3)

% Preprocessing step
% subtract the ambient image of th e other images
faceImages = preprocessing(faceImages,ambientImage);

% Albedo
% compute the albedo and normal
[albedoImage,recoveringSurfaceNormal] = photometric_stereo(faceImages,lightVectors);
% albedoImage shape = (192, 168)

% Heightmap
%integrationMethod = 'column';
%integrationMethod = 'row';
%integrationMethod = 'average';
integrationMethod = 'random';
heightMap = getHeightMap(recoveringSurfaceNormal,integrationMethod);

% Display
[hfigure] = showImage(albedoImage, heightMap);
showRecoveringSurfaceNormal(recoveringSurfaceNormal);

% Save Image
%% Optionally write the output
outputDir = './output'
writeOutput = true
if writeOutput
    if ~exist(outputDir, 'file')
        mkdir(outputDir);
    end
    % Write out the albedo image
    imageName = fullfile(outputDir, sprintf('Albedo.jpg'));
    imwrite(albedoImage, imageName, 'jpg');
    
    % Write out the normals as a color image
    imageName = fullfile(outputDir, sprintf('Surface_Normals_total.jpg'));
    imwrite(recoveringSurfaceNormal, imageName, 'jpg');
    
    % Write out the normals as seperate (x, y, z) components
    imageName = fullfile(outputDir, sprintf('Normals_x.jpg'));
    imwrite(recoveringSurfaceNormal(:,:,1), imageName, 'jpg');
    
    imageName = fullfile(outputDir, sprintf('Normals_y.jpg'));
    imwrite(recoveringSurfaceNormal(:,:,2), imageName, 'jpg');

    imageName = fullfile(outputDir, sprintf('Normals_z.jpg'));
    imwrite(recoveringSurfaceNormal(:,:,3), imageName, 'jpg');
    
    imageName = fullfile(outputDir, sprintf('Normals_z.jpg'));
    imwrite(recoveringSurfaceNormal(:,:,3), imageName, 'jpg');
    
    imageName = strcat('HeightMap.jpg') ;
    saveas(hfigure,fullfile(outputDir, imageName))
end
