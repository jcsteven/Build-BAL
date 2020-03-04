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

echo "BALSRC_ZIPNAME=${BALSRC_ZIPNAME}"
echo "SDK_FILE=${SDK_FILE}"
echo "PATCH_FILENAME=${PATCH_FILENAME}"
echo "PATCH_FILENAME_LATEST=${PATCH_FILENAME_LATEST}"


[ -d $BLOG_DIR_WK ] || mkdir $BLOG_DIR_WK
s_time=$(date +%s)
echo "==============================================================================" |  tee -a $Record_File
echo ".............................................................................." |  tee -a $Record_File
echo "Start: ${me_file}:${TODAY}." | tee -a $Record_File

#----Prepare workspace for BAL
TO_PREPARE_BAL="y"
if [[ "${TO_PREPARE_BAL}" == "y" ]]; then
	if [ ! -d $BROADCOM_DOWNLOAD_DIR ]; then
	   echo $LINENO "missing ${BROADCOM_DOWNLOAD_DIR}" |  tee -a $Record_File
	   exit -1
	fi

	if [ ! -f ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME} ]; then
	   echo $LINENO "missing ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME}" |  tee -a $Record_File
	   exit -1
	fi
	
	echo "-1.x Prepare BAL Root:"
	[ -d ${BAL_ROOT} ] || mkdir ${BAL_ROOT}	

	TO_PREPARE_BAL_ORGIN="y"
	if [[ "${TO_PREPARE_BAL_ORGIN}" == "y" ]]; then
	   BAL_DIR_ORIG=release-${BAL_VERSION}-orig
	   BAL_DIR=${BAL_ROOT}/${BAL_DIR_ORIG}	
	   echo "-1.x Prepare BAL origin "
	   [ -d ${BAL_DIR} ] || mkdir ${BAL_DIR}		   
	   tar zxvf ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME} -C ${BAL_DIR} --strip-components=1
	   chmod -R 744 ${BAL_DIR}
	   tar czvf ${BAL_DIR}.tar.gz ${BAL_DIR}/	   
	fi
	
	TO_PREPARE_BAL_ORGIN_FIXED="y"
	if [[ "${TO_PREPARE_BAL_ORGIN_FIXED}" == "y" ]]; then
	   BAL_DIR_FIXED=release-${BAL_VERSION}-orig-fixed
	   BAL_DIR=${BAL_ROOT}/${BAL_DIR_FIXED}		   
	   echo "-1.x Prepare BAL origin fixed "
	   	   [ -d ${BAL_DIR} ] || mkdir ${BAL_DIR}	
	   tar zxvf ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME} -C ${BAL_DIR} --strip-components=1
	   chmod -R 744 ${BAL_DIR_FIXED}
	   
	   cp ${BAL_DIR}/host_customized/cmake/modules/wrx.cmake   ${BAL_DIR}/host_customized/cmake/modules/asfvolt16.cmake
	   cp ${BAL_DIR}/host_customized/cmake/modules/wrx.cmake   ${BAL_DIR}/host_customized/cmake/modules/asgvolt64.cmake

	   cp -avr ${BAL_DIR}/host_customized/user_config/board/wrx   ${BAL_DIR}/host_customized/user_config/board/asfvolt16
	   cp -avr ${BAL_DIR}/host_customized/user_config/board/wrx   ${BAL_DIR}/host_customized/user_config/board/asgvolt64
	   
	   cp -avr ${BAL_DIR}/host_customized/user_config/board_selector/wrx   ${BAL_DIR}/host_customized/user_config/board_selector/asfvolt16
	   cp -avr ${BAL_DIR}/host_customized/user_config/board_selector/wrx   ${BAL_DIR}/host_customized/user_config/board_selector/asgvolt64	   

	   cp -avr ${BAL_DIR}/switch_sdk/6.5.13/rc/svk4   ${BAL_DIR}/switch_sdk/6.5.13/rc/asfvolt16
	   cp -avr ${BAL_DIR}/switch_sdk/6.5.13/rc/svk4   ${BAL_DIR}/switch_sdk/6.5.13/rc/asgvolt64	   
	   
	   tar czvf ${BAL_DIR}.tar.gz ${BAL_DIR}/	   
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

