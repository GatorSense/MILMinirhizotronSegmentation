function features = computeFeaturesFromSuperpixels(imgPreProc,segments,parameters)    
% computeFeaturesFromSuperpixels:  Code to compute features from each
% superpixel from minirhizotron imagery for root vs. soil segmentation
%
% Syntax:  features = computeFeaturesFromSuperpixels(imgPreProc,segments,file,parameters)
%
% Inputs:
%   imgPreProc - double Mat - NxMx3 matrix of RGB values (minirhizotron image) NxM image size with 3 bands (corresponding to R, G, and B)
%   segments   - unit32 Mat - NxM matrix containing the index of the
%                   instnace associated with each pixel in the image
%
%   parameters - structure- the following fields in the structure:
%                   1. parameters.worker: number of parallel cores
% Outputs:
%   features - double Mat - KxD where K is the number of superpixels and D
%               is the number of resulting features. 

%
% University of Florida, Electrical and Computer Engineering
% Email Address: guohaoyu@ufl.edu
% Latest Revision: May 5, 2019
% This product is Copyright (c) 2019 University of Florida
% All rights reserved.

    worker = parameters.worker;

    lab_im = rgb2lab(imgPreProc);
    [row,col,dim] = size(imgPreProc);
    
    Vector_rgb = reshape(imgPreProc,row*col,3);   
    Vector_lab = reshape(lab_im,row*col,3);  
    
    
    segments = double(segments);
    supidx = label2idx(segments);
    len_supidx = cellfun(@length,supidx);
    nonzeros_supidx = find(len_supidx ~=0);
    supidx_zr = supidx(nonzeros_supidx);

    
    numberSeg = length(supidx_zr);
    maxiter = fix(numberSeg /worker);
    
    cellSegInd = [];
    for i = 1:worker
        if i == worker
          cellSegInd{i} = (i-1)*maxiter+1:numberSeg;
        else
          cellSegInd{i} = (i-1)*maxiter+1:i*maxiter;  
        end
    end
     
   
 parfor i = 1:worker
    for k = 1:length(cellSegInd{i})  
        sup_ind = []; 
        sup_rgb_value = [];
        sup_lab_value = [];
        
        sup_ind = supidx_zr{cellSegInd{i}(k)};       
        numpixelinsup = size(sup_ind,1);
           
        sup_rgb_value = Vector_rgb(sup_ind,:);
        sup_lab_value = Vector_lab(sup_ind,:);
        
        med_ind = floor(size(sup_ind,1)/2);
        med_poy{i}(k) = floor((sup_ind(med_ind)-1)/row)+1;
        med_pox{i}(k) = mod(sup_ind(med_ind)-1,row)+1;
        
        hist_rgb = hist(sup_rgb_value,256)/size(sup_ind,1);
        hist_lab = hist(sup_lab_value,256)/size(sup_ind,1);
        entropy_rgb{i}(k,:) = -sum(hist_rgb.*log2(hist_rgb+eps));
        entropy_lab{i}(k,:) = -sum(hist_lab.*log2(hist_lab+eps));
        
        mean_rgb{i}(k,:) = sum(sup_rgb_value)/numpixelinsup;
        mean_lab{i}(k,:) = sum(sup_lab_value)/numpixelinsup;   
           
        var_rgb{i}(k,:) = sum(abs(sup_rgb_value - sum(sup_rgb_value,dim)./numpixelinsup).^2) ./ numpixelinsup;
        var_lab{i}(k,:) = sum(abs(sup_lab_value - sum(sup_lab_value,dim)./numpixelinsup).^2) ./ numpixelinsup;
    
    end
 end
    
   features = [nonzeros_supidx',cell2mat(med_pox)',cell2mat(med_poy)',cell2mat(mean_rgb'),cell2mat(mean_lab'),cell2mat(entropy_rgb'),cell2mat(entropy_lab'),cell2mat(var_rgb'),cell2mat(var_lab')];
 
end