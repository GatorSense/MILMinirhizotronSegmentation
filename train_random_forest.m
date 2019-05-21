function model = train_random_forest(train_bags,train_bags_label,para_train, para_train_subfea)   
% train_random_forest: train RF model 
%
% Syntax: model = train_random_forest(train_bags,train_bags_label,para_train, para_train_subfea)     
%
% Inputs:
%   train_bags - training data
%   train_bags_label - label of training data
%   para_train - Number of Trees
%   para_train_subfea - Number of variables to select at random for each decision split
% Outputs:
%   model - trainined RF model
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.

    num_train_bag = length(train_bags);

    %set the initial instance labels to bag labels
    idx = 0;
    for i=1:num_train_bag
        num_inst = size(train_bags{1,i}, 1);
        train_label(idx+1 : idx+num_inst) = repmat(train_bags_label(1,i), num_inst, 1);    
        idx = idx + num_inst;
    end
    train_label = train_label';
    [train_instance] = double(bag2instance(train_bags));
    
    paroptions = statset('UseParallel',true);
    model = TreeBagger(para_train,train_instance,train_label,'Method','classification','OOBVarImp','on',...
        'OOBPred','on','Options',paroptions,'NumPredictorsToSample',para_train_subfea);
      
end