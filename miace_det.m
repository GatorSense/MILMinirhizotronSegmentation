function scoremap = miace_det(iter_testdata,train_model,datasetParameters,trainparameters)
% miace_det: Using trained MIACE model to detect 
% Syntax:  scoremap = miace_det(iter_testdata,train_model,datasetParameters,trainparameters)
%
% Inputs:
%   iter_testdata - number - take out the "iter_testdata"th data from test set 
%   train_model - sturcture- trained MIACE model
%   datasetParameters - structure - the following fields in the structure:
%                           (1)datasetParameters.test: global name of test data
%   trainparameters - structure - the following fields in the structure:
%                          (1)trainparameters.featurenormalize : scale feature
% Outputs:
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
    
    tempfeatures = fieldnames(myfeatures);
    tempSeg = fieldnames(mySeg);

    features = myfeatures.(tempfeatures{1});
    segments = mySeg.(tempSeg{1});
    
    [test_row,test_col] = size(segments);

    tempfeature = features(:,4:end);
    features_norm = tempfeature./trainparameters.featurenormalize;
    X_test= double(features_norm);

    %% miace test
    [ace_out] = ace_det(X_test',train_model.ace.optDict',train_model.ace.b_mu',train_model.ace.sig_inv_half'*train_model.ace.sig_inv_half)';

    %%reshape test
    score_vec = zeros(test_row*test_col,1);
    pixelInInstance = label2idx(segments);
    for j = 1:size(features,1)
      score_vec(pixelInInstance{features(j,1)}) = ace_out(j);    
    end
    scoremap = reshape(score_vec,test_row,test_col);
end