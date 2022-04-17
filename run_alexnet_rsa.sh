#!/bin/bash
#SBATCH --time=168:00:00
#SBATCH --cores=4
#SBATCH --mem=8000



# Define subject IDs
Sub=$1
Num=$2



if [ ! -f /data/bswift-1/jmerch/CompSAN/searchlight/alexnet_rsa_cvdist/${Sub}_searchlight_FisherZ_cvdist_${Layer}${Num}.nii ]; then
# change into code directory
cd /data/bswift-1/jmerch/CompSAN/code

echo "---------"
echo "starting"
echo $Sub $Layer $Num
date

# module load matlab
matlab -nodesktop -nodisplay -nosplash -r "cd /data/bswift-1/jmerch/CompSAN/code ; SearchlightRSA_AlexNet_NEW $Sub $Num ; quit"

echo ""
echo "---------"
echo "ended"
date

fi
