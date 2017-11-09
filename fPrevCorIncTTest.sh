#!/bin/tcsh
foreach cond (prevCor)

3dttest++ -prefix /data6/olsen_lab/mayo/FuncConTTest/zFC_ttest28_${cond}_alltrials_CorInc \
-setA ${cond} \
1001 '/data6/olsen_lab/mayo/1001/GLM_BASIC/glm_basic/z_fc_L_AT_1001_'${cond}'+tlrc.BRIK' \
1002 '/data6/olsen_lab/mayo/1002/GLM_BASIC/glm_basic/z_fc_L_AT_1002_'${cond}'+tlrc.BRIK' 
1003 '/data6/olsen_lab/mayo/1003/GLM_BASIC/glm_basic/z_fc_L_AT_1003_'${cond}'+tlrc.BRIK' \
1004 '/data6/olsen_lab/mayo/1004/GLM_BASIC/glm_basic/z_fc_L_AT_1004_'${cond}'+tlrc.BRIK' \
1005 '/data6/olsen_lab/mayo/1005/GLM_BASIC/glm_basic/z_fc_L_AT_1005_'${cond}'+tlrc.BRIK' \
#1006 '/data6/olsen_lab/mayo/1006/GLM_BASIC/glm_basic/z_fc_L_AT_1006_'${cond}'+tlrc.BRIK' \
#1007 '/data6/olsen_lab/mayo/1007/GLM_BASIC/glm_basic/z_fc_L_AT_1007_'${cond}'+tlrc.BRIK' \
1008 '/data6/olsen_lab/mayo/1008/GLM_BASIC/glm_basic/z_fc_L_AT_1008_'${cond}'+tlrc.BRIK' \
1009 '/data6/olsen_lab/mayo/1009/GLM_BASIC/glm_basic/z_fc_L_AT_1009_'${cond}'+tlrc.BRIK' \
1010 '/data6/olsen_lab/mayo/1010/GLM_BASIC/glm_basic/z_fc_L_AT_1010_'${cond}'+tlrc.BRI' \
1011 '/data6/olsen_lab/mayo/1011/GLM_BASIC/glm_basic/z_fc_L_AT_1011_'${cond}'+tlrc.BRIK' \
#1012 '/data6/olsen_lab/mayo/1012/GLM_BASIC/glm_basic/z_fc_L_AT_1012_'${cond}'+tlrc.BRIK' \
1013 '/data6/olsen_lab/mayo/1013/GLM_BASIC/glm_basic/z_fc_L_AT_1013_'${cond}'+tlrc.BRIK' \
1014 '/data6/olsen_lab/mayo/1014/GLM_BASIC/glm_basic/z_fc_L_AT_1014_'${cond}'+tlrc.BRIK' \
1015 '/data6/olsen_lab/mayo/1015/GLM_BASIC/glm_basic/z_fc_L_AT_1015_'${cond}'+tlrc.BRIK' \
#1016 '/data6/olsen_lab/mayo/1016/GLM_BASIC/glm_basic/z_fc_L_AT_1016_'${cond}'+tlrc.BRIK' \
1017 '/data6/olsen_lab/mayo/1017/GLM_BASIC/glm_basic/z_fc_L_AT_1017_'${cond}'+tlrc.BRIK' \
1019 '/data6/olsen_lab/mayo/1019/GLM_BASIC/glm_basic/z_fc_L_AT_1019_'${cond}'+tlrc.BRIK' \
1020 '/data6/olsen_lab/mayo/1020/GLM_BASIC/glm_basic/z_fc_L_AT_1020_'${cond}'+tlrc.BRIK' \
1021 '/data6/olsen_lab/mayo/1021/GLM_BASIC/glm_basic/z_fc_L_AT_1021_'${cond}'+tlrc.BRIK' \
1022 '/data6/olsen_lab/mayo/1022/GLM_BASIC/glm_basic/z_fc_L_AT_1022_'${cond}'+tlrc.BRIK' \
1023 '/data6/olsen_lab/mayo/1023/GLM_BASIC/glm_basic/z_fc_L_AT_1023_'${cond}'+tlrc.BRIK' \
1024 '/data6/olsen_lab/mayo/1024/GLM_BASIC/glm_basic/z_fc_L_AT_1024_'${cond}'+tlrc.BRIK' \
1025 '/data6/olsen_lab/mayo/1025/GLM_BASIC/glm_basic/z_fc_L_AT_1025_'${cond}'+tlrc.BRIK' \
1026 '/data6/olsen_lab/mayo/1026/GLM_BASIC/glm_basic/z_fc_L_AT_1026_'${cond}'+tlrc.BRIK' \
#1027 '/data6/olsen_lab/mayo/1027/GLM_BASIC/glm_basic/z_fc_L_AT_1027_'${cond}'+tlrc.BRIK' \
1028 '/data6/olsen_lab/mayo/1028/GLM_BASIC/glm_basic/z_fc_L_AT_1028_'${cond}'+tlrc.BRIK' \
-setB ${cond} \
1001 '/data6/olsen_lab/mayo/1001/GLM_BASIC/glm_basic/z_fc_L_AT_1001_'prevIncor'+tlrc.BRIK' \
1002 '/data6/olsen_lab/mayo/1002/GLM_BASIC/glm_basic/z_fc_L_AT_1002_'prevIncor'+tlrc.BRIK'
1003 '/data6/olsen_lab/mayo/1003/GLM_BASIC/glm_basic/z_fc_L_AT_1003_'prevIncor'+tlrc.BRIK' \
1004 '/data6/olsen_lab/mayo/1004/GLM_BASIC/glm_basic/z_fc_L_AT_1004_'prevIncor'+tlrc.BRIK' \
1005 '/data6/olsen_lab/mayo/1005/GLM_BASIC/glm_basic/z_fc_L_AT_1005_'prevIncor'+tlrc.BRIK' \
#1006 '/data6/olsen_lab/mayo/1006/GLM_BASIC/glm_basic/z_fc_L_AT_1006_'prevIncor'+tlrc.BRIK' \
#1007 '/data6/olsen_lab/mayo/1007/GLM_BASIC/glm_basic/z_fc_L_AT_1007_'prevIncor'+tlrc.BRIK' \
1008 '/data6/olsen_lab/mayo/1008/GLM_BASIC/glm_basic/z_fc_L_AT_1008_'prevIncor'+tlrc.BRIK' \
1009 '/data6/olsen_lab/mayo/1009/GLM_BASIC/glm_basic/z_fc_L_AT_1009_'prevIncor'+tlrc.BRIK' \
1010 '/data6/olsen_lab/mayo/1010/GLM_BASIC/glm_basic/z_fc_L_AT_1010_'prevIncor'+tlrc.BRI' \
1011 '/data6/olsen_lab/mayo/1011/GLM_BASIC/glm_basic/z_fc_L_AT_1011_'prevIncor'+tlrc.BRIK' \
#1012 '/data6/olsen_lab/mayo/1012/GLM_BASIC/glm_basic/z_fc_L_AT_1012_'prevIncor'+tlrc.BRIK' \
1013 '/data6/olsen_lab/mayo/1013/GLM_BASIC/glm_basic/z_fc_L_AT_1013_'prevIncor'+tlrc.BRIK' \
1014 '/data6/olsen_lab/mayo/1014/GLM_BASIC/glm_basic/z_fc_L_AT_1014_'prevIncor'+tlrc.BRIK' \
1015 '/data6/olsen_lab/mayo/1015/GLM_BASIC/glm_basic/z_fc_L_AT_1015_'prevIncor'+tlrc.BRIK' \
#1016 '/data6/olsen_lab/mayo/1016/GLM_BASIC/glm_basic/z_fc_L_AT_1016_'prevIncor'+tlrc.BRIK' \
1017 '/data6/olsen_lab/mayo/1017/GLM_BASIC/glm_basic/z_fc_L_AT_1017_'prevIncor'+tlrc.BRIK' \
1019 '/data6/olsen_lab/mayo/1019/GLM_BASIC/glm_basic/z_fc_L_AT_1019_'prevIncor'+tlrc.BRIK' \
1020 '/data6/olsen_lab/mayo/1020/GLM_BASIC/glm_basic/z_fc_L_AT_1020_'prevIncor'+tlrc.BRIK' \
1021 '/data6/olsen_lab/mayo/1021/GLM_BASIC/glm_basic/z_fc_L_AT_1021_'prevIncor'+tlrc.BRIK' \
1022 '/data6/olsen_lab/mayo/1022/GLM_BASIC/glm_basic/z_fc_L_AT_1022_'prevIncor'+tlrc.BRIK' \
1023 '/data6/olsen_lab/mayo/1023/GLM_BASIC/glm_basic/z_fc_L_AT_1023_'prevIncor'+tlrc.BRIK' \
1024 '/data6/olsen_lab/mayo/1024/GLM_BASIC/glm_basic/z_fc_L_AT_1024_'prevIncor'+tlrc.BRIK' \
1025 '/data6/olsen_lab/mayo/1025/GLM_BASIC/glm_basic/z_fc_L_AT_1025_'prevIncor'+tlrc.BRIK' \
1026 '/data6/olsen_lab/mayo/1026/GLM_BASIC/glm_basic/z_fc_L_AT_1026_'prevIncor'+tlrc.BRIK' \
#1027 '/data6/olsen_lab/mayo/1027/GLM_BASIC/glm_basic/z_fc_L_AT_1027_'prevIncor'+tlrc.BRIK' \
1028 '/data6/olsen_lab/mayo/1028/GLM_BASIC/glm_basic/z_fc_L_AT_1028_'prevIncor'+tlrc.BRIK' \
-covariates covariate_accuracy.txt 
end
