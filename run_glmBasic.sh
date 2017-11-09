#!/bin/bash
for i  in {1002..1010} {1012..1014}; do
        cd ${i}
	cd GLM_BASIC
	/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G ../../glm_basic_dpm_dpnm.R
	cd ../..
done
