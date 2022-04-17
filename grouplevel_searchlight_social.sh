#!/bin/tcsh

set func_dir = /export/data/neuron/CompSAN/searchlight/character_rsa/
set c_runs = `ls $func_dir/sub-*_searchlight_socialnetwork.nii`

#module load afni/20.2.14
# apply any data directories with variables
cd /export/data/neuron/CompSAN/searchlight/grouplevel_character_rsa
echo --------------------------------
echo 'starting at:'
date
echo --------------------------------
3dttest++                \
-prefix SocialNetwork    	\
-mask /export/data/neuron/CompSAN/code/MNI152-graymatter-thr25-2mm.nii \
-setA $c_runs \
-Clustsim \
-prefix_clustsim SocNet_Clust
