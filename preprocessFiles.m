function imgPreProc = preprocessFiles(im,parameters)
% imgPreProc: This function remove striping noise from image and denoise the image with a median filter
%
% Syntax:  imgPreProc = preprocessFiles(im, parameters)
%
% Inputs:
%   im - RGB image
%   parameters - structure- the following fields in the structure :
%               (1) parameters.med_pre: is the window size of the median filter
% Outputs:
%   imgPreProc - preprocessed image
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.

  med_pre = parameters.med_pre;
  [rows,cols,dims] = size(im);
  im = im2single(im);

  meanCol = squeeze(mean(im,1));
  meanI = mean(meanCol);
  %% remove stripping noise
  for i = 1:dims
    imgPreProc(:,:,i) = im(:,:,i) - repmat(meanCol(:,i)',[size(im,1),1]) + meanI(i);
  end
  
  %%denoise with median filter
  for i = 1:dims
    imgPreProc(:,:,i) = medfilt2(imgPreProc(:,:,i), [med_pre med_pre]);
  end
  
end
