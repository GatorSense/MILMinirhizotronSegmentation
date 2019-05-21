function filelist = createFileList(read_folder,fileTypes)

% createFileList: This function generate index of instance of training data
%
% Syntax:  segments = superpixelFiles(imgPreProc,parameters)
%
% Inputs:
%   read_folder - cell array - read all files in the root directory of each elements of cell array 
%   fileTypes - cell array - the type of files will be read from the read_folder
% Outputs:
%   filelist -  structure - the following fields in the structure:
%                   (1) read_folder: the folders that the files are read from
%                   (2) files: file list of each read_folder
%                   (3) cumfilecnt: number of files in each read_folder
%                   (4) totfilecnt: total number of files in all read_folder
%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.



   for i = 1:length(read_folder) 
     files{i} = struct([]);
       for j = 1:length(fileTypes)
         filePattern = fullfile(read_folder{i}, fileTypes{j});
         files{i} = vertcat(files{i}, dir(filePattern));
       end
      filecnt(i) = length(files{i});
   end
   
   filelist.read_folder = read_folder;
   filelist.files = files;
   filelist.cumfilecnt = cumsum(filecnt);
   filelist.totfilecnt = sum(filecnt);
   
end