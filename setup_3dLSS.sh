#!/bin/bash

timing_dir=/mnt/LSANdata/SR/FridayNightLights/timing
output_dir=/mnt/LSANdata/SR/FridayNightLights/firstlevel_lss
parent_dir=/mnt/LSANdata/SR/FridayNightLights/ds003521/derivatives/denoised/unsmoothed

# Smash Williams (GaiusCharles)
3dDeconvolve -nodata \
             -polort -1 \
             -overwrite \
             -num_stimts 6 \
             -stim_times_IM 1 ${timing_dir}/GaiusCharles.1D 'dmBLOCK(1)' -stim_label 1 GaiusCharles \
             -stim_file 2 "${timing_dir}/nuisance_reg.txt[0]" -stim_base 2 -stim_label 2 area_pct \
             -stim_file 3 "${timing_dir}/nuisance_reg.txt[1]" -stim_base 3 -stim_label 3 sharpness \
             -stim_file 4 "${timing_dir}/nuisance_reg.txt[2]" -stim_base 4 -stim_label 4 brightness \
             -stim_file 5 "${timing_dir}/nuisance_reg.txt[3]" -stim_base 5 -stim_label 5 confidence \
             -stim_file 6 "${timing_dir}/nuisance_reg.txt[4]" -stim_base 6 -stim_label 6 face \
             -stim_times_subtract 1 \
             -x1D ${timing_dir}/actor-GaiusCharles_subtract1sec.xmat.1D \
             -x1D_stop

# Eric Taylor (KyleChandler)
3dDeconvolve -nodata \
             -polort -1 \
             -overwrite \
             -num_stimts 6 \
             -stim_times_IM 1 ${timing_dir}/KyleChandler.1D 'dmBLOCK(1)' -stim_label 1 KyleChandler \
             -stim_file 2 "${timing_dir}/nuisance_reg.txt[0]" -stim_base 2 -stim_label 2 area_pct \
             -stim_file 3 "${timing_dir}/nuisance_reg.txt[1]" -stim_base 3 -stim_label 3 sharpness \
             -stim_file 4 "${timing_dir}/nuisance_reg.txt[2]" -stim_base 4 -stim_label 4 brightness \
             -stim_file 5 "${timing_dir}/nuisance_reg.txt[3]" -stim_base 5 -stim_label 5 confidence \
             -stim_file 6 "${timing_dir}/nuisance_reg.txt[4]" -stim_base 6 -stim_label 6 face \
             -stim_times_subtract 1 \
             -x1D ${timing_dir}/actor-KyleChandler_subtract1sec.xmat.1D \
             -x1D_stop

# Jason Street (ScottPorter)
3dDeconvolve -nodata \
             -polort -1 \
             -overwrite \
             -num_stimts 6 \
             -stim_times_IM 1 ${timing_dir}/ScottPorter.1D 'dmBLOCK(1)' -stim_label 1 ScottPorter \
             -stim_file 2 "${timing_dir}/nuisance_reg.txt[0]" -stim_base 2 -stim_label 2 area_pct \
             -stim_file 3 "${timing_dir}/nuisance_reg.txt[1]" -stim_base 3 -stim_label 3 sharpness \
             -stim_file 4 "${timing_dir}/nuisance_reg.txt[2]" -stim_base 4 -stim_label 4 brightness \
             -stim_file 5 "${timing_dir}/nuisance_reg.txt[3]" -stim_base 5 -stim_label 5 confidence \
             -stim_file 6 "${timing_dir}/nuisance_reg.txt[4]" -stim_base 6 -stim_label 6 face \
             -stim_times_subtract 1 \
             -x1D ${timing_dir}/actor-ScottPorter_subtract1sec.xmat.1D \
             -x1D_stop

# Tim Riggins (TaylorKitsch)
3dDeconvolve -nodata \
             -polort -1 \
             -overwrite \
             -num_stimts 6 \
             -stim_times_IM 1 ${timing_dir}/TaylorKitsch.1D 'dmBLOCK(1)' -stim_label 1 TaylorKitsch \
             -stim_file 2 "${timing_dir}/nuisance_reg.txt[0]" -stim_base 2 -stim_label 2 area_pct \
             -stim_file 3 "${timing_dir}/nuisance_reg.txt[1]" -stim_base 3 -stim_label 3 sharpness \
             -stim_file 4 "${timing_dir}/nuisance_reg.txt[2]" -stim_base 4 -stim_label 4 brightness \
             -stim_file 5 "${timing_dir}/nuisance_reg.txt[3]" -stim_base 5 -stim_label 5 confidence \
             -stim_file 6 "${timing_dir}/nuisance_reg.txt[4]" -stim_base 6 -stim_label 6 face \
             -stim_times_subtract 1 \
             -x1D ${timing_dir}/actor-TaylorKitsch_subtract1sec.xmat.1D \
             -x1D_stop

# Matt Saracen (ZachGilford)
3dDeconvolve -nodata \
             -polort -1 \
             -overwrite \
             -num_stimts 6 \
             -stim_times_IM 1 ${timing_dir}/ZachGilford.1D 'dmBLOCK(1)' -stim_label 1 ZachGilford \
             -stim_file 2 "${timing_dir}/nuisance_reg.txt[0]" -stim_base 2 -stim_label 2 area_pct \
             -stim_file 3 "${timing_dir}/nuisance_reg.txt[1]" -stim_base 3 -stim_label 3 sharpness \
             -stim_file 4 "${timing_dir}/nuisance_reg.txt[2]" -stim_base 4 -stim_label 4 brightness \
             -stim_file 5 "${timing_dir}/nuisance_reg.txt[3]" -stim_base 5 -stim_label 5 confidence \
             -stim_file 6 "${timing_dir}/nuisance_reg.txt[4]" -stim_base 6 -stim_label 6 face \
             -stim_times_subtract 1 \
             -x1D ${timing_dir}/actor-ZachGilford_subtract1sec.xmat.1D \
             -x1D_stop

# sid000216 sid000217 sid000375 sid000475 sid000476 sid000494 sid000498 sid000529 sid000570 sid000573 sid000667 sid000668 sid000669 sid000671 sid000677 sid000678 sid000679 sid000680 sid000681 sid000682 sid000683 sid000688 sid000692 sid000694 sid000695 sid000697 sid000698 sid000699 sid000704 sid000705 sid000706 sid000707 sid000708 sid000710