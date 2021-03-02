function [score, SimMatrix] = GFM(Im1,Im2)
% ========================================================================
% GFM Index for SCI, Version 1.0
% Copyright(c) 2017 Zhangkai Ni, Huanqiang Zeng, Lin Ma, Junhui Hou, 
% Jing Chen, and Kai-Kuang Ma
% All Rights Reserved.
%
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
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
% 
%----------------------------------------------------------------------
%
%Input : (1) Im1: the first image being compared, which is a RGB image
%        (2) Im2: the second image being compared, which is a RGB image
%
%Output: (1) score: is the similarty score calculated using GFM algorithm.
%	     GFM considers the luminance component and chrominance component of images. 
%
%        (2) SimMatrix: is the local quality map of the distorted image
%        
%-----------------------------------------------------------------------
%
%Usage:
%Given 2 test images img1 and img2. For gray-scale images, their dynamic range should be 0-255.
%For colorful images, the dynamic range of each color channel should be 0-255.
%
%[score, SimMatrix] = GFM(img1, img2);
%-----------------------------------------------------------------------

%%%%%  Transform into an opponent color space
L1 = 0.06 * double(Im1(:,:,1)) + 0.63 * double(Im1(:,:,2)) + 0.27 * double(Im1(:,:,3));
L2 = 0.06 * double(Im2(:,:,1)) + 0.63 * double(Im2(:,:,2)) + 0.27 * double(Im2(:,:,3));
M1 = 0.30 * double(Im1(:,:,1)) + 0.04 * double(Im1(:,:,2)) - 0.35 * double(Im1(:,:,3));
M2 = 0.30 * double(Im2(:,:,1)) + 0.04 * double(Im2(:,:,2)) - 0.35 * double(Im2(:,:,3));
N1 = 0.34 * double(Im1(:,:,1)) - 0.60 * double(Im1(:,:,2)) + 0.17 * double(Im1(:,:,3));
N2 = 0.34 * double(Im2(:,:,1)) - 0.60 * double(Im2(:,:,2)) + 0.17 * double(Im2(:,:,3));

%%%%%%%%%%%%%%%% 
To = 330; 
Tc = 100;
lambda = 0.04;

a2 = oddspatialgabor(L1,5,0,0.43,0.03);
a5 = oddspatialgabor(L1,5,90,0.43,0.03);
GO1 = a2 + a5;

b2 = oddspatialgabor(L2,5,0,0.43,0.03);
b5 = oddspatialgabor(L2,5,90,0.43,0.03);
GO2 = b2 + b5;

Pm = max(abs(GO1), abs(GO2));

GoSimMatrix = (2 * GO1 .* GO2 + To) ./(GO1.^2 + GO2.^2 + To);
ISimMatrix = (2 * M1 .* M2 + Tc) ./ (M1.^2 + M2.^2 + Tc);
QSimMatrix = (2 * N1 .* N2 + Tc) ./ (N1.^2 + N2.^2 + Tc);

SimMatrix = GoSimMatrix .* real((ISimMatrix .* QSimMatrix) .^ lambda);
score = sum(SimMatrix(:).* Pm(:))/sum(Pm(:));


function Oim = oddspatialgabor(im, wavelength, angle, kx, ky)
    
    % Construct even and odd Gabor filters
    sigmax = wavelength*kx;
    sigmay = wavelength*ky;
    
    sze = round(3*max(sigmax,sigmay));
    [x,y] = meshgrid(-sze:sze);
    
    oddFilter = exp(-(x.^2/sigmax^2 + y.^2/sigmay^2)/2)...
	     .*sin(2*pi*(1/wavelength)*x);    

    oddFilter = imrotate(oddFilter, angle, 'bilinear');    

    Oim = filter2(oddFilter,im);  % Odd filter result
end

    
    



