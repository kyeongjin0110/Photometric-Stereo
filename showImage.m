function[hfigure] = showImage(albedoImage, heightMap)

% NOTE: h x w is the size of the input images
% albedoImage: h x w matrix of albedoImage 
% heightMap: h x w matrix of surface heightMaps

% some cosmetic transformations to make 3D model look better

[hgt, wid] = size(heightMap);
[X,Y] = meshgrid(1:wid, 1:hgt);
H = flipud(fliplr(heightMap));
A = flipud(fliplr(albedoImage));

figure, imshow(albedoImage);
title('albedoImage');

hfigure = figure;
mesh(H, X, Y, A);
axis equal;
xlabel('Z')
ylabel('X')
zlabel('Y')
title('heightMap Map')

% Set viewing direction
view(-60,20)
colormap(gray)
set(gca, 'XDir', 'reverse')
set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(gca, 'ZTick', []);
