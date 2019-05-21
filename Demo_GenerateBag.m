addpath('.\parameterfile')
addpath('.\util')
trainparameters = trainParameters; %load training parameters
datasetFileParameters = loadFileByFolderParameters; %load file and set up saving result directory
datasetFileParameters.read_folder = [datasetFileParameters.soil_folder,datasetFileParameters.root_folder];%combine dataset from image having root and image having no root
datasetFileParameters.filelist = createFileList(datasetFileParameters.read_folder,datasetFileParameters.fileTypes);%make a dataset list


%%generate bag of image in dataset
%%This code used to generate bag :'bag','numBags'
%%give label and instance to bag: 'BagsInsNum','BagLabels'
%%any instance is put into bag if only the center of the instance is in bag
for iter_dataset = 1:datasetFileParameters.filelist.totfilecnt
    
file = readFileFromFolder(iter_dataset,datasetFileParameters);%load one file 

[bag,numBags] = generate_bag(file,trainparameters);%generate numbags number of bags 

[bagsInsNum,bagLabels] = generate_instances_in_bag(bag,numBags,file);%put instance into bag 
   
save(file.insInBagFileName,'bagsInsNum','bagLabels')
end