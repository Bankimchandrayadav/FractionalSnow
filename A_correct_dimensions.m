%% Reading landsat and modis tif files and setting the dimensions

%Reading landsat and modis files
img_ls = imread('landsat1.tif');
img_mod = imread('modis1.tif');

%Setting dim of landsat and modis files
img_ls1 = img_ls(1:5120,1:5120,:);
img_mod1 = img_mod(1:320,1:320,:);

%Writing files in correct dim:
imwrite2tif(img_mod1,[],'modis_320x320.tif','single');
imwrite2tif(img_ls1,[],'landsat_5120x5120.tif','single');
clear all;

