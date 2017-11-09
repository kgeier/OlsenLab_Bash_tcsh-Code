#!/bin/bash
for i  in {1026..1028}; do
        cd ${i}
	cd anatomy 
	/home/bradley/bin/qexec.R /home/bradley/bin/do_fast.R 
	cd ../..
done
