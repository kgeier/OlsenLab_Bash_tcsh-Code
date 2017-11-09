#!/bin/bash

for i in {1001..1017} {1019..1028}
do

value=$(<../${i}/GLM_BASIC/scans.txt)
set $value

/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G \
3dDeconvolve -force_TR 1.77 \
-input ../${i}/GLM_BASIC/$1 ../${i}/GLM_BASIC/$2 ../${i}/GLM_BASIC/$3 ../${i}/GLM_BASIC/$4 ../${i}/GLM_BASIC/$5 ../${i}/GLM_BASIC/$6 \
-xout -num_stimts 9 \
-polort 5 \
-stim_times_IM 1 ${i}_study_scene_prev_correct.1D 'GAM' -stim_label 1 StudCor \
-stim_times_IM 2 ${i}_study_scene_prev_incorrect.1D 'GAM' -stim_label 2 StudIncor \
-stim_times_IM 3 ${i}_study_scene_prev_not_tested.1D 'GAM' -stim_label 3 Stud_nottested \
-stim_times_IM 4 ${i}_test_scene_delay_correct.1D 'GAM' -stim_label 4 delayCor \
-stim_times_IM 5 ${i}_test_scene_delay_incorrect.1D 'GAM' -stim_label 5 delayIncor \
-stim_times_IM 6 ${i}_test_scene_face_correct.1D 'GAM' -stim_label 6 faceCor \
-stim_times_IM 7 ${i}_test_scene_face_incorrect.1D 'GAM' -stim_label 7 faceIncor \
-stim_times_IM 8 ${i}_test_scene_prev_correct.1D 'GAM' -stim_label 8 prevCor \
-stim_times_IM 9 ${i}_test_scene_prev_incorrect.1D 'GAM' -stim_label 9 prevIncor \
-fout -tout -bucket ${i}_bc_stats4FC 
done

