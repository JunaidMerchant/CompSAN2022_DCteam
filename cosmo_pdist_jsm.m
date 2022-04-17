function d=cosmo_pdist_jsm(x, targets)
% compute pair-wise distance between samples in a matrix
%
% d=cosmo_pdist(x[, distance])
%
% Inputs:
%   x            PxM matrix for P samples and M features
%   distance     distance metric: one of 'euclidean' (default),
%                'correlation' (computing one-minus-correlation), or any
%                other metric supported by matlab's built-in 'pdist'
%
% Outputs:
%   d            1xN row vector with pairwise distances, where N=M*(M-1),
%                containing the distances of the lower triangle of the
%                distance matrix
%
% Examples:
%     data=[1 4 3; 2 2 3; 4 2 0;0 1 1];
%     % compute pair-wise distances with euclidean distance metric.
%     % since there are 4 samples, there are 4*3/2=6 pairs of samples.
%     d=cosmo_pdist(data);
%     cosmo_disp(d);
%     %|| [ 2.24      4.69      3.74      3.61         3      4.24 ]
%     %
%     % this gives the same output
%     d=cosmo_pdist(data,'euclidean');
%     cosmo_disp(d);
%     %|| [ 2.24      4.69      3.74      3.61         3      4.24 ]
%     %
%     % compute distances with one-minus-correlation distance metric
%     d_c=cosmo_pdist(data,'correlation');
%     cosmo_disp(d_c);
%     %|| [ 0.811      1.65    0.0551      1.87       0.5      1.87 ]
%
% Notes:
%   - this function provides a native implementation for 'euclidean' and
%     'correlation'; other distance metrics require the pdist function
%     supplied in the matlab stats toolbox, or the octave statistics
%     package
%   - the rationale for providing this function is to support pair-wise
%     distances on platforms without the stats toolbox
%   - to compute pair-wise distances on a dataset struct, use
%     cosmo_dissimilarity_matrix_measure
%   - the output of this function can be given to [cosmo_]squareform to
%     recreate a PxP distance matrix
%
% See also: cosmo_dissimilarity_matrix_measure, cosmo_squareform
%
% #   For CoSMoMVPA's copyright information and license terms,   #
% #   see the COPYING file distributed with CoSMoMVPA.           #

% REWORKED THIS WHOLE FUNCTION - JSM APRIL 15 2022

% get number of samples, classes, number of classes, and set up empty
% vectors/mats
ns=size(x,1);
classes=unique(targets);
nclasses=size(classes,1);
d=zeros(1,nclasses*(nclasses-1)/2);
Mat=zeros(nclasses,nclasses);

% set up counter
C=1;

% loop through classes twice
for c1=1:nclasses
    for c2=1:nclasses
        
        % as long as the class labels don't match, and the cell has not
        % been filled for the corresponding pair
        if c1~=c2 & Mat(c1,c2) == 0
            
            % separate the class data
            class1=x(targets==classes(c1),:);
            class2=x(targets==classes(c2),:);
            
            % get crossvalidated euclidean distance between 
            [ euclideanDistance, squaredDistance, CI, CIDistribution ] = cvDistance( class1, class2, false);
            
            % add to mat
             Mat(c1,c2)=euclideanDistance;
             Mat(c2,c1)=euclideanDistance;
            
            % add to vector
            d(1,C)=euclideanDistance;
            
            % add to counter
            C=C+1;
        end
    end
end
            



% for k=1:ns
%     ji=((k+1):ns);
%     nj=numel(ji);
%     idxs=pos+(1:nj);
%     
%     delta=bsxfun(@minus,x(k,:),x(ji,:));
%     d_idxs=sqrt(sum(delta.^2,2));
%     
%     d(idxs)=d_idxs;
%     pos=pos+nj;
% end
% 


