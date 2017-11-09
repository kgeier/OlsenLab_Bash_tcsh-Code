# OlsenLab_Bash_tcsh-Code
Bash code from stringing together fMRI preprocessing and analysis pipelines. Note: many calls to R scripts from Dr. Bradley Buchsbaum. If not running at the Rotman with access to the GRID, then please contact him for use of his fMRI analysis scripts. 

Last Updated November 9th, 2017
Instructions written for researchers at Olsen Lab intending to replicate my analysis or performing something similar. 
Please email me at Kirkgeier@gmail.com if you have trouble understanding the instructions or the code. 

Best of luck!

 Steps for fMRI data anlysis

1.	Download data from XNAT
Download the data into your directory on the server (e.g. Methone, Telesto, GRID)
Login to Methone (172.24.0.234) or Telesto (172.24.0.231) or GRID (172.24.6.65)

Use arcget to download 
/opt/xnat_tools/ArcGet -u rolsen -p ASKROSANNA –s OlRo_M149_BA_13745_PhysioData_20161011 -host https://rrinid.rotman-baycrest.on.ca/spred/

Replace the bold portion with label from RRINID. Make sure to read the scanning notes form to match the PID with the subject you are downloading to avoid mix-up. 
You can also use your own username instead of rolsen and own password instead of Baycrest540


We used to use the curl command but it doesn’t work after the Xnat2 upgrade: 
curl -u rolsen:ggmm54 -X GET -v -o s01M084_RyJ_Mri_9243_ALL.zip --url 'http://172.24.0.250:8080/xnat/REST/projects/s01M084_RyJ/subjects/s01M084_RyJ_Subj_9243/experiments/s01M084_RyJ_Mri_9243/scans/ALL/resources/DICOM/files?format=zip'

Change highlighted text to your specific XNAT login, study name/number, and subject ID.

This will put a zip file in your directory which contains all of the MRI and fMRI scans from that session.

 
2.	Setup directory on GRID
Under project directory (e.g. /data6/olsen_lab/mayo), set up directories for each subject.
Preferred naming system Subject 1 = 1001, Subject 2 = 1002, etc

3.	Copy data onto GRID from server (if downloaded onto Methone or Telesto, which may be better to not store your data on the GRID, but just process results there)

