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
echo "Start:2.5  BAL_Build-Copy Image-${TODAY}=> ${ONL_DIR}" | tee -a $Record_File

IMAGE_NAME=amd64-${TODAY}-BAL-Build
[ -d ./${IMAGE_NAME} ] || mkdir -p ./${IMAGE_NAME}

TO_COPY_ONL_IMAGE="y"
if [[ "${TO_COPY_ONL_IMAGE}" == "y" ]]; then
	echo "To Copy ONL Image File."
	cd ${ONL_DIR}
	ONL_VERSION=`git branch | sed -e 's/*//g' | sed -e 's/^[ \t]*//'`
	cd ${PPWW}
	BUILD_DIR1=${ONL_DIR}/RELEASE/jessie/amd64
	if [ ! -d ${BUILD_DIR1} ]; then
	   echo $LINENO "missing ${BUILD_DIR1}" |  tee -a $Record_File
	   exit -1
	fi
	#-- Create build imgage folder
	cp ${BUILD_DIR1}/ONL-*_AMD64_INSTALLED_INSTALLER ./${IMAGE_NAME}
fi

TO_COPY_BAL_IMAGE="y"
if [[ "${TO_COPY_BAL_IMAGE}" == "y" ]]; then 
	echo "To Copy BAL Image File."	
	BUILD_DIR2=${BAL_BUILD_DIR}/3rdparty/bcm-sdk/rc/asfvolt16/release
	if [ ! -d ${BAL_BUILD_DIR2} ]; then
	   echo $LINENO "missing ${BUILD_DIR2}" |  tee -a $Record_File
	   exit -1
	fi			
	
	#-- Create build imgage folder
    cp ${BUILD_DIR2}/*.tar.gz ./${IMAGE_NAME}
fi


e_time=$(date +%s)
elap_s=$((e_time-s_time))
ss=$((elap_s%60))
mm=$(((elap_s/60)%60))
hh=$((elap_s/3600))
echo "==============================================================================" | tee  -a  $Record_File
echo "End  :Start:2.5  BAL_Build-Copy Image-${TODAY}=> ${ONL_DIR}" | tee -a $Record_File
echo "Build total time: $hh:$mm:$ss" | tee  -a  $Record_File
echo "==============================================================================" | tee  -a  $Record_File

