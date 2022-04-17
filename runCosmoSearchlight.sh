#!/bin/bash
#SBATCH --time=168:00:00
#SBATCH --cores=6
#SBATCH --mem=12000
#SBATCH --array=0-33
## --array=0
##  --array=1-33%20

# Define subject IDs
Subs=("sub-sid000216" "sub-sid000494" "sub-sid000667" "sub-sid000678" "sub-sid000683" "sub-sid000697" "sub-sid000706" "sub-sid000217" "sub-sid000498" "sub-sid000668" "sub-sid000679" "sub-sid000688" "sub-sid000698" "sub-sid000707" "sub-sid000375" "sub-sid000529" "sub-sid000669" "sub-sid000680" "sub-sid000692" "sub-sid000699" "sub-sid000708" "sub-sid000475" "sub-sid000570" "sub-sid000671" "sub-sid000681" "sub-sid000694" "sub-sid000704" "sub-sid000710" "sub-sid000476" "sub-sid000573" "sub-sid000677" "sub-sid000682" "sub-sid000695" "sub-sid000705")

# Define current subject
Sub=${Subs[${SLURM_ARRAY_TASK_ID}]}


if [ ! -f /data/bswift-1/jmerch/CompSAN/searchlight/alexnet_rsa_cvdist2/${Sub}_searchlight_FisherZ_cvdist_conv5.nii ]; then
# change into code directory
cd /data/bswift-1/jmerch/CompSAN/code

echo "---------"
echo "starting"
echo $Sub
date

# module load matlab
matlab -nodesktop -nodisplay -nosplash -r "cd /data/bswift-1/jmerch/CompSAN/code ; SearchlightRSA_AlexNet_CVdist $Sub ; quit"

echo ""
echo "---------"
echo "ended"
date

fi