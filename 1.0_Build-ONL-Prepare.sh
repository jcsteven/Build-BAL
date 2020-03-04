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
me_file=`basename "$0"`



[ -d $BLOG_DIR_WK ] || mkdir $BLOG_DIR_WK
s_time=$(date +%s)
echo "==============================================================================" |  tee -a $Record_File
echo ".............................................................................." |  tee -a $Record_File
echo "Start: ${me_file}:${TODAY}." | tee -a $Record_File

#--- Check out the specified ONL code from git Hub
TO_UPDATE_ONL="y"
if [[ "${TO_UPDATE_ONL}" == "y" ]]; then
	if [ -d ${ONL_DIR} ]; then
	   echo $LINENO "${ONL_DIR} is already in the existence!!" |  tee -a $Record_File
	   exit -1
	fi

	echo "-1.1 Prepare ONL Root:" |  tee -a $Record_File
	mkdir -p ${ONL_ROOT}
	#git clone ${ONL_GIT_NAME} -b ${ONL_GIT_B} ${ONL_DIR}
	git clone ${ONL_GIT_NAME} ${ONL_DIR}
	cd  ${ONL_DIR}
	git checkout -b ${ONL_GIT_B} ${ONL_COMMIT_ID}
	cd  ${PPWW}
fi

#--- Check out the specified ONL code from git Hub
TO_CHECH_IS_OK="y"
if [[ "${TO_CHECH_IS_OK}" == "y" ]]; then
	if [ ! -d ${ONL_DIR} ]; then
	   echo $LINENO "Still missing ${ONL_DIR}" |  tee -a $Record_File
	   exit -1
	fi
fi


e_time=$(date +%s)
elap_s=$((e_time-s_time))
ss=$((elap_s%60))
mm=$(((elap_s/60)%60))
hh=$((elap_s/3600))
echo "==============================================================================" | tee -a $Record_File
echo "End: ${me_file}:${TODAY}-Done!!" | tee -a $Record_File
echo "Build total time: $hh:$mm:$ss" | tee -a $Record_File
echo "==============================================================================" | tee -a $Record_File

