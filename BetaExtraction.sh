#!/bin/bash

arr[0]=l_AT
arr[1]=r_AT
arr[2]=l_MD
#arr[3]=r_MD




for i in {1017..1017} # {1019..1028} # USE this line instead if later doing correct/incorrect contrast rather than DPM
#for i in {1001..1002} {1004..1005} {1007..1010} {1012..1017} {1019..1028}
do
cd StimTimeFiles/ 

	for item in "${arr[@]}"
	do echo $item
	3dmaskave -mask ../StructuralROIsMAYO/ROIsuperteam/Downs_mni_${item}+tlrc.BRIK OldDeconvolveOutput/${i}_bc_stats4FC+orig.BRIK > ../BetaCorROIoutput/betaweights_${item}_${i}.csv
	3dmaskave -mask ../StructuralROIsMAYO/ROIsuperteam/Downs2_mni_${item}+tlrc.BRIK OldDeconvolveOutput/${i}_bc_stats4FC+orig.BRIK > ../BetaCorROIoutput_right/betaweights_${item}_${i}.csv



	#3dmaskave -mask ../../../StructuralROIsMAYO/ROIsuperteam/Downs_mni_${item}+tlrc.BRIK test_scene_prev\:DPNM_iresp+orig.BRIK > ../../../SuperTeamROIoutput/timeseries_DPNM_${item}_${i}.csv
        #3dmaskave -mask ../../../StructuralROIsMAYO/ROIsuperteam/Downs2_mni_${item}+tlrc.BRIK test_scene_prev\:DPM_iresp+orig.BRIK > ../../../SuperTeamROIoutput/timeseries_DPM_${item}_${i}.csv
        #3dmaskave -mask ../../../StructuralROIsMAYO/ROIsuperteam/Downs2_mni_${item}+tlrc.BRIK test_scene_prev\:DPNM_iresp+orig.BRIK > ../../../SuperTeamROIoutput/timeseries_DPNM_${item}_${i}.csv
 	


done

cd ..
done

