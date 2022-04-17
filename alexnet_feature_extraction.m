% matlab code used to AlexNet features from images of actor faces. 
% requires installation of AlexNet for your version of matlab

% load image set
imds = imageDatastore('actor_images','LabelSource','foldernames');

% add labels 
imds.Labels={'GaiusCharles'
'KyleChandler'
'ScottPorter'
'TaylorKitsch'
'ZachGilford'};

% set alexnet
net = alexnet;

% to look at layer options:
%net.Layers

% Define layers
Layers={'conv1'
'conv2'
'conv3'
'conv4'
'conv5'
'data'
'drop6'
'drop7'
'fc6'
'fc7'
'fc8'
'norm1'
'norm2'
'output'
'pool1'
'pool2'
'pool5'
'prob'
'relu1'
'relu2'
'relu3'
'relu4'
'relu5'
'relu6'
'relu7'};

% set layers of interest
%layer = ['fc8'];

% set number of layers
%a = 1;

for i = 1:length(Layers)
    
    % set output
    %output = layer(i,:);
    output = Layers{i};
    outfile = fullfile('/Users/junaid/Desktop/Spring2022/CompSAN/AlexNet_RSA/alexnet_dsms_actors',[output,'_layer_mat.txt']);
    
    % extract features from layer
    features = activations(net,imds,output(1,:),'OutputAs','rows');

    % get euclidean distance between 5 face feature layer outputs
    dist = pdist(features,'euclidean');

    % squareform matrix
    dist_square = squareform(dist);
    %outfile = [output,'_layer_squaremat.txt'];

    % save vector or matrix
    dlmwrite(outfile,dist_square,'Delimiter','\t');
    %dlmwrite(outfile,dist','Delimiter','\t'); 
    %dlmwrite('layer_squaremat.txt',dist_square,'Delimiter','\t'); 

end
