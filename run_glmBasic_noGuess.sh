#!/bin/bash
for i  in 1008 1010 1014; do
        cd ${i}
	cd GLM_BASIC
	/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G ../../glm_basic_mayo_noguess.R
	cd ../..
done

