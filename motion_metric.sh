#!/bin/bash
for i  in {1025..1025}; do
        cd ${i}
        cd epi
        /home/bradley/bin/motion_metric.R
        cd ../..
done

