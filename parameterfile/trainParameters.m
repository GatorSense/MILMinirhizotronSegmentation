function parameters = trainParameters()
%This function is used to set train/test parameters
parameters.mode = 'MIACE'; 
 % set parameters.mode to run a certain MIL method. 
     %'MIACE' -- run MIACE method
     %'miSVM'-- run miSVM method
     %'SVM' -- run SVM method
     %'RF' -- run random forest(RF) method


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%parameter for train/test dataset%%%%%%%%%%%%%%%%%%%%%%

parameters.test_image_num = 1; % number of images used to validation
parameters.bagsize = 1000; % bag size (the number of pixel that each bag has)
parameters.numberofpositivebag = 100; %number of positive bag
parameters.numberofnegtivebag  =100;  %number of negtive bag
parameters.featurenormalize = [1,1,1,100,10,10,10,10,10,10,10,10,1,1,1,100000,1000,1000]; %rescale feature vector to same magnitude


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%parameter for MIACE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parameters.methodFlag = 1;  %Set to 0 for MI-SMF, Set to 1 for MI-ACE
parameters.initType = 1; %Options: 1, 2, or 3.  InitType 1 is to use best positive instance based on objective function value, type 2 is to select positive instance with smallest cosine similarity with negative instance mean, type 3 is random selection of instance from positive bag
parameters.globalBackgroundFlag = 0;  %Set to 1 to use global mean and covariance, set to 0 to use negative bag mean and covariance
parameters.softmaxFlag = 0; %Set to 0 to use max, set to 1 to use softmax in computation of objective function values of positive bags
parameters.posLabel = 1; %Value used to indicate positive bags, usually 1
parameters.negLabel = 0; %Value used to indicate negative bags, usually 0 or -1
parameters.maxIter = 1000; %Maximum number of iterations (rarely used)
parameters.samplePor = 1; % If using init1, percentage of positive data points used to initialize (default = 1) 
parameters.initK = 1000; % If using init3, number of clusters used to initialize (default = 1000);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%parameter for miSVM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parameters.misvm_maxIter = 6; %Maximum number of iterations 
parameters.misvm = strcat({'-s 0 -b 1 -t 2 -g'},{' '},{num2str(1)},{' '},{'-c'},{' '},{num2str(10)});
%-s svm_type : set type of SVM (default 0)
	%0 -- C-SVC		(multi-class classification)
	%1 -- nu-SVC		(multi-class classification)
	%2 -- one-class SVM
	%3 -- epsilon-SVR	(regression)
	%4 -- nu-SVR		(regression)
%-t kernel_type : set type of kernel function (default 2)
	%0 -- linear: u'*v
	%1 -- polynomial: (gamma*u'*v + coef0)^degree
	%2 -- radial basis function: exp(-gamma*|u-v|^2)
	%3 -- sigmoid: tanh(gamma*u'*v + coef0)
	%4 -- precomputed kernel (kernel values in training_set_file)

%-b probability_estimates : whether to train a SVC or SVR model for probability estimates, 0 or 1 (default 0)
%-g gamma : set gamma in kernel function (default 1/num_features)
%-c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%parameter for SVM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parameters.svm = strcat({'-s 0 -b 1 -t 2 -g'},{' '},{num2str(1)},{' '},{'-c'},{' '},{num2str(10)});
%-s svm_type : set type of SVM (default 0)
	%0 -- C-SVC		(multi-class classification)
	%1 -- nu-SVC		(multi-class classification)
	%2 -- one-class SVM
	%3 -- epsilon-SVR	(regression)
	%4 -- nu-SVR		(regression)
%-t kernel_type : set type of kernel function (default 2)
	%0 -- linear: u'*v
	%1 -- polynomial: (gamma*u'*v + coef0)^degree
	%2 -- radial basis function: exp(-gamma*|u-v|^2)
	%3 -- sigmoid: tanh(gamma*u'*v + coef0)
	%4 -- precomputed kernel (kernel values in training_set_file)

%-b probability_estimates : whether to train a SVC or SVR model for probability estimates, 0 or 1 (default 0)
%-g gamma : set gamma in kernel function (default 1/num_features)
%-c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%parameter for random forest(RF)%%%%%%%%%%%%%%%%%%%%%%%

parameters.rf_tree_num = 100;  %Number of Trees
parameters.rf_subfeature = 4;  %Number of variables to select at random for each decision split.

end