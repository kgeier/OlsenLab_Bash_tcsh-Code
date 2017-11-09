#!/bin/bash
for i  in {1016..1017} {1019..1025}; do
        cd ${i}
	cd GLM_BASIC
	/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G ../../glm_basic_dpm_dpnm.R
	cd ../..
done
