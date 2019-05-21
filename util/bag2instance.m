function inst = bag2instance(bags)
% bag2instance: covert a cell array to array
% Syntax:  inst = bag2instance(bags)
%
% Inputs:
%   bags - cell array - training data organized by bags
% Outputs:
%   inst - array - N*dim(features) 
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.

num_bag = length(bags);

if num_bag == 0
    inst = [];
    inst_label = [];
end

idx = 0;
for i=1:num_bag
    num_inst = size(bags{1,i}, 1);
    inst(idx+1 : idx+num_inst, :) = bags{1,i};    
    idx = idx + num_inst;
end