Copy data either using an FTP client (e.g. Firezilla) or scp from a server like Methone
(e.g. scp rolsen@172.24.0.234:/rri_disks/fortuna/ryan_lab/rosanna/Faces_fMRI/subject01/raw/*zip 1001)

4.	Make onset file

Make onset file in Excel and save as a tab-delimited text file
Example: 
 

Include a column called run which will correspond to the run/block number and onset which will correspond to the stimulus onset in seconds.  The next columns will refer to any other possible ways to split up the data (by condition, behavioral response, etc).  Also include a column for bad trials if you need to exclude any trials.

5.	Copy onset file onto GRID from your desktop computer
Copy data using an FTP client (e.g. Firezilla)
Within the subject’s directory, create a directory called behavior
Copy the onset file into this directory and rename it design.txt

6.	Unzip MRI data. 
Use vim to edit Unzipping.sh to the subjects you want to unzip. 
Then use 
Bash Unzipping.sh to run command and unzip files.

7.	Start 1st preprocessing step by running prep_fMRI.R
Within the main subject directory (e.g. 1003) type the command:
/home/bradley/bin/prep_fMRI.R <name of unzipped data directory>
(I believe it’s bradley. i.e /home/Bradley/bin/prep_fmri.R)

e.g. /home/bradley/bin/prep_fMRI.R s01M08_RyJ_Mri_9483ls 

This command does the following preprocessing steps:
1.	reconstructs the MRI and fMRI data from dicom format into NIFTII format using DIMON
2.	performs realignment (motion correction) and slice time correction using 3dvolreg
3.	reorients the MRI into RPI orientation
4.	performs skull stripping of the MPRAGE
5.	aligns the structural (MPRAGE) to the mean EPI

(in /data6/olsenlab/mayo there is a script called run_qexec_prepfmri.sh. Edit with vim to change the subjects you wish to run on, and run with bash). 

**Check directories to make sure this step succeeded***

You should have:
A directory called “anatomy” with a BRIK file called: mpragealepi+orig
A directory called “epi” with files called: rscan01.nii rscan02.nii …(number should match number of runs)

8.	Start 2nd preprocessing step using warp_to_mni.R
This command normalized the MRI using ANTS (may take some time to run)

cd anatomy
/home/bradley/bin/warp_to_mni.R

This command looks for mpragealepi+orig file and normalizes it to a standard template

(in /data6/olsenlab/mayo there is a script called warpToMNI.sh. Edit with vim to change the subjects you wish to run on, and run with bash). 


*Check anatomy directory to see if this step succeeded*
This produces a file called mprage_mni.nii

9.	Complete 3rd preprocessing step using do_fast.R
This command performs tissue segmentation on the mpragealepi file.
Then downsamples the tissue probability maps into the epi space

cd anatomy
/home/bradley/bin/do_fast.R

You can do this step while Step 8 (?) is still running

(in /data6/olsenlab/mayo there is a script called dofast.sh. Edit with vim to change the subjects you wish to run on, and run with bash). 


*Check anatomy directory to see if this step succeeded*
This produces a set of files called: mprage_alepi_seg.nii.gz, mprage_alepi_prob_*, mprage, etc


10.	Complete 4th and final preprocessing step using do_estimate_noise.R
This command looks for noise components in your data (e.g. physiological noise)

cd epi
/home/bradley/bin/do_estimate_noise.R rscan*nii

Update: You have to run this step after step 9 (but can do before step 8)! 

*Check epi directory to see if this step succeeded*
This produces a set of files called “nuisacnce_rscan01.txt”  …etc

(in /data6/olsenlab/mayo there is a script called estimateNoise.sh. Edit with vim to change the subjects you wish to run on, and run with bash). 


Pre-processing is now finished. Get ready to run your models!!!

 

OVERVIEW of GLMs

Each GLM is used to model the haemodynamic response by the different condition type, to produce ‘fits’ or ‘beta coefficients’ that mark how well each voxel’s response is modeled by the condition (ex. Study stimuli vs. baseline, or correct vs. incorrect trials).
There are three types of General Linear Model that can be used to process this fMRI data.
-The first is GLM BASIC. The basic GLM has 1 Basis function per event, modulated by the duration of events. These are averaged across all trials.
-The second is GLM TENT. This uses a series of short Basis functions to estimate the entire event period. This can be used to produce a time course of the BOLD response over time of the experiment. Ex. Cue, Delay, Test phase. 
-The third is similar to GLM BASIC but instead, outputs the Betas for each trial so we can see if different regions are connected (active with each other (or inverse) in more trials)

11.	
Mkdir GLM_BASIC inside subject folder (cd 10##)
for i in {10XX..10XX}; do  cd ${i}; mkdir GLM_BASIC;  cd ..; done


Copy (or make fresh). See below for screen shots depicting what they look like 
config.R 	(see screenshot below to see what information it contains. Make sure the BASE_PATH is correct)
runs.txt 	(file with run numbers in order. Usually 1 2 3 4 5 6)
scans.txt 	(file with scan numbers in order with ../epi/rscan0*.nii to reference each scan) 
nuisance.txt	(file nearly same as scans.txt but references nuisance_rscan0*.txt) 

TBD – Still trying to determine if need to have a nImages.txt file with the number of images for each scan (if not all 346 like the screenshot below says). 

Make fresh
SID with echo ?0** > SID



 
Note, this subject, 2001, had a crash in scan 4, 5, and 6 which is why the order may seem abnormal. Only 5 blocks were run in total. 
 


runs.txt should match the scan block column from the design file. 
scans.txt should be the rscan of whichever are functioning in order. And in order to tell which ones were proper scans we do 3dinfo on the rscan file and look for Number of time steps = 346 
Nuisance.txt will be the same as scans.txt

Run from GLM_BASIC directory

/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G ../../glm_basic_mayo_rko.R 

To ensure this ran and worked, look for file named statout+orig 

12.	To see if 
13.	Before you can run tstats, a few steps to process the data are required. First, we extract the “buckets” from the data. 
for i in {1026..1028};
do cd ${i};
cd GLM_BASIC/glm_basic_dpm;
 /home/bradley/bin/extractBuckets.R -i statout+orig -g 'GLT';
ls *GLT*Tstat* > Tstats.txt;
cd ../../..;
done
 These commands extract the relevant buckets that we need for our 2nd level analysis and write out the nifti files
14.	Next, we will need to warp them like this:
/home/bradley/bin/apply_warp.R Tstats.txt

for i in {1026..1028};
do cd ${i};
cd GLM_BASIC/glm_basic_dpm;
/home/bradley/bin/apply_warp.R Tstats.txt;
cd ../../..;
done

15.	Now, cd into the epi directory and warp the global mask, which we need in MNI space too.
/home/bradley/bin/apply_warp.R -f global_mask.nii

for i in {1026..1028};
do cd ${i};
cd epi;
/home/bradley/bin/apply_warp.R -f global_mask.nii; 
cd ../..;
done

16.	Now we smooth the warped files. 

for i in {1026..1028};
do cd ${i};
cd GLM_BASIC/glm_basic_dpm;
/home/bradley/bin/blur.R -f 6 -m ../../epi/nw_global_mask.nii nw*
cd ../../..;
done

NOTE: change the 6 to a different number if wishing to change the size of the smoothing kernel. 

17.	Once each SID/GLM_BASIC folder has its own glm_basic folder can run ttests to compare conditions and show BOLD differences on AFNI etc.  To do this, edit mayo/group_results_n??/ the covariate analyses). While editing copy the lines from above and change BOTH occasions of SID to the new subjects you want to run/include. Ex. 
1025 '/data6/olsen_lab/mayo/1025/GLM_BASIC/glm_basic/s4_nw_'${cond}'_GLT#0_Tstat.nii' \ 
18.	group_results_n??/ttest_allconds_cov.sh  (do both .sh and  _cov.sh.  _cov is covariate… To run the covariate analysis, must first copy and edit the covariate_accuracy.txt file ) 
Run ttest_allconds_cov.sh with ./ “./ttest_allconds_cov.sh”


GLM_TENT (for making time series graphs)
1.	Make a GLM_TENT directory with same stuff as GLM_BASIC. 
for i in {1019..1028}; do cd ${i}; mkdir GLM_TENT; cd ..; done

2.	Copy from the GLM_BASIC folder the necessary configuration files and adapt if necessary.
for i in {1019..1028}; do cd ${i}; cd GLM_BASIC; cp scans.txt ../GLM_TENT; cp runs.txt ../GLM_TENT/; cp nuisance.txt ../GLM_TENT/; cp config.R ../GLM_TENT/; cp SID ../GLM_TENT/; cd ../..; done 

3.	Run the glm_tent.R script Brad made. Again don’t forget to skip subjects that are excluded (in this case subj 18). 
for i in {1001..1017};
do cd ${i};
cd GLM_TENT;
/home/bradley/bin/qexec2.R -q big ../../glm_tent.R ;
cd ../..;
done

4.	To do this again with disproportionate viewing rather than overt responses. 
Make a copy of glm_tent.R called glm_tent_dpm.R 
To change the directory it’s saved in, change afnimod <- runmodel(fmrimod, "glm_tent_dpm") 
To change what the contrast is from Correct vs Incorrect to Disproportionate viewing, change “AccWithOther” to the column name for dpm in the design file which is “dpm_dpnm”
Then run for 1-17 and 19-28:
for i in {1019..1028};
do cd ${i};
cd GLM_TENT;
/home/bradley/bin/qexec2.R -q big ../../glm_tent_dpm.R ;
cd ../..;
done

It may take a long while. 
5.	Once done, for both overt responses and dpm, edit and run the following scripts to convert the iresp afni files into nifti files and convert them with apply_warp4d.R to use ants to warp files into MNI space. 
From Mayo directory:
 Bash Convert_af2nif_warp2mni_tent_dpm 
And
Bash Convert_af2nif_warp2mni_tent_subAc

Now we need to get the contrast/beta/value for each second of the 21 second task. (This is to map out how activity is changing over time through the task). 

To do this must first get the ROIs ready. Hannula used Right hipp, right parahip, and left perirhinal. For now just going to add instructions for Hippocampus (right side, but we did both sides) 

i)	Need to combine the anterior and posterior hipp ROIs from the mayo/StructuralROIsMAYO folder. 
3dcalc -a mni_r_ant_hipp_mask+tlrc.BRIK -b mni_r_post_hipp_mask+tlrc.BRIK -expr a+b -prefix mni_r_all_hipp_mask+tlrc.BRIK
This sets anterior to a, posterior to b, and then adds a and b and puts the output as *all*.
ii)	We now need to downsample so they’re in the same dimensions as the fMRI iresp files in glm_tent folder. 
3dresample -master ../1001/GLM_TENT/glm_tent/study_scene_prev\:correct_iresp+orig.BRIK  -prefix mni_r_all_hipp_mask_downsampled -inset mni_r_all_hipp_mask+tlrc.BRIK -rmode NN
iii)	Check this worked with 3dinfo mni_r_all_hipp_mask_downsampled+orig.BRIK (should be 2x2x2mm^3)
iv)	Now can use the mystical 3dmaskave (3d mask average) function. RUN this from the glm_tent directory (1001/GLM_TENT/glm_tent/)
3dmaskave -mask ../../../StructuralROIsMAYO/mni_r_all_hipp_mask_downsampled+orig.BRIK study_scene_prev\:correct_iresp+orig.BRIK > timeseries_r_hipp_1001 
Takes all the voxels in the ROI and finds the average for each time point (second). 
(NOTE: once ROIs are made can just run “bash TimeSeriesExtraction.sh” which has this scripted for all subjects and ROIs and effects (ex. DPM or DPNM). Note right now ROIs other than r_hipp and l_hipp are commented out as I haven’t made them yet (19/9/17)). (Now alternative scripts for different ROI types, TImeseriesextraction2.sh and TTdaemon_timeseriesextraction.sh). 

Okay now you’ve done this, go into the mayo/timeSeries_output directory Download to google drive with Shell Secure File Transfer. Save to drive/olsenlab_cloud/all Experiments/MAYO/R studio analysis

But don’t forget to exclude subjects that don’t have proper eye-tracking… Kirk change this in the script to exclude those subjects.

Open timeseriesComparison.R, change target directory and run to generate comparison graphs for DPM DPNM. 

OKAY-now going to add directions for how we got the ROIs for the other regions.
	-Thalamic regions were made like directions below from tlrc. But soon (10/25/17) there will be Morel Jakab atlas that’s better. 
	-PHC, ERC, and PRC were made in a different way. They were from /scratch/buchsbaum_lab/rolsen/HippSubfielsTemplates/Youngers/HC_NC_Controls/AVG... 
These were made by manual segmentation of 20 dif. Subjects. I copied them to a working folder to do the following steps:
1.	Convert them to be readable by afni (need to tell afni it’s in tlrc).
3dcopy NAMEofMASK.nii.gz NAMEofMASK+orig  (this turns it into a file readable by afni)
3drefit  -view tlrc -space MNI NAMEofMASK+orig (this changes it to tlrc)
2.	At this point check these in afni over the mni_template to make sure they look good. You’ll notice though they aren’t one colour. This is because it’s an average. To Binarize them move to step 3. 
3.	Idea is subtract 0.5 from the value, then all values above 0 get rounded to 1. (Rounds to nearest 1)
3dcalc -a NAMEofMASK+tlrc -expr 'step(a-0.5)' -prefix binarNEWmaskNAME

Of course once all ROIs are made downsample to same resolution as EPI data 
(3dresample -master ../../StructuralROIsMAYO/7mmDownsampled_rightFusi+tlrc.BRIK -prefix 6mm_DLPFC_downsampled -input 6mmDLPFC+tlrc.BRIK)
And then use 3drefit to change all to tlrc. 


How to make an ROI!
-To check what regions are available (and what they’re named) use 
wherami –show_atlas_code | less

-once you know the name of the region and atlas you want to use:
whereami -mask_atlas_region TT_Daemon(NameOfAtlas):left(SideOfBrain):hippocampus(NameOfRegion) -prefix Lhip(WhatYouWantToLabelThatROIasApartFromTheOthers). 

whereami -mask_atlas_region TT_Daemon:left:hippocampus -prefix L_hip 

Rest can be found in StructuralROIsMAYO/TT_Daemon_ROIs/makeROIsfromTTlist.sh

Need to combine the two brodmann areas that form the perirhinal cortex. Use a function like the following for both R_ and L_:

3dcalc -a R_PerirhinalA+tlrc.BRIK -b R_PerirhinalB+tlrc.BRIK -expr a+b -prefix R_Perirhinal+tlrc.BRIK

Can use a function like the following to downsample to 2mm (to match epi). 
3dresample –dxyz 2.0 2.0 2.0 -prefix downsampled_L_hipp -input L_hip+tlrc.BRIK

Rough notes on how to transform from daemon to mni
-Overall plan is change TT_152(tlrc) from afni folder (bc hopefully exact same as TTDaemon) folder to MNI_152 from /opt/fsl/data/standard/ using 3dallineate. This will create a transformation matrix we can apply to TT_Daemon atlas. Then when we make ROIs from new atlas they’ll be in MNI space
-To do step 1, copy using 3dcopy the two templates to your working directory. 3dcopy NAME.nii.gz files again to NAME+orig to make them afni files. 
-Then 
align_epi_anat.py -anat TT_avg152T1+tlrc.BRIK.gz -epi MNI152_T1_1mm_brain+orig -epi_base 1 -cost lpa
-Check results visually
-then use on all different rois
3dAllineate -1Dmatrix_apply TT_avg152T1_al_mat.aff12.1D -prefix trans2MNI_roi_L_precun -source L_precuneus+tlrc.BRIK
-You then downsample these with 3dresample –master. Different for each side of the brain. 

Functional Connectivity Analysis
-need to run glm_betas

$FREESURFER_HOME/bin/mri_convert /PATH/TO/YOUR-IMAGE.nii
$SUBJECTS_DIR/SUBJECT-NAME/mri/orig/001.mgz


Begin by making ROIs. This can either be structural or functional. Structural are made with freesurfer and are based on anatomy. Functional is usually based off of another study or own results and are made from coordinates 
1.	Structural ROIs: The appropriate directory structure needs to be made for FreeSurfer to be able to read in the anatomical files to create ROI files. This is ${SID}/mri/orig/001.mgz 
2.	for i in {1019..1028}; do cd  ${i}; mkdir mri; mkdir mri/orig; cd ..;  done
3.	for i in {1019..1028}; do cd  ${i}; cp ../../${i}/anatomy/mprage.nii mri/orig ; cd ..;  done
4.	To convert from nifti to freesurfer format (mgz) use mri_convert. 
for i in {1002..1017}; do mri_convert ${i}/mri/orig/mprage.nii ${i}/mri/orig/001.mgz; done  
5.	Run the following command to run freesurfer on all your subjects on the queue. 
for i in {1019..1028}; do qexec2.R -q big recon-all -all -s ${i} -sd . ; done  


Functional ROIs: Find the coordinates from another paper. For mAyo it’s Hannula 2009, left DLPFC region or left VLPFC during 3-face test display.  The coordinates are x = -48, y = 27, z = 30; t(13) = 5.36) and VLPFC: local maxima at x = -48, y = 42, z = 0; t(13) = 8.38; 
8mm / play around. 

1.	To do this, must first make a template brain 
3dmerge -prefix template_n28.nii 10??/anatomy/mprage_mni.nii
2.	You must also ensure it is in the same space. 3dinfo gives template space. However it may say ORIG when it is actually in MNI space. To convert this use:
3dcopy template_n28.nii template_n28+orig.BRIK
This transforms the template into a BRIK file. 
Then use:
3drefit -view tlrc -space MNI template_n28+orig.BRIK
This will change the file to include +tlrc and lets afni know it’s in MNI space.  
3.	Next we use 3dcalc to make an ROI at your select coordinates. 
3dcalc -a template_n28+tlrc.BRIK -expr 'step(64-(x+48)*(x+48)-(y-27)*(y-27)-(z-30)*(z-30))' -prefix 8mmDLPFC


4.	And downsample it to the same res as your fMRI with 3dresample
3dresample -master ../../StructuralROIsMAYO/7mmDownsampled_rightFusi+tlrc.BRIK -prefix 6mm_DLPFC_downsampled -input 6mmDLPFC+tlrc.BRIK
5.	hmmm


Functional connectivity continued:
Need to run __.sh from mayo folder which will use 3dDevonvolve
-Stim_timesIM 
-KIRK ADD THIS PART!

Then, adapt BetaExtraction.sh to include the ROIs you want to have as your seed and have the input set to where your stats+orig. files were output from 3dDeconvolve. Also set output. This should give different Beta weight for each voxel of the ROI in a long column. 
-
-Essentially, you will want to run from the mayo directory scripts a1.Description -> a9.Description. 
It may be possible to run these all as 1 script (shown below). If not they are pretty much the same as the original shown below (after a1) with the other lines commented out (but the commented out lines may not have been updated.

Run with “bash a#.NAME.sh” 

a1.movetoglmbasic.sh
#! /bin/bash/
for i in {1001..1006} {1008..1011} {1013..1015} {1017..1026} {1026..1028}
do
cd StimTimeFiles
3dcopy ${i}_bc_stats4FC+orig ../${i}/GLM_BASIC/glm_basic/ 
cd ..
done

d2-10 (broken into different scripts but maybe combineable). 

Make sure StimTimeFiles/OldDeconvolveOutput/Downs_mni_l_AT3mm+tlrc. ROI is downsampled to 3mm
3dresample -master EPI_1017+tlrc. -prefix Downs_mni_r_MD3mm+tlrc. -inset Downs2_mni_r_MD+tlrc.

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

ls *${cond}*Coef* > Coef_subBuck_${i}_${cond}.txt

/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G /home/bradley/bin/apply_warp.R subBuck_${i}_${cond}.txt

3dTcat -prefix chumBucket_${i}_${cond} nw_${cond}*Coef.nii 

#rm ideal_${i}_${cond} _${ROI}_fc.1D

3dmaskave -mask ../../../StimTimeFiles/OldDeconvolveOutput/Downs_mni_${ROI}3mm+tlrc. chumBucket_${i}_${cond}+orig.BRIK >> ideal_${i}_${cond} _${ROI}_fc.1D 

find ideal_${i}_${cond}_fc.1D -type f -exec sed -i -r 's/.{12}$//' {} \;

3drefit -TR_time 1.77s chumBucket_${i}_${cond}+orig. 
3drefit -view tlrc -space MNI chumBucket_${i}_${cond}+orig.

/home/bradley/bin/qexec2.R -q bigmem_16.q --mem=16G 3dfim+ -input chumBucket_${i}_${cond}+tlrc. -polort 1 -ideal_file ideal_${i}_${cond} _${ROI}_fc.1D -out Correlation -bucket fc_${ROI}_${i}_${cond}

3dcalc -a fc_${ROI}_${i}_${cond}+tlrc -expr 'log((1+a)/(1-a))/2' -prefix z_fc_${ROI}_${i}_${cond}+tlrc

cd ../../..
done
done
done

Then perform ttest by going in to the FuncConTTest directory and running bttestCov.sh (covariate) and cttest.sh. This will output the ttest results into your current directory. Edit the scripts to ensure the subjects, output, and input files are as expected. 

 
Notes on anatomical spaces
	Talaraich (tlrc), Montreal Neurological Institute (MNI)

Talaraich template was made from post-mortem brain with coordinates translated to what is seen in MRI. So, more precise, but we don’t have an MRI template and it’s off of only one person’s brain so doesn’t really represent the population. 

MNI152 is the current standard. Used 152 healthy adults (239M, 66F, 23.4+/- 4.1)

The problem introduced by the MNI standard brains is that the MNI linear transform has not matched the brains completely to the Talairach brain. As a result the MNI brains are slightly larger (in particular higher, deeper and longer) than the Talairach brain. The differences are larger as you get further from the middle of the brain, towards the outside, and are at maximum in the order of 10mm. In particular, MNI brain is ~5mm taller (from the AC to the top of the brain) and ~5mm longer. The temporal lobes go about 10mm deeper in MNI (see e.g. MNI coordinate X = 32 Y = -4 Z = -50; the lowest slice in the Talairach atlas is at -40). Another example of the mismatch is that at -8 -76 -8 you are firmly in the occipital cortex in the MNI brain, whereas the same coordinates in the Talairach atlas put you in CSF.  


Lancaster transform is an exampleof a nonlinear transform that corrects for results published in tlrc vs mni not being comparable

MNI(a) is what Brad was calling MNI Anatomical.


 
Vizualizing in AFNI

1.	Cd into group_results_n24 (or whatever name is of your group results which should be made via directions not yet transcribed from RKO). 
2.	Open AFNI by typing afni. 
3.	Now, because you were in the group_results folder, when you click on ‘Overlay” it will have all the different conditions you developed earlier to look at (ex. Study main effect, dpm_dpnm). Overlay whichever one you are curious about. Click Set. 
4.	Once the overlay is up, more options will appear. 
A)	Beneath the rainbow bar, set the ** to 12 (12 colours so see hot as more active and cold as less active). 
B)	Set the Olay from #0 to #1 tstat. 
C)	Set the ** under the blue bar to 1. This adjusts the scale of t values. Set it to show the p-value you want. Ex. 0.0010. This shows only voxels with significant enough to MAYBE survive later multiple comparisons. 
At this point can make an image, movie, or montage. 
Option A- Normal Image
i)	Right click “Sav1.ppm” underneath the image of the brain you want. Change to desirable file type (ex. .tif, .jpg). Pull window up higher from bottom of screen if having issues. 
ii)	Turn off cursor. In top left of AFNI window there is a box labeled Xhairs. Change from Multi to Off. 
iii)	Find the interesting slice you want. Left click on Sav1.jpg. Enter the name you want to save it as and it will be saved to the same directory you were in when you opened AFNI. 
Option B- Montage
i)	Instead of saving the file like step iii) above, left click on Mont tab to the right of Sav1.jpg. Choose however many slices across or down as you want and choose spacing. Click “set”. 
ii)	If it looks as you desire, save it in the same way as Option A. 
Option C- Movie (I DON’T REMEMBER SORRY)

Adding atlas outlines of brain regions in AFNI- (don’t even bother it’s going to crash on you)
1.	Need to convert your template.nii and stat files to MNIA space labels so AFNI knows they are in MNI space. 
a)	3dcopy original file (ex. In group_results folder). To newly made directory (ex. Call it “MNI_space”).  Rename with “oldfilename”+orig . The “+orig” makes into AFNI file format. 
b)	Type      3drefit –view tlrc –space MNIA “filename”+orig.        This changes the Temp Space to MNIA from Orig.  
2.	Open AFNI again inside the MNI_space folder. You can now switch to Talairach view. 
3.	Right click on the brain image. You can now either choose “Where am I?” or “Atlas Colors” and you can change the colours of hippo and anter. Medial or dorsolateral thalamus. (At least in theory. In reality it crashes without warning.). 









 

How to run mprage on freesurfer6

1.	Make sure your .bashrc file (cd, ls –a, vi .bashrc) is set to 
 
2.	Mkdir freesurfer
Cd freesurfer
Mkdir SubID# (ex. 1014)
Cd 1014
Mkdir mri
Cd mri
Mkdir orig
Cd orig
Cp /path/mprage.nii . 

3.	Generate a .mgz file from the mprage because that is what Brad’s script is going to look for.

mri_convert mprage.nii 001.mgz 

4.	Return to the freesurfer directory to run the following command. 

/home/bradley/bin/qexec.R recon-all -all -sd . -subjid 2001 -hippocampal-subfields-T1

(replace bold 2001 with the subject number you’re running (or use a script to run on the ith subject)). 
5.	Use “qstat” command to see if it is running. If it fails use the “more “ command on the P_1234etc567.o12345 file. 

 
Quality Control Steps

To yoke two afni viewing windows together open afni (type afni and then choose the file you want as underlay). To open the second one click new (bottom left corner). Then when you click on a point the coordinates will be matched between images. 

1.	Perform the following steps on each subject to visually inspect your data looks like you expect. 

A)	Look at epiref to ensure the image is more clear than (crisper) than a single rscan.nii 
(This means the alignment has worked well)

Optional)
Can overlay rscans on epiref and reduced opacity with down arrow by 2nd arrow from the bottom (scroll over and it will say “color overlay opacity”). 

B)	Open the epiref and mprage_alepi yoked together and compare to see they are aligned. Check ventricles, hippocampus, edges of cortex, and corpus callosum. 

2.	Use Brad’s motion_metric script which gives you 3 variables which quantify the motion and alignment issues. 
Run the following commands to run his script on all subjects. 
# Go into directory with all the subjects sub-directories inside (ex 1001, 1002…)
#change from bash to tcsh because the following script is in tcsh
	Tcsh    
# go through for each subject (s) from 1001 to end. If doing subjects with numbers in 2000s change as appropriate. 
	Foreach s(1???)
# choose epi directory of each subject
	Cd ${s}/epi
#run brad’s script
	/home/bradley/bin/motion_metric.R
#Return to original directory for code to loop through next subject
	Cd ../..
	end

(in /data6/olsenlab/mayo there is a script called motion_metric.sh. Edit with vim to change the subjects you wish to run on, and run with bash). 


The file generated will be named motion_metric.txt and will be found in the epi folder of each subject.
Use:
more 1???/epi/motion_metric.txt 



This will open up all of the motion metrics. 
The first value is the mean movement, the second is the max movement, and the third is the square of the mean difference (currently I do not know what this means). If the values are too high flag the subject to look for certain trials/blocks that have too much movement that may require removal etc. 




arr[0]=l_AT
arr[1]=r_AT
arr[2]=l_MD
arr[3]=r_MD



arr[1]=l_all_hipp_
arr[2]=l_ant_hipp
arr[3]=l_AT
arr[5]=l_erc
arr[6]=l_fusi
arr[7]=l_MD
arr[9]=l_phc
arr[10]=l_post_hipp
arr[11]=l_prc
arr[14]=r_all_hipp_
arr[15]=r_ant_hipp
arr[16]=r_AT
arr[18]=r_erc
arr[19]=r_fusi
arr[20]=r_MD
arr[22]=r_phc
arr[23]=r_post_hipp
arr[24]=r_prc
