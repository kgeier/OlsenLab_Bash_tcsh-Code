#!/bin/bash

for i in {1001..1002} {1004..1005} {1007..1010} {1012..1017} {1019..1028}
do

# /home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G \
3dDeconvolve -force_TR 1.77 \
 -input ../${i}/epi/scan01+orig.BRIK ../${i}/epi/scan02+orig.BRIK ../${i}/epi/scan03+orig.BRIK ../${i}/epi/scan04+orig.BRIK ../${i}/epi/scan05+orig.BRIK ../${i}/epi/scan06+orig.BRIK \
-xout -num_stimts 6 \
-polort 5 \
#-stim_times_IM 1 ${i}_study_scene_prev_DPM.1D 'GAM' -stim_label 1 StudDPM \
#-stim_times_IM 2 ${i}_study_scene_prev_DPNM.1D 'GAM' -stim_label 2 StudDPNM \
-stim_times_IM 1 ${i}_test_scene_delay_DPM.1D 'GAM' -stim_label 1 delayDPM \
-stim_times_IM 2 ${i}_test_scene_delay_DPNM.1D 'GAM' -stim_label 2 delayDPNM \
-stim_times_IM 3 ${i}_test_scene_face_DPM.1D 'GAM' -stim_label 3 faceDPM \
-stim_times_IM 4 ${i}_test_scene_face_DPNM.1D 'GAM' -stim_label 4 faceDPNM \
-stim_times_IM 5 ${i}_test_scene_prev_DPM.1D 'GAM' -stim_label 5 prevDPM \
-stim_times_IM 6 ${i}_test_scene_prev_DPNM.1D 'GAM' -stim_label 6 prevDPNM \
-fout -tout -bucket ${i}_bc_dpm__stats4FC 



done
