function parameters = postParameters()
%This function is used to set post processing parameters
parameters.scoremapth = 0.6; %set scoremap threshold 
parameters.sizeth = 300; %set minimum size of threshold of connected component from binarized scoremap 
parameters.eccth = 0.95; %set minimum eccentricity of threshold of connected component from binarized scoremap

end