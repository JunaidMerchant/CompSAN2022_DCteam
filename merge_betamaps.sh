#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --cores=4
#SBATCH --mem=8000
#SBATCH --array=0-33%20

# CODE FOR MERGING BETA-MAPS FOR EASE OF USE WITH COSMOMVPA
# Define subject IDs
Subs=("sub-sid000216" "sub-sid000494" "sub-sid000667" "sub-sid000678" "sub-sid000683" "sub-sid000697" "sub-sid000706" "sub-sid000217" "sub-sid000498" "sub-sid000668" "sub-sid000679" "sub-sid000688" "sub-sid000698" "sub-sid000707" "sub-sid000375" "sub-sid000529" "sub-sid000669" "sub-sid000680" "sub-sid000692" "sub-sid000699" "sub-sid000708" "sub-sid000475" "sub-sid000570" "sub-sid000671" "sub-sid000681" "sub-sid000694" "sub-sid000704" "sub-sid000710" "sub-sid000476" "sub-sid000573" "sub-sid000677" "sub-sid000682" "sub-sid000695" "sub-sid000705")

# Define current subject
s=${Subs[${SLURM_ARRAY_TASK_ID}]}

# change into subject directory with run level REML maps
cd /data/bswift-1/jmerch/CompSAN/firstlevel_lss/${s}

# check to see if it's been done
if [ ! -f ${s}_AllActors.nii.gz ]; then
echo working on $s
date
# use fsl merge to merge them
fslmerge -a ${s}_AllActors.nii.gz $(ls ${s}_actor-*.nii.gz)
else
echo -run $x already done or NA
fi


