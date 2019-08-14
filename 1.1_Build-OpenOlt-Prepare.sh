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
echo "Start:Prepare OpenOLT:${TODAY}." | tee -a $Record_File

#--- Check out the specified ONL code from git Hub
TO_UPDATE_OPENOLT="y"
if [[ "${TO_UPDATE_OPENOLT}" == "y" ]]; then
	echo "-1. Prepare OpenOLT Root:"
	mkdir -p ${OPENOLT_ROOT}
	git clone ${OPENOLT_GIT_NAME}  ${OPENOLT_DIR}
fi

TO_UPDATE_ONL_LINK="y"
if [[ "${TO_UPDATE_ONL_LINK}" == "y" ]]; then
	echo "-2. Prepare ONL Linker for OpenOLT:"
	echo "ONL_DIR=${ONL_DIR}"
	echo "OPENOLT_DIR=${OPENOLT_DIR}"
	mkdir -p ${OPENOLT_DIR}/agent/build/onl
	ln -s ${ONL_DIR} ${OPENOLT_DIR}/agent/build/onl/OpenNetworkLinux
fi

TO_UPDATE_BAL_LINK="y"
if [[ "${TO_UPDATE_BAL_LINK}" == "y" ]]; then
	for board in ${BOARD_NAME_LIST}
	do
	  echo "-3.x Prepare BAL-${board} Linker for OpenOLT:"
	  PROJECT_NAME=${board}-${BAL_NAME}
	  BAL_DIR=${BAL_ROOT}/${PROJECT_NAME}	
	  echo "From: BAL_DIR=${BAL_DIR}"
	  echo "OPENOLT_DIR=${OPENOLT_DIR}"
	  echo "To : ${OPENOLT_DIR}/agent/build/${PROJECT_NAME}"	  
	  mkdir -p ${OPENOLT_DIR}/agent/build
	  ln -s ${BAL_DIR} ${OPENOLT_DIR}/agent/build/${PROJECT_NAME}
	done  
fi



e_time=$(date +%s)
elap_s=$((e_time-s_time))
ss=$((elap_s%60))
mm=$(((elap_s/60)%60))
hh=$((elap_s/3600))
echo "==============================================================================" | tee -a $Record_File
echo "End:Prepare BAL:${TODAY}." | tee -a $Record_File
echo "Build total time: $hh:$mm:$ss" | tee -a $Record_File
echo "==============================================================================" | tee -a $Record_File

