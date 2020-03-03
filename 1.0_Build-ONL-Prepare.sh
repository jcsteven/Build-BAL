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
echo "==============================================================================" |  tee -a $Record_File
echo ".............................................................................." |  tee -a $Record_File
echo "Start:Prepare ONL Git Clone:${TODAY}." | tee -a $Record_File

#--- Check out the specified ONL code from git Hub
TO_UPDATE_ONL="y"
if [[ "${TO_UPDATE_ONL}" == "y" ]]; then
	if [ -d ${ONL_DIR} ]; then
	   echo $LINENO "${ONL_DIR} is in the existence!!" |  tee -a $Record_File
	   rm -rf  ${ONL_DIR}
	fi

	echo "-1.1 Prepare ONL Root:" |  tee -a $Record_File
	mkdir -p ${ONL_ROOT}
	#git clone ${ONL_GIT_NAME} -b ${ONL_GIT_B} ${ONL_DIR}
	git clone ${ONL_GIT_NAME} ${ONL_DIR}
	cd  ${ONL_DIR}
	git checkout -b ${ONL_GIT_B} $(ONL_COMMIT_ID)
	cd  ${PPWW}

	if [ ! -d ${ONL_DIR} ]; then
	   echo $LINENO "missing ${ONL_DIR}" |  tee -a $Record_File
	   exit -1
	fi

fi



cd  ${PPWW}


e_time=$(date +%s)
elap_s=$((e_time-s_time))
ss=$((elap_s%60))
mm=$(((elap_s/60)%60))
hh=$((elap_s/3600))
echo "==============================================================================" | tee -a $Record_File
echo "End:Prepare ONL Git Clone:${TODAY}." | tee -a $Record_File
echo "Build total time: $hh:$mm:$ss" | tee -a $Record_File
echo "==============================================================================" | tee -a $Record_File

