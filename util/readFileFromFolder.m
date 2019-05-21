function file = readFileFromFolder(iter,fileParameter)
% readFileFromFolder:  Code to load files
% Syntax:  file = readFileFromFolder(iter,fileParameter)
%
% Inputs:
%   iter - a number - iter is a number between 1 to the totle number of
%                     processed file.
%   fileParameter - structure - contains directory of proceeing file and
%                     file list
% Outputs:
%   file - structure - The struct contains the following fields:
%               1.originImageFilePath: Original file name
%               2.bwFileName: GroundTruth file name
%               3.preFileName: preprocessing file name
%               4.segFileName: Instance file name
%               5.insInBagFileName: Bag file name
%               6.number: global name of a file in train/test dataset
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.

   nfolder = size((find(floor((iter-1)./fileParameter.filelist.cumfilecnt) > 0)),2) + 1;
   if  nfolder > 1
     iterfile = iter - fileParameter.filelist.cumfilecnt(nfolder-1);
   else
     iterfile = iter;
   end
   
  [pathstr,fileName,ext] = fileparts(fileParameter.filelist.files{nfolder}(iterfile).name);  
  file.originImageFilePath = [fileParameter.filelist.read_folder{nfolder},fileName,ext];
  
  savefolder_fields = fieldnames(fileParameter.savefolder);
  savefile_fields = fieldnames(fileParameter.savefile);
  loadfile_fields = fieldnames(fileParameter.loadfile);
  
  for idx = 1:length(savefolder_fields)
      filepath = strrep(fileParameter.filelist.read_folder{nfolder},fileParameter.replace_org,fileParameter.savefolder.(savefolder_fields{idx}));
      if ~exist(filepath, 'dir')
         mkdir(filepath)
      end
      file.(loadfile_fields{idx}) = [filepath,fileName,fileParameter.savefile.(savefile_fields{idx})];
  end
    
  file.number = iterfile;

end