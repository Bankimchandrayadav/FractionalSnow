%% Application of Index: NDSI

img_ls = imread('landsat_5120x5120.tif');
img_mod = imread('modis_320x320.tif');

%Landsat
ls_b3 = img_ls(:,:,3);
ls_b6 = img_ls(:,:,6);

nr = ls_b3 - ls_b6;
dr = ls_b3 + ls_b6;

ls_result = nr./dr;

%Modis

mod_b4 = img_mod(:,:,4);
mod_b6 = img_mod(:,:,6);

mod_b4 = (mod_b4+100).*0.0001;
mod_b6 = (mod_b6+100).*0.0001;

nr1 = mod_b4 - mod_b6;
dr1 = mod_b4 + mod_b6;

mod_result = nr1./dr1;

%% Conversion of landsat index image to binary

row = 5120;
col = 5120;

for i = 1:row
    for j = 1:col
        if ls_result(i,j)<= 0.40625 
            ls_result(i,j) =0; %threshold 0.4062 obtained 
        else                                  %from erdas psuedo image
            ls_result(i,j) =1;
        end
    end  
end

%% Conversion of landsat binary to landsat frac

row = 5120;
col = 5120;
frac = zeros(320,320);

for i = 1:16:row
    for j = 1:16:col
        a = (i+15)/16;
        b = (j+15)/16;
        frac(a,b)= sum(sum(ls_result(i:i+15,j:j+15)))/256;
    end
end

% Writing final files:

imwrite2tif(mod_result,[],'modis_320x320_index.tif','single')
imwrite2tif(frac,[],'landsat_320x320_frac.tif','single')
clear all;

