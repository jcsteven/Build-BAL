#!/bin/bash
# -------------------------------------------------------
# Automatic preparation script for rtk_openwrt
# JC Yu,     Novenber 26,2015
# -------------------------------------------------------
# IMPORTANT:
#   When use: './<this script file>  '
# -------------------------------------------------------
TODAY=`date +"%Y-%m%d-%H%M"`
source build_comm-BAL.sh

[ -d $BLOG_DIR_WK ] || mkdir $BLOG_DIR_WK
s_time=$(date +%s)
BOARD=asgvolt64
PROJECT_NAME=${BOARD}-${BAL_NAME}
echo "..............................................................................." | tee -a $Record_File
echo "Start: -Build-${PROJECT_NAME} ${TODAY}." | tee -a $Record_File

TO_BUILD_BAL="y"
if [[ "${TO_BUILD_BAL}" == "y" ]]; then
	echo "1. Build BAL SDK"
    BAL_DIR=${BAL_ROOT}/${PROJECT_NAME}
	if [ ! -d ${BAL_DIR} ]; then
	   echo $LINENO "missing ${BAL_DIR}" |  tee -a $Record_File
	   exit -1
	fi
	make -C ${BAL_DIR} BOARD=${BOARD} ONL_DIR=${ONL_DIR} OPEN_SOURCE=y SW_UTIL_SHELL=y
	make -C ${BAL_DIR} BOARD=${BOARD} release_board
fi

e_time=$(date +%s)
elap_s=$((e_time-s_time))
ss=$((elap_s%60))
mm=$(((elap_s/60)%60))
hh=$((elap_s/3600))
echo "==============================================================================" | tee -a  $Record_File
echo "End: -Build-${PROJECT_NAME} ${TODAY}." | tee -a $Record_File
echo "Build total time: $hh:$mm:$ss" | tee -a  $Record_File
echo "==============================================================================" | tee -a  $Record_File






