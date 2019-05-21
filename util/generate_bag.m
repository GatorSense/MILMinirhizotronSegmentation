function [bag,numBags] = generate_bag(file, trainparameters)
% generate_bag: generate bag
% Syntax:  [bag,numBags] = generate_bag(file, trainparameters)
%
% Inputs:
%   file - structure - the following fields in the structure:
%             (1)file.preFileName: the preprocess image directory
%   trainparameters - sturcture - the following fields in the structure:
%             (1)trainparameters.bagsize: the number of pixels per bag
% Outputs:
%   bag - array - index of bag of each pixel
%   numBags - number - number of bags
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.
    
    imgPreProc = load(file.preFileName);
    tempimg = fieldnames(imgPreProc);
    imgPreProc_2 = imgPreProc.(tempimg{1});    
    [rows,cols,dim] = size(imgPreProc_2);
    bag_num = fix(rows*cols/trainparameters.bagsize);
    [bag,numBags] = superpixels(imgPreProc_2,bag_num);

end