#!/bin/bash

arr[0]=downsampled_L_hipp
arr[1]=downsampled_R_hipp
arr[2]=downsampled_L_PHC 
arr[3]=downsampled_R_PHC
arr[4]=downsampled_L_Perirhinal
arr[5]=downsampled_R_Perirhinal
arr[6]=downsampled_L_MD
arr[7]=downsampled_R_MD
arr[8]=downsampled_L_AT
arr[9]=downsampled_R_AT
arr[10]=downsampled_L_fusi
arr[11]=downsampled_R_fusi


#for i in {1001..1017} {1019..1028} USE this line instead if later doing correct/incorrect contrast rather than DPM
for i in {1001..1002} {1004..1005} {1007..1010} {1012..1017} {1019..1028}
do
cd ${i}/GLM_TENT/glm_tent_dpm
	for item in "${arr[@]}"
	do echo $item
	3dmaskave -mask ../../../StructuralROIsMAYO/TT_Daemon_ROIs/${item}+tlrc.BRIK test_scene_prev\:DPM_iresp+orig.BRIK > ../../../tImeseries_outputTTdaemon/timeseries_DPM_${item}_${i}.csv
	3dmaskave -mask ../../../StructuralROIsMAYO/TT_Daemon_ROIs/${item}+tlrc.BRIK test_scene_prev\:DPNM_iresp+orig.BRIK > ../../../tImeseries_outputTTdaemon/timeseries_DPNM_${item}_${i}.csv
 	
done

cd ../../..
done

