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


Implementation: run demo.m