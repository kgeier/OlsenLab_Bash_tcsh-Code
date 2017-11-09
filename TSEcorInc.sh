#!/bin/bash

arr[0]=l_acc
arr[1]=l_all_hipp_
arr[2]=l_ant_hipp
arr[3]=l_AT
arr[4]=l_caud
arr[5]=l_erc
arr[6]=l_fusi
arr[7]=l_MD
arr[8]=l_pcc
arr[9]=l_phc
arr[10]=l_post_hipp
arr[11]=l_prc
arr[12]=l_precun
arr[13]=r_acc
arr[14]=r_all_hipp_
arr[15]=r_ant_hipp
arr[16]=r_AT
arr[17]=r_caud
arr[18]=r_erc
arr[19]=r_fusi
arr[20]=r_MD
arr[21]=r_pcc
arr[22]=r_phc
arr[23]=r_post_hipp
arr[24]=r_prc
arr[25]=r_precun




for i in {1001..1017} {1019..1028} #USE this line instead for correct/incorrect contrast rather than DPM
#for i in {1001..1002} {1004..1005} {1007..1010} {1012..1017} {1019..1028}
do
cd ${i}/GLM_TENT/glm_tent
	for item in "${arr[@]}"
	do echo $item
#	3dmaskave -mask ../../../StructuralROIsMAYO/ROIsuperteam/Downs_mni_${item}+tlrc.BRIK test_scene_prev\:correct_iresp+orig.BRIK > ../../../SuperTeamROIoutput/timeseries_correct_${item}_${i}.csv
#	3dmaskave -mask ../../../StructuralROIsMAYO/ROIsuperteam/Downs_mni_${item}+tlrc.BRIK test_scene_prev\:incorrect_iresp+orig.BRIK > ../../../SuperTeamROIoutput/timeseries_incorrect_${item}_${i}.csv
        3dmaskave -mask ../../../StructuralROIsMAYO/ROIsuperteam/Downs2_mni_${item}+tlrc.BRIK test_scene_prev\:correct_iresp+orig.BRIK > ../../../SuperRightROIoutput/timeseries_correct_${item}_${i}.csv
        3dmaskave -mask ../../../StructuralROIsMAYO/ROIsuperteam/Downs2_mni_${item}+tlrc.BRIK test_scene_prev\:incorrect_iresp+orig.BRIK > ../../../SuperRightROIoutput/timeseries_incorrect_${item}_${i}.csv
 	
done

cd ../../..

done
echo For weird ROI reasons, left and right have to be done separately so run code again with other two lines commented out and remove the 0kb output files. (At least until this is fixed)


