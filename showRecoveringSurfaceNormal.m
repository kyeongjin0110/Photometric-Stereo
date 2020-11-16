function showrecoveringSurfaceNormal(recoveringSurfaceNormal)
% PLOTrecoveringSurfaceNormal(recoveringSurfaceNormal) displays the surface normals
%
% Input:
%   recoveringSurfaceNormal - [h w 3] matrix of unit vectors

figure;
subplot(1,3,1);
imagesc(recoveringSurfaceNormal(:,:,1), [-1 1]); colorbar; axis equal; axis tight; axis off;
title('X')

subplot(1,3,2);
imagesc(recoveringSurfaceNormal(:,:,2), [-1 1]); colorbar; axis equal; axis tight; axis off;
title('Y')

subplot(1,3,3);
imagesc(recoveringSurfaceNormal(:,:,3), [-1 1]); colorbar; axis equal; axis tight; axis off; 
title('Z')

