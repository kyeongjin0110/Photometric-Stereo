function  heightMap = getHeightMap(recoveringSurfaceNormal,method)

% GETSURFACE computes the surface depth from normals
%   HEIGHTMAP = GETSURFACE(recoveringSurfaceNormal, IMAGESIZE, METHOD) computes
%   HEIGHTMAP from the recoveringSurfaceNormal using various METHODs.
%
% Input:
%   recoveringSurfaceNormal: height x width x 3 array of unit surface normals
%   METHOD: the intergration method to be used
%
% Output:
%   HEIGHTMAP: height map of object

[imageHeight,imageWidth,channel] = size(recoveringSurfaceNormal);

heightMap = zeros(imageHeight,imageWidth);
output = zeros(imageHeight,imageWidth);
output1 = zeros(imageHeight,imageWidth);

normal_x = recoveringSurfaceNormal(:,:,1);
normal_y = recoveringSurfaceNormal(:,:,2);
normal_z = recoveringSurfaceNormal(:,:,3);

X_PartialDerivative = normal_x./normal_z;
Y_PartialDerivative = normal_y./normal_z;

X_CumulativeSum = cumsum(X_PartialDerivative,2);
Y_CumulativeSum = cumsum(Y_PartialDerivative);

switch method
    case 'column'
        output(1,2:imageWidth) = cumsum(X_PartialDerivative(1,2:imageWidth),2);
        output(2:imageHeight,:) = Y_PartialDerivative(2:imageHeight,:);
        heightMap = cumsum(output);
     
    case 'row'
        output(2:imageHeight,1) = cumsum(Y_PartialDerivative(2:imageHeight,1));
        output(:,2:imageWidth) = X_PartialDerivative(:,2:imageWidth);
        heightMap = cumsum(output,2);
        
    case 'average'
        output(2:imageHeight,1) = cumsum(Y_PartialDerivative(2:imageHeight,1));
        output(:,2:imageWidth) = X_PartialDerivative(:,2:imageWidth);
        
        output1(1,2:imageWidth) = cumsum(X_PartialDerivative(1,2:imageWidth));
        output1(2:imageHeight,:) = Y_PartialDerivative(2:imageHeight,:);
        heightMap = (cumsum(output1)+cumsum(output,2))./2;
        
    case 'random'
        heightMap(2:imageHeight,1) = Y_CumulativeSum(2:imageHeight,1);
        heightMap(1,2:imageWidth) = X_CumulativeSum(1,2:imageWidth);
        for i = 2:imageHeight
            for j = 1:imageWidth
                currentValue = 0;
                count = 0;
                for p = 1:i-1
                    if( j-p >= 1 )
                        currentValue = currentValue+Y_CumulativeSum(1+p)+X_CumulativeSum(1+p,j-p)+Y_CumulativeSum(i,j-p)-Y_CumulativeSum(1+p,j-p)+X_CumulativeSum(i,j)-X_CumulativeSum(i,j-p);
                        count= count+1;
                    end
                end
                if(i==2 || i== imageHeight || p == i )
                    currentValue = currentValue+Y_CumulativeSum(i,1)+X_CumulativeSum(i,j);
                    count = count+1;
                end
                heightMap(i,j) = currentValue/count;
            end
        end  
end

