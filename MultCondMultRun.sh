#!/bin/bash

3dDeconvolve -force_TR 1.77 \
 -input ../1028/epi/scan01+orig.BRIK ../1028/epi/scan02+orig.BRIK ../1028/epi/scan03+orig.BRIK ../1028/epi/scan04+orig.BRIK ../1028/epi/scan05+orig.BRIK ../1028/epi/scan06+orig.BRIK \
-xout -num_stimts 17 \
-polort 5 \
-stim_times_IM 1 1028_study_scene_prev_correct.1D 'GAM' -stim_label 1 StudCor \
-stim_times_IM 2 1028_study_scene_prev_incorrect.1D 'GAM' -stim_label 2 StudIncor \
-stim_times_IM 3 1028_test_scene_delay_correct.1D 'GAM' -stim_label 3 delayCor \
-stim_times_IM 4 1028_test_scene_delay_incorrect.1D 'GAM' -stim_label 4 delayIncor \
-stim_times_IM 5 1028_test_scene_delay_DPM.1D 'GAM' -stim_label 5 delayDPM \
-stim_times_IM 6 1028_test_scene_delay_DPNM.1D 'GAM' -stim_label 6 delayDPNM \
-stim_times_IM 7 1028_test_scene_delay_NDPV.1D 'GAM' -stim_label 7 delayNDPV \
-stim_times_IM 8 1028_test_scene_face_correct.1D 'GAM' -stim_label 8 faceCor \
-stim_times_IM 9 1028_test_scene_face_incorrect.1D 'GAM' -stim_label 9 faceIncor \
-stim_times_IM 10 1028_test_scene_face_DPM.1D 'GAM' -stim_label 10 faceDPM \
-stim_times_IM 11 1028_test_scene_face_DPNM.1D 'GAM' -stim_label 11 faceDPNM \
-stim_times_IM 12 1028_test_scene_face_NDPV.1D 'GAM' -stim_label 12 faceNDPV \
-stim_times_IM 13 1028_test_scene_prev_correct.1D 'GAM' -stim_label 13 prevCor \
-stim_times_IM 14 1028_test_scene_prev_incorrect.1D 'GAM' -stim_label 14 prevIncor \
-stim_times_IM 15 1028_test_scene_prev_DPM.1D 'GAM' -stim_label 15 prevDPM \
-stim_times_IM 16 1028_test_scene_prev_DPNM.1D 'GAM' -stim_label 16 prevDPNM \
-stim_times_IM 17 1028_test_scene_prev_NDPV.1D 'GAM' -stim_label 17 prevNDPV \
-fout -tout -bucket testrun_stats4FC 
