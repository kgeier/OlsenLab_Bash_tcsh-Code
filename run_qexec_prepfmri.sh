#!/bin/bash
for i  in {1001..1014}; do
        cd ${i}
	/home/bradley/bin/qexec.R /home/bradley/bin/prep_fmri.R Ol*
done
