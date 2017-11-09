#!/bin/bash
for i  in {1012..1017} {1019..1025}; do
        cd ${i}
	cd GLM_BASIC/glm_basic_dpm
	/home/bradley/bin/extractBuckets.R -i statout+orig -g 'GLT'
	ls *GLT*Tstat* > Tstats.txt
	/home/bradley/bin/apply_warp.R Tstats.txt
	cd ../../..
done
