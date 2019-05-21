function inst = find_ins_in_bag(features,segments,L,sp_num) 

% find_ins_in_bag :Only instance center in bag are treated as instance in bag
%
% Syntax:  inst = find_ins_in_bag(features,segments,L,sp_num)
%
% Inputs:
%   features - 2D array - instance feature 
%   segments - 2D array - the instance index of each pixel
%   L - 2D array - the bag index of each pixel
%   sp_num - number - a bag index
% Outputs:
%   inst -  vector - the index of pixel in bag sp_num 
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.

[rows,cols] = size(L);

%create a mask, only center of each instance are labeled as 1
%others are 0s
center_sp_mask = zeros(rows,cols);
center_sp_mask((features(:,3)-1)*rows +features(:,2)) = 1; 

%%create a mask, only pixels in bag are labeled as 1
%%others are 0s
selectsp_mask = zeros(rows,cols);
selectsp_mask(find(L == sp_num)) = 1;

%%find center
select_sp_sl = center_sp_mask .*selectsp_mask;

inst = segments(find(select_sp_sl == 1));

end













