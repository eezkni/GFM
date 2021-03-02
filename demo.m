%% Demo
%----------------------------------------------------------------------
%
% This is an implementation of the algorithm for calculating the
% Gabor features-basedmodel (GFM) index between two images.
%
% Please refer to the following paper
%
% Z. Ni, H. Zeng, L. Ma, J. Hou, J. Chen, and K.-K. Ma, ¡°A Gabor
% Feature-based Quality Assessment Model for the Screen Content Images,¡± 
% IEEE Transactions on Image Processing, 2018.
%----------------------------------------------------------------------

clc
clear
close

origImg = imread('.\SCI07.bmp');     
distImg = imread('.\SCI07_2_4.bmp'); 
fprintf('Image load finished. \n')


[gfm, gfm_map] = GFM(origImg, distImg);
fprintf('The score of the distorted image is %.4f \n', gfm)

