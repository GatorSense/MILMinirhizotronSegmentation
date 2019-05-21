function [train,test] = train_test_split(datasetParameters, trainparameters)

% train_test_split: split training dataset into train and test data
% Syntax:  [train,test] = train_test_split(datasetParameters, trainparameters)
%
% Inputs:
%   datasetParameters - structure - the following fields in the structure:
%                          (1)datasetParameters.filelist.totfilecnt: totle number of image in training dataset
%   trainparameters - structure - the following fields in the structure:
%                          (1)trainparameters.test_image_num :  number of images used for testing
% Outputs:
%   train - vector - global index of image in training dataset
%   test - vector - global index of image in training dataset
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.

rand_image_seq = randperm(datasetParameters.filelist.totfilecnt);

train = rand_image_seq(1:datasetParameters.filelist.totfilecnt-trainparameters.test_image_num);
test = rand_image_seq(datasetParameters.filelist.totfilecnt-trainparameters.test_image_num+1:end);

end