#!/bin/bash
for i  in {1026..1028}; do
        cd ${i}
	cd epi 
	/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G /home/bradley/bin/do_estimate_noise.R rscan*nii
	cd ../..
done
