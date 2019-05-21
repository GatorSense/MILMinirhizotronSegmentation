function model = train_svm(train_bags,train_bags_label,para_train)   
% train_svm: train SVM model 
%
% Syntax: model = train_svm(train_bags,train_bags_label,para_train)   
%
% Inputs:
%   train_bags - training data
%   train_bags_label - label of training data
%   para_train - SVM traning parameters
% Outputs:
%   model - trainined SVM model
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

    model = svmtrain(train_label, train_instance, para_train);
      
end
