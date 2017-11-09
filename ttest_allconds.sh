#!/bin/tcsh
foreach cond (study_main test_cue_main \
test_delay_main test_probe_main \
test_cue_dpm_dpnm test_cue_dpm_ndpv \
test_delay_dpm_dpnm test_delay_dpm_ndpv \
test_probe_dpm_dpnm test_probe_dpm_ndpv )

3dttest++ -prefix /data6/olsen_lab/mayo/group_results_dpm_n21/s6_ttest21_${cond}_alltrials \
-setA ${cond} \
1001 '/data6/olsen_lab/mayo/1001/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1002 '/data6/olsen_lab/mayo/1002/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1004 '/data6/olsen_lab/mayo/1004/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1005 '/data6/olsen_lab/mayo/1005/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1007 '/data6/olsen_lab/mayo/1007/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1008 '/data6/olsen_lab/mayo/1008/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1009 '/data6/olsen_lab/mayo/1009/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1010 '/data6/olsen_lab/mayo/1010/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1012 '/data6/olsen_lab/mayo/1012/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1013 '/data6/olsen_lab/mayo/1013/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1014 '/data6/olsen_lab/mayo/1014/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1015 '/data6/olsen_lab/mayo/1015/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1016 '/data6/olsen_lab/mayo/1016/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1017 '/data6/olsen_lab/mayo/1017/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1019 '/data6/olsen_lab/mayo/1019/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1020 '/data6/olsen_lab/mayo/1020/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1021 '/data6/olsen_lab/mayo/1021/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1022 '/data6/olsen_lab/mayo/1022/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1023 '/data6/olsen_lab/mayo/1023/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1024 '/data6/olsen_lab/mayo/1024/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii' \
1025 '/data6/olsen_lab/mayo/1025/GLM_BASIC/glm_basic_dpm/s6_nw_'${cond}'_GLT#0_Tstat.nii'

end
