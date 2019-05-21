function parameters = loadFileByFolderParameters()
%This file is used to set path of loading data or saving result 
parameters.soil_folder = {...
           '.\dataset\Train_DataSet\soil\',...
}; % folder of train soil image 

parameters.root_folder = {...
           '.\dataset\Train_DataSet\root\',...
}; % folder of train root image

parameters.test_folder = {...
           '.\dataset\Train_DataSet\test\'...
}; % folder of test image


parameters.fileTypes = {'*.tiff', '*.png'}; %format of image

parameters.replace_org = '.\dataset\Train_DataSet'; % the root path of train/test image

parameters.savefolder = struct(...
                         'savepath_truth','.\dataset\result\GroundTruth',...       % the root dir of groundtruth   
                         'savepath_pre','.\dataset\result\PreprocessingResults',...% the root dir of result of preprocessing                                                                     
                         'savepath_seg','.\dataset\result\SuperpixelSegmentationResults',...% the root dir of result of instance
                         'savepath_fe','.\dataset\result\FeatureExtractionResults',...% the root dir of result of feautre extraction   
                         'savepath_insInBag','.\dataset\result\insInBag'...   % the root dir of result of bag and bag label result  
                         );
                     
parameters.savefile = struct(... 
                         'tail_truth','_BW2.mat',...       % the postfix filename of groundtruth     
                         'tail_pre','_pre.mat',...         % the postfix filename of result of preprocessing                                                                                             
                         'tail_seg','_sg.mat',...          % the postfix filename of result of superpixel                    
                         'tail_fe','_fe.mat',...           % the postfix filename of result of feautre extraction                       
                         'tail_insInBag','_insInBag.mat'...  % the postfix filename of result of bag and bag label               
                      ...
                         );
                     
parameters.loadfile = struct(...  
                         'bwFileName','bwFileName',...             % absolute path of groundtruth file        
                         'preFileName','preFileName',...           % absolute path of result of preprocessing file                          
                         'segFileName','segFileName',...           % absolute path of result of superpixel file    
                         'feFileName','feFileName',...             % absolute path of result of feautre extraction file          
                         'insInBagFileName','insInBagFileName'...  % absolute path of result of bag and bag label  file         
                      ...
                         );                 


end