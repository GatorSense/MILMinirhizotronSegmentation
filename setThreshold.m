function thresholdResult = setThreshold(scoremap,postparameters)
% setThreshold: threshold scoremap and postprocessing 
%
% Syntax:  thresholdResult = setThreshold(scoremap,postparameters)
%
% Inputs:
%   scoremap - array - prediction results of MIL model
%
%   postparameters - structure- the following fields in the structure:
%                   1. postparameters.scoremapth: set scoremap threshold
%                   2. postparameters.sizeth: set minimum size of threshold
%                      of connected component from binarized scoremap
%                   3. postparameters.eccth: set minimum eccentricity of
%                      threshold of connected component from binarized scoremap
% Outputs:
%   thresholdResult - array - threshold result(image segementation result)

%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.

[rows,cols] = size(scoremap);
bw_th = zeros(rows,cols);
image_idx_9_10_CC = [];
stats = [];
selectImageVec = zeros(rows*cols,1);
bw_th(scoremap >= postparameters.scoremapth) =  1;
image_idx_9_10_CC = bwconncomp(bw_th);
stats = regionprops(image_idx_9_10_CC,'Eccentricity','Perimeter','Area');
stats_cell = struct2cell(stats);
stats_mat = cell2mat(stats_cell);
for j = 1:length(image_idx_9_10_CC.PixelIdxList)
    if any(stats_mat(1,j) > postparameters.sizeth) && any(stats_mat(2, j) > postparameters.eccth)
        selectImageVec(image_idx_9_10_CC.PixelIdxList{j}) = 1;
    end
end
thresholdResult = reshape(selectImageVec,rows,cols);

end