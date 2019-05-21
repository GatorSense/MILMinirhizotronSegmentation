addpath('.\parameterfile')
addpath('.\util')
%%add miace path
addpath('.\MIACE')
addpath('.\libsvm')

trainparameters = trainParameters; %load training parameters


soilfileParameter = loadFileByFolderParameters;%load training image having no root and set up saving result directory
soilfileParameter.filelist = createFileList(soilfileParameter.soil_folder,soilfileParameter.fileTypes);%make a dataset list

rootfileParameter = loadFileByFolderParameters;%load training image having root and set up saving result directory
rootfileParameter.filelist = createFileList(rootfileParameter.root_folder,rootfileParameter.fileTypes);%make a dataset list

testFileParameters = loadFileByFolderParameters;%load test file
testFileParameters.filelist = createFileList(testFileParameters.test_folder,testFileParameters.fileTypes);%test file list
testFileParameters.test =  1:1:testFileParameters.filelist.totfilecnt;%test file index

    
[bags,labels] = one_image_one_bag(soilfileParameter,rootfileParameter,trainparameters);% generate training data  

if strcmp(trainparameters.mode,'MIACE')
    [model_miace.ace.optDict, ~, model_miace.ace.b_mu, model_miace.ace.sig_inv_half] = miTarget(bags, labels, trainparameters);     

    %%test miace%%
    for iter_test = 1:length(testFileParameters.test)
        scoremap = miace_det(iter_test,model_miace,testFileParameters,trainparameters);
    %%plot results
        figure
        imagesc(scoremap)      
    end
elseif strcmp(trainparameters.mode,'miSVM') 
    %train misvm%%    
    model_miSVM = train_misvm(bags,labels,trainparameters.misvm{1},trainparameters.misvm_maxIter);
    %%test miSVM%%    
    for iter_test = 1:length(testFileParameters.test)
        [label_misvm,accuracy,scoremap_miSVM] = test_svm(iter_test,model_miSVM,testFileParameters,trainparameters);   
    %plot results miSVM
        figure
        imagesc(scoremap_miSVM)      
    end 
    
elseif strcmp(trainparameters.mode,'SVM') 
    %%train SVM%%
    model_SVM = train_svm(bags,labels,trainparameters.svm{1});
    %%test SVM%%    
    for iter_test = 1:length(testFileParameters.test)
        [label_SVM,accuracy,scoremap_SVM] = test_svm(iter_test,model_SVM,testFileParameters,trainparameters);   
    %%plot results SVM
        figure
        imagesc(scoremap_SVM)     
    end    

elseif strcmp(trainparameters.mode,'RF')
    % %%random forest%%    
    model_RF = train_random_forest(bags,labels,trainparameters.rf_tree_num,trainparameters.rf_subfeature);
    %%test RF%%    
    for iter_test = 1:length(testFileParameters.test)
        scoremap_RF = test_RF(iter_test,model_RF,testFileParameters,trainparameters);
    %%plot results RF
        figure
        imagesc(scoremap_RF)    
    end  

end
     


