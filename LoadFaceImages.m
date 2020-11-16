function [ambimage,imarray,lightdirs] = LoadFaceImages()% Load the set of face images.  % The routine returns% 		ambimage:  256 x 256 image illuminated under the ambient lighting%		imarray: a 3-D array of images, 256 x 256 x Nimages% 		lightdirs: 3 x Nimages array of light source directions% To use:  The routine uses a gui to let the user specify where the face% images reside in the file directory.  Just select any of the face images.% If you get the error 'OUT OF MEMORY', reduce Nimages, or increase your swap space.	[filename,pathname]=uigetfile('yale*.pgm','Select any face image');d = dir([pathname,'yale*.pgm']);filenames = {d(:).name}% file yaleB09_P00A+050E-40.pgm is badstr = 'yaleB09_P00A+050E-40.pgm';badind = find(ismember(filenames,str));filestr = cell2struct(filenames,'names',1);filestr(badind) = [];filenames = struct2cell(filestr);if nargin < 1	Nimages = length(filenames)-1;endNimages = min(Nimages,64);ambimage = getpgmraw([pathname filenames{65}]);ambimage = double(ambimage);imarray = zeros(192,168,Nimages);for j=1:(Nimages)    m = findstr(filenames{j},'A')+1;	Ang(1,j) = str2num(filenames{j}(m:(m+3)));	m = findstr(filenames{j},'E')+1;	Ang(2,j) = str2num(filenames{j}(m:(m+2)));	[im,maxgray(j)]= getpgmraw([pathname filenames{j}]);	imarray(:,:,j) = double(im); end[X,Y,Z]= sph2cart(pi*Ang(1,:)/180,pi*Ang(2,:)/180,1);lightdirs = [Y;Z;X];