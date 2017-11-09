#!/bin/bash


arr[0]=mni_l_all_hipp_mask
arr[1]=mni_r_all_hipp_mask
#arr[2]=mni_l_all_ParaHC_mask
#arr[3]=mni_r_all_ParaHC_mask
#arr[4]=mni_l_all_PRC_mask
#arr[5]=mni_r_all_PRC_mask
#arr[6]=mni_l_all_MDThal_mask
#arr[7]=mni_r_all_MDThal_mask
#arr[8]=mni_l_all_AThal_mask
#arr[9]=mni_r_all_AThal_mask


#for i in {1001..1017} {1019..1028} USE this line instead if later doing correct/incorrect contrast rather than DPM
for i in {1001..1002} {1004..1005} {1007..1010} {1012..1017} {1019..1028}
do
cd ${i}/GLM_TENT/glm_tent_dpm
	for item in "${arr[@]}"
	do echo $item
	3dmaskave -mask ../../../StructuralROIsMAYO/${item}_downsampled+orig.BRIK test_scene_prev\:DPM_iresp+orig.BRIK > ../../../timeSeries_output/timeseries_DPM_${item}_${i}.csv
	3dmaskave -mask ../../../StructuralROIsMAYO/${item}_downsampled+orig.BRIK test_scene_prev\:DPNM_iresp+orig.BRIK > ../../../timeSeries_output/timeseries_DPNM_${item}_${i}.csv
 	
done

cd ../../..
done

