#!/bin/bash

arr[0]=r_ant_hipp


#for i in {1001..1017} {1019..1028} # USE this line instead if later doing correct/incorrect contrast rather than DPM
for i in {1001..1002} {1004..1005} {1007..1010} {1012..1017} {1019..1028}
do
cd ${i}/GLM_TENT/glm_tent_dpm
	for item in "${arr[@]}"
	do echo $item
	3dmaskave -mask ../../../StructuralROIsMAYO/ROIsuperteam/Downs_mni_${item}+tlrc.BRIK test_scene_prev\:DPM_iresp+orig.BRIK > ../../../SuperTeamROIoutput/timeseries_DPM_${item}_${i}.csv
	3dmaskave -mask ../../../StructuralROIsMAYO/ROIsuperteam/Downs_mni_${item}+tlrc.BRIK test_scene_prev\:DPNM_iresp+orig.BRIK > ../../../SuperTeamROIoutput/timeseries_DPNM_${item}_${i}.csv
 	
done

cd ../../..
done

