# Photometric-Stereo
#### The goal of this assignment is to implement an algorithm that reconstructs a surface using the concept of photometric stereo.

## Main description

For this assignment we will use the data from Peter Belhumeur’s face database (sometimes called the Yale Face database), which I will provide.

To read in all the images as well as construct a matrix containing all corresponding lighting directions you can use Paul Schrater’s matlab routine LoadFaceImages.m (which also requires the routine getpgmraw.m), which is also provided.

As a preprocessing step you should subtract the ambient image of the other images and make sure no pixel is smaller than zero. You should also divide the image intensities by 255 to scale them from [0,1]. One possibility to reduce noise consists of convolving the image with a small Gaussian kernel (blurring), but this might not be necessary.

You can now perform photometric stereo on this data. Compute the albedo, normals and heightmap using all the available images. While the albedo and normals should look fine, it might be hard to compute an accurate heightmap. This is due to the integration stage.

Try to work out an approach that provides better results than the naive approach, e.g. by averaging multiple integration paths, verifying the integrability, etc. Also, try to select a subset of images that more closely satisfies the assumptions for the algorithm (lambertian surfaces, i.e. no specularities). Would there be a way to do this automatically, maybe on a pixel by pixel basis? Try to be creative.
You will get extra credits for trying out a new algorithm: e.g. L0/L1 loss, CNN?

## Requirements

- MATLAB

## Testing

```bash
run main.m