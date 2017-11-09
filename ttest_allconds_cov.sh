#!/bin/tcsh
foreach cond (study_main study_correct_incorrect \
test_cue_main test_cue_correct_incorrect \
test_delay_main test_delay_correct_incorrect \
test_probe_main test_probe_correct_incorrect )

3dttest++ -prefix /data6/olsen_lab/mayo/group_results_n13/s5_ttest13_${cond}_alltrials_acc_cov \
-covariates acc_cov.1D -DAFNI_DEBUG_TABLE=YES \
-setA ${cond} \
1001 '/data6/olsen_lab/mayo/1001/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1002 '/data6/olsen_lab/mayo/1002/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1003 '/data6/olsen_lab/mayo/1003/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1004 '/data6/olsen_lab/mayo/1004/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1005 '/data6/olsen_lab/mayo/1005/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1006 '/data6/olsen_lab/mayo/1006/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1007 '/data6/olsen_lab/mayo/1007/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1008 '/data6/olsen_lab/mayo/1008/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1009 '/data6/olsen_lab/mayo/1009/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1010 '/data6/olsen_lab/mayo/1010/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1011 '/data6/olsen_lab/mayo/1011/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1012 '/data6/olsen_lab/mayo/1012/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \
1014 '/data6/olsen_lab/mayo/1014/GLM_BASIC/glm_basic/s5_nw_'${cond}'_GLT#0_Tstat.nii' \

end
