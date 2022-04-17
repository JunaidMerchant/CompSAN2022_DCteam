function SearchlightRSA_AlexNet_NEW(SUB,NUM)

close all; clearvars -except SUB NUM
addpath(genpath('/data/bswift-1/jmerch/CAT/code/rsatoolbox-develop'));
addpath(genpath('/data/bswift-1/jmerch/CAT/code/CoSMoMVPA-modified'));
addpath('/data/bswift-1/jmerch/CAT/code/NEWSLICETIME');
addpath('/data/bswift-1/jmerch/CompSAN/code');
addpath(genpath('/data/bswift-1/jmerch/CompSAN/code/cvVectorStats'));


% define config variables
config=cosmo_config();
config.tutorial_data_path='/data/bswift-1/jmerch/CompSAN/firstlevel_lss';
data_path=fullfile(config.tutorial_data_path);
config.output_data_path='/data/bswift-1/jmerch/CompSAN/searchlight/alexnet_rsa_cvdist';
output_path=config.output_data_path;
cd(output_path)

% Define target labels
TARGETS=[repmat(1,1,34)';repmat(2,1,142)';repmat(3,1,48)';repmat(4,1,34)';repmat(5,1,39)']; %'
CHUNKS=repmat(1,1,297)'; CHUNKS=CHUNKS(1:297,1); %'

% echo subject
disp('')
disp('--------------------------------------------------')
disp(strcat('working on: ',SUB))
datetime

% get subject data
sub_path=fullfile(data_path,SUB);
mask_fn='/data/bswift-1/jmerch/CompSAN/firstlevel_lss/MNI152-graymatter-thr25-2mm.nii.gz';
ds_fn=fullfile(data_path,SUB,strcat(SUB,'_AllActors.nii.gz'));

% create full cosmo dataset
ds_tmp = cosmo_fmri_dataset(ds_fn,...
    'mask',mask_fn,...
    'targets',TARGETS);

% use function to remove zeros
[ds,num_vox] = remove_zero_cosmo_ds(ds_tmp);


% define dsm measure
measure = @cosmo_target_dsm_corr_measure_jsm;
measure_args = struct();
measure_args.metric = 'euclidean';
measure_args.type = 'Spearman';
measure_args.center_data=true;

% creat searchlight
voxel_count=100;
nbrhood=cosmo_spherical_neighborhood(ds,'count',voxel_count);



% define alexnet dir, files, & layers
AlexDir='/data/bswift-1/jmerch/CompSAN/alexnet_dsms_actors';
AlexModels=dir('/data/bswift-1/jmerch/CompSAN/alexnet_dsms_actors/*.txt');



if NUM > 5
    LAYER=strcat('fc',num2str(NUM));
else
    LAYER=strcat('conv',num2str(NUM));
end



LAYER_RDM=dlmread(fullfile(AlexDir,strcat(LAYER,'_layer_mat.txt')));


if ~isfile(fullfile(output_path,strcat(SUB,'_searchlight_FisherZ_cvdist_',LAYER,'.nii')))
    %% echo subject
    disp('')
    disp('--------------------------------------------------')
    disp('working RSA on alex net layer:')
    disp(LAYER)
    datetime
    % Define target dsm model
    measure_args.target_dsm = LAYER_RDM;
    glm_dsm_results = cosmo_searchlight(ds,nbrhood,measure,'nproc', 6, measure_args);
    glm_dsm_results.samples=atanh(glm_dsm_results.samples);
    cosmo_map2fmri(glm_dsm_results, ...
        fullfile(output_path,strcat(SUB,'_searchlight_FisherZ_cvdist_',LAYER,'.nii')));
end







