%%This script is used to preprocess image, generate instances as
%%superpixels, and generate feautres of each instances
addpath('.\vlfeat-0.9.21\toolbox')
addpath('.\parameterfile')
addpath('.\util')
vl_setup

fileParameter = loadFileByFolderParameters;%load file and set up saving result directory

preprocessParameter = preprocessFileParameters;%preprocess parameters

fileParameter.read_folder = [fileParameter.soil_folder,fileParameter.root_folder,fileParameter.test_folder];%combine train dataset and test dataset
fileParameter.filelist = createFileList(fileParameter.read_folder,fileParameter.fileTypes);%make a file list

for iter = 1:fileParameter.filelist.totfilecnt   

  file = readFileFromFolder(iter,fileParameter);%load one file   
  im = imread(file.originImageFilePath);
  imgPreProc = preprocessFiles(im,preprocessParameter);%preprocess image
  save(file.preFileName,'imgPreProc');
   
  segments = superpixelFiles(imgPreProc,preprocessParameter);%generate instance
  save(file.segFileName,'segments');
  
  features = computeFeaturesFromSuperpixels(imgPreProc,segments,preprocessParameter); %generate instance feature 
  save(file.feFileName,'features');

  fprintf('procee the %d image \n',iter);  

end

