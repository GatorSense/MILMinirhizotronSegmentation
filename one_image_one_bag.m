function [bag,label] = one_image_one_bag(soilfileParameter,rootfileParameter,trainparameters)

% one_image_one_bag: generate training data for the case that each image is a bag 
% Syntax:  [bag,label] = one_image_one_bag(soilfileParameter,rootfileParameter,trainparameters)
%
% Inputs:
%   soilfileParameter - structure - the following fields in the structure:
%                          (1)soilfileParameter.filelist.totfilecnt: totle number of training image that having no root        
%   rootfileParameter - sturcture - the following fields in the structure:
%                          (1)rootfileParameter.filelist.totfilecnt: totle number of training image that having root        
%   trainparameters - structure - the following fields in the structure:
%                          (1)trainparameters.featurenormalize : scale feature
% Outputs:
%   bag - array of cell array - each cell is an array contains all features of instance in the bag
%   label - vector - the label of each bag
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.  

bag = {};
label = [];
for iter_soiltrain = 1:soilfileParameter.filelist.totfilecnt
    hist_indcell = {};
    soilfile = readFileFromFolder(iter_soiltrain,soilfileParameter);  
    myfeatures = load(soilfile.feFileName);
    tempfeatures = fieldnames(myfeatures);
    features = myfeatures.(tempfeatures{1});   
    max_G = max(features(:,5));
    min_G = min(features(:,5));
    hist_range = min_G:(max_G-min_G)/200:max_G;
    [bincounts,ind]= histc(features(:,5),hist_range);
    for i = 1:max(ind)
          [hist_indcell{end+1},~] = find(ind ==i);
    end
    super_ind = [];
    for i = 1:length(hist_indcell)
        if ~isempty(hist_indcell{i})
            super_ind(end+1) = hist_indcell{i}(randi(size(hist_indcell{i},1)));
        end
    end
    
    bag{end+1} = features(super_ind,4:end)./trainparameters.featurenormalize;
    label(end+1) =0;   
end

for iter_roottrain = 1:rootfileParameter.filelist.totfilecnt
    hist_indcell = {};
    rootfile = readFileFromFolder(iter_roottrain,rootfileParameter);  
    myfeatures = load(rootfile.feFileName);
    tempfeatures = fieldnames(myfeatures);
    features = myfeatures.(tempfeatures{1});   
    max_G = max(features(:,5));
    min_G = min(features(:,5));
    hist_range = min_G:(max_G-min_G)/200:max_G;
    [bincounts,ind]= histc(features(:,5),hist_range);
    for i = 1:max(ind)
          [hist_indcell{end+1},~] = find(ind ==i);
    end
    super_ind = [];
    for i = 1:length(hist_indcell)
        if ~isempty(hist_indcell{i})
            super_ind(end+1) = hist_indcell{i}(randi(size(hist_indcell{i},1)));
        end
    end
    
    bag{end+1} = features(super_ind,4:end)./trainparameters.featurenormalize;
    label(end+1) =1;   
end

end