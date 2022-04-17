#!/bin/bash

# ./setup_3dLSS.sh

timing_dir=/mnt/LSANdata/SR/FridayNightLights/timing
output_dir=/mnt/LSANdata/SR/FridayNightLights/firstlevel_lss
parent_dir=/mnt/LSANdata/SR/FridayNightLights/ds003521/derivatives/denoised/unsmoothed

for subject_id in sid000216 sid000217 sid000375 sid000475 sid000476 sid000494 sid000498 sid000529 sid000570 sid000573 sid000667 sid000668 sid000669 sid000671 sid000677 sid000678 sid000679 sid000680 sid000681 sid000682 sid000683 sid000688 sid000692 sid000694 sid000695 sid000697 sid000698 sid000699 sid000704 sid000705 sid000706 sid000707 sid000708 sid000710; do
        
    for actor_id in GaiusCharles KyleChandler ScottPorter TaylorKitsch ZachGilford; do

        3dLSS -matrix ${timing_dir}/actor-${actor_id}_subtract1sec.xmat.1D \
              -overwrite \
              -input ${parent_dir}/sub-${subject_id}_task-movie_run-1_space-MNI152NLin2009cAsym_desc-preproc_trim_denoised_bold.nii.gz \
              -save1D ${output_dir}/sub-${subject_id}/sub-${subject_id}_actor-${actor_id}_subtract1sec.LSS.1D \
              -prefix ${output_dir}/sub-${subject_id}/sub-${subject_id}_actor-${actor_id}_space-MNI152NLin2009cAsym_desc-preproc_trim_denoised_bold_subtract1sec.nii.gz
    
    done

done

# sid000216 sid000217 sid000375 sid000475 sid000476 sid000494 sid000498 sid000529 sid000570 sid000573 sid000667 sid000668 sid000669 sid000671 sid000677 sid000678 sid000679 sid000680 sid000681 sid000682 sid000683 sid000688 sid000692 sid000694 sid000695 sid000697 sid000698 sid000699 sid000704 sid000705 sid000706 sid000707 sid000708 sid000710
