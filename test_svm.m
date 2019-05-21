function [label_misvm,accuracy,scoremap] = test_svm(iter_testdata,train_model,datasetParameters,trainparameters)   

% test_RF:  Using trained SVM/MISVM model to detect 
%
% Syntax:  [label_misvm,accuracy,scoremap, ace_out] = test_svm(iter_testdata,train_model,datasetParameters,trainparameters)   
%
% Inputs:
%   iter_testdata - number - take out the "iter_testdata"th data from test set 
%   train_model - sturcture- trained SVM/MISVM model
%   datasetParameters - structure - the following fields in the structure:
%                           (1)datasetParameters.test: global name of test data
%   trainparameters - structure - the following fields in the structure:
%                          (1)trainparameters.featurenormalize : scale feature
% Outputs:
%   label_misvm - predict label
%   accuracy - predict accuracy
%   scoremap - 2D array - prediction result

%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.  

    file = readFileFromFolder(datasetParameters.test(iter_testdata),datasetParameters);
    fprintf('test:%d\n',datasetParameters.test(iter_testdata))

    myfeatures = load(file.feFileName);
    mySeg = load(file.segFileName);
    myGT = load(file.bwFileName);
    
    tempfeatures = fieldnames(myfeatures);
    tempSeg = fieldnames(mySeg);
    tempGT = fieldnames(myGT);
    
    features = myfeatures.(tempfeatures{1});
    segments = mySeg.(tempSeg{1});
    BW2 = myGT.(tempGT{1}); 
    
    [test_row,test_col] = size(segments);

    tempfeature = features(:,4:end);
    features_norm = tempfeature./trainparameters.featurenormalize;
    X_test= double(features_norm);
    X_labels = BW2((features(:,3)-1)*test_row +features(:,2)) ; %%instance label

    [label_misvm, accuracy, ace_out] = svmpredict(X_labels, X_test, train_model,'-b 1');        

    confident_misvm = ace_out(:,2);
    
    %%reshape test
    score_vec = zeros(test_row*test_col,1);
    pixelInInstance = label2idx(segments);
    for j = 1:size(features,1)
      score_vec(pixelInInstance{features(j,1)}) = confident_misvm(j);    
    end
    scoremap = reshape(score_vec,test_row,test_col);
    
    
end



