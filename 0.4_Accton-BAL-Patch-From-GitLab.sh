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



#----Prepare workspace for BAL
TO_PREPARE_BAL="y"
if [[ "${TO_PREPARE_BAL}" == "y" ]]; then

	echo "-1.x Prepare BAL Root:"
	[ -d ${BAL_ROOT} ] || mkdir ${BAL_ROOT}
	
	cd ${BAL_ROOT}
	TO_PREPARE_BAL_ORGIN="y"
	if [[ "${TO_PREPARE_BAL_ORGIN}" == "y" ]]; then
	   echo "-1.a Prepare BAL patch-a(origin sdk) from gitLab "
	   git clone https://git88.accton.com.tw/cicada/vOLT/BAL.git -b ${BAL_VERSION} a
	   rm -rf a/.git
	   rm -f a/switch_sdk/6.5.13/sdk-all-6.5.13.tar.gz
	fi
	
	TO_PREPARE_BAL_ORGIN_FIXED="y"
	if [[ "${TO_PREPARE_BAL_ORGIN_FIXED}" == "y" ]]; then
	   echo "-1.b Prepare BAL patch-b(latest chnage) from gitLab "
	   git clone https://git88.accton.com.tw/cicada/vOLT/BAL.git -b ${BAL_VERSION}-dev b
	   rm -rf b/.git
	   rm -f b/switch_sdk/6.5.13/sdk-all-6.5.13.tar.gz
	fi

	TO_PREPARE_BAL_PATCH_FILE="y"
	if [[ "${TO_PREPARE_BAL_PATCH_FILE}" == "y" ]]; then
	   echo "-1.c Prepare BAL patch file from a and b "
	   diff -Naur  a/ b/ >  ACCTON_BAL_3.4.3.3-V202002100101-temp.patch
	fi
	
fi


cd  ${PPWW}


e_time=$(date +%s)
elap_s=$((e_time-s_time))
ss=$((elap_s%60))
mm=$(((elap_s/60)%60))
hh=$((elap_s/3600))
echo "==============================================================================" | tee -a $Record_File
echo "End: ${me_file}:${TODAY}-Done!!" | tee -a $Record_File
echo "Build total time: $hh:$mm:$ss" | tee -a $Record_File
echo "==============================================================================" | tee -a $Record_File

