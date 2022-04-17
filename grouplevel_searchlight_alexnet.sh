#!/bin/tcsh

set func_dir = /export/data/neuron/CompSAN/searchlight/alexnet_rsa_cvdist/

set out_dir = /export/data/neuron/CompSAN/searchlight/grouplevel_alexnet_rsa_cvdist/

cd $out_dir

foreach i (`seq 1 5`)

	# if (( ! -f $out_dir/AlexNetRSA_conv$i+tlrc.BRIK ) && ( `ls $func_dir*conv$i.nii | wc -l` == 34 )) then
	if ( ! -f $out_dir/AlexNetRSA_conv$i+tlrc.BRIK ) then

		set c_runs = `ls $func_dir/sub-*_searchlight_FisherZ_cvdist_conv$i.nii`

		#module load afni/20.2.14
		# apply any data directories with variables

		echo --------------------------------
		echo working on conv$i
		echo $c_runs
		date
		echo --------------------------------
		3dttest++                \
		-prefix AlexNetRSA_conv$i    	\
		-mask /export/data/neuron/CompSAN/code/MNI152-graymatter-thr25-2mm.nii \
		-setA $c_runs \
		-Clustsim -prefix_clustsim conv$i \

	endif

end

