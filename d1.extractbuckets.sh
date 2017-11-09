#! /bin/bash/
arr[0]=StudCor
arr[1]=StudIncor
arr[2]=Stud_nottested
arr[3]=delayCor
arr[4]=delayIncor
arr[5]=faceCor
arr[6]=faceIncor
arr[7]=prevCor
arr[8]=prevIncor

array[0]=l_AT
array[1]=l_MD
array[2]=l_hipp
array[3]=r_MD
array[4]=r_AT
 
for i in {1001..1006} {1008..1011} {1013..1015} {1017..1017} {1019..1026}  {1028..1028}
do
for cond in "${arr[@]}" 
do 
for ROI in "${array[@]}"
do

cd ${i}/GLM_BASIC/glm_basic/ 

/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G  /home/bradley/bin/extractBuckets.R -i ${i}_bc_stats4FC+orig.BRIK -g "${cond}"
#ls *${cond}*Coef* > Coef_subBuck_${i}_${cond}.txt
#/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G /home/bradley/bin/apply_warp.R Coef_subBuck_${i}_${cond}.txt
#3dTcat -prefix chumBucket_${i}_${cond} nw_${cond}*Coef.nii 
#rm ideal_${i}_${cond}_fc.1D
#3dmaskave -mask ../../../StimTimeFiles/OldDeconvolveOutput/Downs_mni_${ROI}3mm+tlrc. chumBucket_${i}_${cond}+orig.BRIK >> ideal_${i}_${cond}_${ROI}_fc.1D 
#find ideal_${i}_${cond}_${ROI}_fc.1D -type f -exec sed -i -r 's/.{12}$//' {} \;
#3drefit -TR_time 1.77s chumBucket_${i}_${cond}+orig. 
#3drefit -view tlrc -space MNI chumBucket_${i}_${cond}+orig.
#/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G 3dfim+ -input chumBucket_${i}_${cond}+tlrc. -polort 1 -ideal_file ideal_${i}_${cond}_${ROI}_fc.1D -out Correlation -bucket fc_${ROI}_${i}_${cond}
#3dcalc -a fc_L_AT_${i}_${cond}+tlrc -expr 'log((1+a)/(1-a))/2' -prefix z_fc_${ROI}_${i}_${cond}+tlrc

cd ../../..
done
done
done

