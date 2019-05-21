addpath('.\parameterfile')
addpath('.\util')
%%add miace path
addpath('.\MIACE')
addpath('.\libsvm')

trainparameters = trainParameters; %load training parameters
postparameters = postParameters; %load post processing parameters
%%load train file
datasetFileParameters = loadFileByFolderParameters; %load file and set up saving result directory
datasetFileParameters.read_folder = [datasetFileParameters.soil_folder,datasetFileParameters.root_folder]; %combine dataset from image having root and image having no root
datasetFileParameters.filelist = createFileList(datasetFileParameters.read_folder,datasetFileParameters.fileTypes); %make a dataset list

%%load test file 
testFileParameters = loadFileByFolderParameters;%load test file
testFileParameters.filelist = createFileList(testFileParameters.test_folder,testFileParameters.fileTypes);%test file list
testFileParameters.test =  1:1:testFileParameters.filelist.totfilecnt; %test file index

[datasetFileParameters.train, datasetFileParameters.test] = train_test_split(datasetFileParameters, trainparameters);%split dataset into training data and validation data
[datasetFileParameters.bag, datasetFileParameters.label] = mul_instance_one_bag(datasetFileParameters, trainparameters);% generate training data


%convert training data format
bags = {};
labels = [];
for i = 1:length(datasetFileParameters.bag)
bags = [bags,datasetFileParameters.bag{i}];  
end
labels = cell2mat(datasetFileParameters.label); 

%%train and validation
if strcmp(trainparameters.mode,'MIACE')
    %%train miace%%
    [model_miace.ace.optDict, ~, model_miace.ace.b_mu, model_miace.ace.sig_inv_half] = miTarget(bags, labels, trainparameters); 
    %%validation miace%%
    for iter_val = 1:length(datasetFileParameters.test)
        scoremap = miace_det(iter_val,model_miace,datasetFileParameters,trainparameters);
        thresholdResult = setThreshold(scoremap,postparameters);
     %%plot results
        figure
        subplot(1,2,1)
        imagesc(scoremap)
        subplot(1,2,2)
        imagesc(thresholdResult)
        
    end
    %%test miace%%
    for iter_test = 1:length(testFileParameters.test)
        scoremap = miace_det(iter_test,model_miace,testFileParameters,trainparameters);
        thresholdResult = setThreshold(scoremap,postparameters);
     %%plot results
        figure
        subplot(1,2,1)
        imagesc(scoremap)
        subplot(1,2,2)
        imagesc(thresholdResult)  
    end
    
elseif strcmp(trainparameters.mode,'miSVM') 
    %%train misvm%%    
    model_miSVM = train_misvm(bags,labels,trainparameters.misvm{1},trainparameters.misvm_maxIter);
    %%validation miSVM%%    
    for iter_val = 1:length(datasetFileParameters.test)
        [label_misvm,accuracy,scoremap_miSVM] = test_svm(iter_val,model_miSVM,datasetFileParameters,trainparameters);   
        thresholdResult = setThreshold(scoremap_miSVM,postparameters);
     %%plot results
        figure
        subplot(1,2,1)
        imagesc(scoremap_miSVM)
        subplot(1,2,2)
        imagesc(thresholdResult)   
    end 
    %%test miSVM%%    
    for iter_test = 1:length(testFileParameters.test)
        [label_misvm,accuracy,scoremap_miSVM] = test_svm(iter_test,model_miSVM,testFileParameters,trainparameters);   
        thresholdResult = setThreshold(scoremap_miSVM,postparameters);
     %%plot results
        figure
        subplot(1,2,1)
        imagesc(scoremap_miSVM)
        subplot(1,2,2)
        imagesc(thresholdResult)    
    end 
    
elseif strcmp(trainparameters.mode,'SVM') 
    %%train SVM%%
    model_SVM = train_svm(bags,labels,trainparameters.svm{1});
    %%validation SVM%%    
    for iter_val = 1:length(datasetFileParameters.test)
        [label_SVM,accuracy,scoremap_SVM] = test_svm(iter_val,model_SVM,datasetFileParameters,trainparameters);   
        thresholdResult = setThreshold(scoremap_SVM,postparameters);
     %%plot results
        figure
        subplot(1,2,1)
        imagesc(scoremap_SVM)
        subplot(1,2,2)
        imagesc(thresholdResult)     
    end
    %%test SVM%%    
    for iter_test = 1:length(testFileParameters.test)
        [label_SVM,accuracy,scoremap_SVM] = test_svm(iter_test,model_SVM,testFileParameters,trainparameters);   
        thresholdResult = setThreshold(scoremap_SVM,postparameters);
     %%plot results
        figure
        subplot(1,2,1)
        imagesc(scoremap_SVM)
        subplot(1,2,2)
        imagesc(thresholdResult)     
    end

elseif strcmp(trainparameters.mode,'RF')
    %%random forest%%    
    model_RF = train_random_forest(bags,labels,trainparameters.rf_tree_num,trainparameters.rf_subfeature);
    %%validation RF%%    
    for iter_val = 1:length(datasetFileParameters.test)
        scoremap_RF = test_RF(iter_val,model_RF,datasetFileParameters,trainparameters);
        thresholdResult = setThreshold(scoremap_RF,postparameters);
     %%plot results
        figure
        subplot(1,2,1)
        imagesc(scoremap_RF)
        subplot(1,2,2)
        imagesc(thresholdResult)         
    end 
    %%test RF%%    
    for iter_test = 1:length(testFileParameters.test)
        scoremap_RF = test_RF(iter_test,model_RF,testFileParameters,trainparameters);
        thresholdResult = setThreshold(scoremap_RF,postparameters);
     %%plot results
        figure
        subplot(1,2,1)
        imagesc(scoremap_RF)
        subplot(1,2,2)
        imagesc(thresholdResult)   
    end 
end



    
    



