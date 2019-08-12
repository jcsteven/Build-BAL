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
echo "..............................................................................." | tee -a $Record_File
echo "Start:3.0  BAL_Build-Copy Image-${TODAY}." | tee -a $Record_File

IMAGE_NAME=amd64-${TODAY}-BAL-${BAL_VERSION}-Build
[ -d ./${IMAGE_NAME} ] || mkdir -p ./${IMAGE_NAME}

TO_COPY_ONL_IMAGE="y"
if [[ "${TO_COPY_ONL_IMAGE}" == "y" ]]; then
	echo "To Copy ONL Image File."
	BUILD_DIR1=${ONL_DIR}/RELEASE/jessie/amd64
	if [ ! -d ${BUILD_DIR1} ]; then
	   echo $LINENO "missing ${BUILD_DIR1}" |  tee -a $Record_File
	   echo $LINENO "Fail to collect ONL image." |  tee -a $Record_File
	   #exit -1
	else
	   #-- Create build imgage folder
	   cp ${BUILD_DIR1}/ONL-*_ONL-OS*_AMD64_INSTALLED_INSTALLER ./${IMAGE_NAME}
	fi

fi

TO_COPY_BAL_IMAGE="y"
if [[ "${TO_COPY_BAL_IMAGE}" == "y" ]]; then
	for board in ${BOARD_NAME_LIST}
	do
	    PROJECT_NAME=${BAL_NAME}-${board}
	    BAL_DIR=${BAL_ROOT}/${PROJECT_NAME}
	    echo "To Copy BAL ${board} Image File."
	    BUILD_DIR2=${BAL_DIR}/build/fs/${board}/release
	    if [ ! -d ${BAL_BUILD_DIR2} ]; then
	       echo $LINENO "missing ${BUILD_DIR2}" |  tee -a $Record_File
	       #exit -1
	    else
	       cp ${BUILD_DIR2}/*.tar.gz ./${IMAGE_NAME}
	    fi
	done
fi


e_time=$(date +%s)
elap_s=$((e_time-s_time))
ss=$((elap_s%60))
mm=$(((elap_s/60)%60))
hh=$((elap_s/3600))
echo "==============================================================================" | tee  -a  $Record_File
echo "End:3.0  BAL_Build-Copy Image-${TODAY}." | tee -a $Record_File
echo "Build total time: $hh:$mm:$ss" | tee  -a  $Record_File
echo "==============================================================================" | tee  -a  $Record_File






