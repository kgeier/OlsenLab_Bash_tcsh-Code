#!/bin/bash
for i  in {1001..1014}; do
        cd ${i}/behavior
	cp -r ../../designfolder/${i}/design.csv .
	cd ../..
done
