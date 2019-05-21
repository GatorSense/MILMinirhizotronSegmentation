function model = train_misvm(train_bags,train_bags_label,para_train,maxiter)   

% train_misvm: train MISVM model 
%
% Syntax:  model = train_misvm(train_bags,train_bags_label,para_train,maxiter)   
%
% Inputs:
%   train_bags - training data
%   train_bags_label - label of training data
%   para_train - miSVM traning parameters
%   maxiter - maximum iteration time
% Outputs:
%   model - trainined miSVM model
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
    num_train_inst = size(train_instance, 1);

    step = 1;
    past_train_label(:,step) = train_label;

    while 1
        
        model = svmtrain(train_label, train_instance, para_train);
        [train_label_predict, train_label_accuracy, train_label_dec_values]  = svmpredict(train_label, train_instance, model,'-b 1');

        idx = 0;
        for i=1:num_train_bag
            num_inst = size(train_bags{1,i}, 1);

            if train_bags_label(1,i) == 0
                train_label(idx+1 : idx+num_inst) = zeros(num_inst, 1);
            else
                if any(train_label_predict(idx+1 : idx+num_inst))
                    train_label(idx+1 : idx+num_inst) = train_label_predict(idx+1 : idx+num_inst);
                else
                    [sort_prob, sort_idx] = sort(train_label_dec_values(idx+1 : idx+num_inst));
                    train_label(idx+1 : idx+num_inst) = zeros(num_inst, 1);
                    train_label(idx + sort_idx(num_inst)) = 1;
                end
            end
            idx = idx + num_inst;
        end

        difference = sum(past_train_label(:,step) ~= train_label);
        fprintf('Number of label changes is %d\n', difference);
        if difference == 0, break; end;

        repeat_label = 0;
        for i = 1 : step
            if all(train_label == past_train_label(:, i))
                repeat_label = 1;
                break;
            end               
        end

        if repeat_label == 1
            fprintf('Repeated training labels found, quit...\n');
            break; 
        end
        
        if step > maxiter
            fprintf('reach max iteration\n');
            break; 
        end

        step = step + 1;
        past_train_label(:,step) = train_label;

    end
end



