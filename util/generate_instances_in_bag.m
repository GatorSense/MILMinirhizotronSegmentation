function [bagsInsNum,bagLabels] = generate_instances_in_bag(bag,numBags,file)
% generate_instances_in_bag: put instance into bag
% Syntax:  [bagsInsNum,bagLabels] = generate_instances_in_bag(bag,numBags,file)
%
% Inputs:
%   bag - array - index of bag of each pixel
%   numBags - number - number of bags
%   file - structure - the following fields in the structure:
%             (1)file.bwFileName : GroundTruth file directory
%             (2)file.feFileName : instance features file directory
%             (3)file.segFileName: index of instance per pixel file directory
% Outputs:
%   bagsInsNum - cell array - index of instance per bag
%   bagLabels - array - bag label
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.
    
bagsInsNum = {};
bagLabels = [];

myGT = load(file.bwFileName);
tempGT = fieldnames(myGT);
BW2 = myGT.(tempGT{1});

myfeatures = load(file.feFileName);
tempfeatures = fieldnames(myfeatures);
features = myfeatures.(tempfeatures{1});

myfsegments = load(file.segFileName);
tempsegments = fieldnames(myfsegments);
segments = myfsegments.(tempsegments{1});


[rows,cols] = size(BW2);
inst_labels = BW2((features(:,3)-1)*rows +features(:,2)) ; %%instance label

for j = 1:numBags   
    inst_ind = find_ins_in_bag(features,segments,bag,j);
     if (~isempty(inst_ind))
        bagsInsNum{end+1} = inst_ind;
        [~,loc] = find(features(:,1)' == inst_ind);
        if any(sum(inst_labels(loc))>0)
           bagLabels(1,end+1) = 1;
        else
           bagLabels(1,end+1) = 0;
        end

      end

end


end