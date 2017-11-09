#!/bin/bash
for i in {1001..1017} {1019..1025}; do
        cd ${i}
	cd GLM_BASIC/glm_basic
	/home/bradley/bin/blur.R -f 6 -m ../../epi/nw_global_mask.nii nw*nii
	cd ../../..
done
