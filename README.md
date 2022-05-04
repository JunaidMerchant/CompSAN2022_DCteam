# CompSAN 2022 Data Competition - Washington DC Team

This was a collaborative effort by Junaid S Merchant, Shawn A Rhoads, Oliver Xie, and Sarah Dziura (Georgetown University and University of Maryland).

- Please note that because this was a collaborative effort across different institutions and computing resources, the paths and formats of the different pieces of code are not unified (reflecting different practices of the people involved.)

- Though this repository does not include code for all the different analyses that we conducted (not included in the abstract or poster). However, along the way, we relied heavily on python libraries (`nilearn`, `sklearn`, `nibabel`, `nltools`, `scipy`, `networkx`, and others), MATLAB toolboxes, (`cvVectorStats` - https://github.com/fwillett/cvVectorStats, `CoSMoMVPA` - https://github.com/CoSMoMVPA, `AlexNet`, and others), as well as numerous AFNI functions.

### Brief descriptions of the scripts 

`/actor_images` - directory with images to derive alexnet features

`alexnet_feature_extraction.m` - code used for extracting alexnet features

`aws_rekognition_get_celebrities.md` - describes basic AWS Celebrity Detect Rekognition functions

`aws_rekognition_page_results.sh` - code for paging through rekognition results and printing to json files

`aws_rekognition_parse_celebrity_output.py` - parsing the resulting json files from rekognition 

`/celebrity_detect_rekognition_data` - data from rekognition that includes time stamps for each actor

`compSAN_DC_Group_Abstract.pdf` - abstract submitted to CompSAN data competition

`compSAN_DC_Group_Poster.pdf` - poster submitted to CompSAN data competition

`cosmo_pdist_jsm.m` - modified cosmomvpa function

`cosmo_target_dsm_corr_measure_jsm.m` - modified cosmomvpa function

`/event_timing` - directory with face event timing and regressor files for first-level modeling

`get_wikinet_rdms.py` - construct RDM from edgelist generated from Wikipedia pages and plot figures

`grouplevel_searchlight_alexnet.sh` - group-level t-test on subject searchlights for alexnet rsa

`grouplevel_searchlight_social.sh` - group-level t-test on subject searchlights for social relationship rsa

`lss_conca_timing.m` - concatenate timing for afni lss

`lss_conca_timing_v2.m` - concatenate timing for afni lss

`lss_covert_1D.m` - convert timing to 1d files for afni lss

`lss_covert_1D_v2.m` - convert timing to 1d files for afni lss

`merge_betamaps.sh` - merge beta-maps for ease of use with cosmomvpa

`/model_rdm_data` - csv files of rdm data used in rsa

`remove_zero_cosmo_ds.m` - helper function for use with cosmomvpa that removes zeros before calculating similarity 

`run_3dLSS.sh` - script for running afni 3dLSS

`run_alexnet_rsa.sh` - wrapper for running subject-level alexnet searchlight on high performance computer

`run_social_rsa.sh` - wrapper for running subject-level social relationships searchlight on high performance computer

`searchlight_rsa_alexnet.m` - main function for running subject-level alexnet searchlight using cosmomvpa

`searchlight_rsa_social.m` - - main function for running subject-level social relationship searchlight using cosmomvpa

`setup_3dLSS.sh` - 3ddeconvolve function used to set up xmats for afni 3dLSS