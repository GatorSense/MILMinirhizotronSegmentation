function segments = superpixelFiles(imgPreProc,parameters)
% segments: This function generate index of instance of image
%
% Syntax:  segments = superpixelFiles(imgPreProc,parameters)
%
% Inputs:
%   imgPreProc - RGB image
%   parameters - structure- the following fields in the structure:
%                   (1) parameters.regionSize_seg: the size of each instance,
%                   (2) parameters.regularizer_seg: the regulariation parameter of slic
% Outputs:
%   segments -  index of instance of each pixel  
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.


regionSize = parameters.regionSize_seg;
regularizer = parameters.regularizer_seg;
segments = vl_slic(imgPreProc, regionSize, regularizer, 'verbose') ;
segments = double(segments) + 1;
end