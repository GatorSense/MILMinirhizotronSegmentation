# MILMinirhizotronSegmentation

**Root Identification in Minirhizotron Imagery with Multiple Instance Learning**

_Guohao Yu, Alina Zare_

If you use this code, cite it: Guohao Yu & Alina Zare. (2019, May 21). GatorSense/MILMinithizotronSegmentation: Initial Release (Version v1.0). Zenodo.

In this repository, we provide the code used in paper "Root Identification in Minirhizotron Imagery with Multiple Instance Learning"

## Installation Prerequisites

This code uses

(1)VLFeat 0.9.21 open source library from matlab

Download the VLFeat binary package "vlfeat-0.9.21-bin.tar.gz" , extracted in the current folder and setup it following  https://github.com/vlfeat/vlfeat/blob/master/README.md

(2)LIBSVM library from matlab

Setup the LIBSVM. Run ./libsvm/matlab/make.m 

(following https://github.com/cjlin1/libsvm/blob/master/matlab/README)

## Demo
For bag size same as instance or image

step 1:
Run 'Demo_GenearteInstance.m' in MATLAB to generate instance and instance features for MIL algorithm

step 2:
Run 'Demo3_mainOneInstanceOneBag.m' in MATLAB to train and test MIL model for the case that there is one instance per bag

or Run 'Demo2_mainOneImageOneBag.m' in MATLAB to train and test MIL model for the case that one image per bag

For other bag size

step 1:
Run 'Demo_GenearteInstance.m' in MATLAB to generate instance and instance features for MIL algorithm

step 2:
Run 'Demo_GenerateBag.m' in MATLAB to generate bag for MIL algorithm

step 3:
Run 'Demo1_mainMulnstanceOneBag.m' in MATLAB to train and test MIL model for the case that there are multple instances per bag

## Inventory
```

└── root dir
    ├── dataset   //save your dataset in this folder.
    ├── libsvm //The LIBSVM library
    ├── MIACE // The MIACE repo
    ├── parameterfile  //parameter files
    ├── MIMRF_Paper.pdf  //related publication
    ├── vlfeat-0.9.21 //vlfeat-0.9.21 library
    ├── Demo_GenerateInstance.m // generate instances and instance features
    ├── Demo_GenerateBag.m // generate bags for bag smaller than whole image but larger than one instance
    ├── Demo_mainOneInstanceOneBag.m // train and test MIL method for the case that only one instance per bag
    ├── Demo_mainOneImageOneBag.m // train and test MIL method for the case that image per bag
    ├── Demo_mainMulnstanceOneBag.m // train and test MIL method for the case that multiple instances per bag
    ├── preprocessFiles.m // preprocessing image function
    ├── superpixelFiles.m // generate instance function
    ├── computeFeaturesFromSuperpixels.m // compute instance features function
    ├── mul_instance_one_bag.m // training data for the case that multiple instances per bag
    ├── one_instance_one_bag.m // training data for the case that only one instance per bag
    ├── one_image_one_bag.m // training data for the case that image per bag
    ├── one_instance_one_bag.m // compute instance features function
    ├── miace_det.m //  test MIACE function
    ├── train_misvm.m // train MISVM function
    ├── train_svm.m // train SVM function
    ├── train_random_forest.m // train RF function
    ├── test_svm.m // test SVM function
    ├── test_RF.m // test RF function
    └── util  //utility functions   
        ├── find_ins_in_bag.m //find instances in bag
        ├── generate_bag.m  // create bags.
        ├── generate_instances_in_bag.m  // find instances in bag and bag label
        ├── bag2instance.m  //
        ├── createFileList.m //
        ├── readFileFromFolder.m //
        └── train_test_split.m  //split dataset to train and test

```
