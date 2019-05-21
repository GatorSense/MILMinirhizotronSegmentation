function [bag, label] = mul_instance_one_bag(datasetParameters, trainparameters)

% mul_instance_one_bag: generate training data for the case that there are multiple instances each bag
% Syntax:  [bag, label] = mul_instance_one_bag(datasetParameters, trainparameters)
%
% Inputs:
%   datasetParameters - structure - the following fields in the structure:
%                           (1)datasetParameters.train: training data information
%   trainparameters - structure - the following fields in the structure:
%                          (1)trainparameters.featurenormalize : scale feature
%                          (2)trainparameters.numberofnegtivebag : number of negtive bag per image
%                          (3)trainparameters.numberofpositivebag : number of positive bag per image
% Outputs:
%   bag - cell array of cell array - each cell is a cell array contains all features of instance in the bag
%   label - array of cell array - each cell is an array constain the label of each bag
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.  

    bag = {};
    label = [];

    for iter_trainImage = 1: size(datasetParameters.train,2)
        file = readFileFromFolder(datasetParameters.train(iter_trainImage),datasetParameters);  
        %fprintf('train:%d\n',datasetParameters.train(iter_trainImage))
        
        myfeatures = load(file.feFileName);
        tempfeatures = fieldnames(myfeatures);
        features = myfeatures.(tempfeatures{1});
        
        myBags = load(file.insInBagFileName);
        tempBags = fieldnames(myBags);
        if iscell(myBags.(tempBags{1}))
            bagsInsNum = myBags.(tempBags{1});
            bagLabels  = myBags.(tempBags{2});
        else
            bagsInsNum = myBags.(tempBags{2});
            bagLabels  = myBags.(tempBags{1});
        end
            
        
        normIm = features;
        norm_list = normIm(:,4:end)./trainparameters.featurenormalize;
        [~,bag_pos_ind] = find(bagLabels==1);
        [~,bag_neg_ind] = find(bagLabels==0);
        
        rand_pos_seq = randperm(size(bag_pos_ind,2));
        rand_pos_seq = bag_pos_ind(rand_pos_seq);
        rand_neg_seq = randperm(size(bag_neg_ind,2));
        rand_neg_seq = bag_neg_ind(rand_neg_seq);
        
        count =1;
        numberofpositivebag = trainparameters.numberofpositivebag;
        if length(rand_pos_seq) <= trainparameters.numberofpositivebag
           numberofpositivebag = length(rand_pos_seq);
        else
           numberofpositivebag = trainparameters.numberofpositivebag;
        end
        
        if length(rand_pos_seq) == 0
            while count <= trainparameters.numberofnegtivebag%trainparameters.numberofnegtivebag(datasetParameters.train(iter_trainImage))
                super_ind = bagsInsNum{rand_neg_seq(count)};
                [rloc,cloc] = find(features(:,1)' == super_ind');
                bag{iter_trainImage}{count} = norm_list(cloc,:);
                label{iter_trainImage}(count) = 0;
                count = count+1;
            end
        else
            while count <= numberofpositivebag%trainparameters.numberofpositivebag(datasetParameters.train(iter_trainImage))
                super_ind = bagsInsNum{rand_pos_seq(count)};
                [rloc,cloc] = find(features(:,1)' == super_ind');
                bag{iter_trainImage}{count} = norm_list(cloc,:);
                label{iter_trainImage}(count) = 1;
                count = count+1;
            end

            while count <= numberofpositivebag+trainparameters.numberofnegtivebag%trainparameters.numberofpositivebag(datasetParameters.train(iter_trainImage)) +trainparameters.numberofnegtivebag(datasetParameters.train(iter_trainImage))             
                %super_ind = bagsInsNum{rand_neg_seq(count - trainparameters.numberofpositivebag(datasetParameters.train(iter_trainImage)))};
                super_ind = bagsInsNum{rand_neg_seq(count - numberofpositivebag)};
                [rloc,cloc] = find(features(:,1)' == super_ind');            
                bag{iter_trainImage}{count} = norm_list(cloc,:);
                label{iter_trainImage}(count) = 0;
                count = count+1;
            end
        end
            
                   
    end
end