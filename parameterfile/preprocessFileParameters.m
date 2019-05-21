function parameters = preprocessFileParameters()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%parameter for preprocess file
parameters.med_pre = 3; %% mideian filter size

%%parameter for superpixelFiles file
parameters.regionSize_seg = 10; %%number of pixel per instance
parameters.regularizer_seg = 0.01; %%superpixel regularization

%%parameter for feature file
parameters.worker = 6;  %% number of parallel core
end