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


echo "BALSRC_ZIPNAME=${BALSRC_ZIPNAME}"
echo "SDK_FILE=${SDK_FILE}"
echo "PATCH_FILENAME=${PATCH_FILENAME}"
echo "PATCH_FILENAME_LATEST=${PATCH_FILENAME_LATEST}"


[ -d $BLOG_DIR_WK ] || mkdir $BLOG_DIR_WK
s_time=$(date +%s)
echo "==============================================================================" |  tee -a $Record_File
echo ".............................................................................." |  tee -a $Record_File
echo "Start:Prepare BAL:${TODAY}." | tee -a $Record_File

#----Prepare workspace for BAL
TO_PREPARE_BAL="y"
if [[ "${TO_PREPARE_BAL}" == "y" ]]; then
	if [ ! -d $BROADCOM_DOWNLOAD_DIR ]; then
	   echo $LINENO "missing ${BROADCOM_DOWNLOAD_DIR}" |  tee -a $Record_File
	   exit -1
	fi

	if [ ! -d ${EDGECORE_DOWNLOAD_DIR} ]; then
	   echo $LINENO "missing ${EDGECORE_DOWNLOAD_DIR}" |  tee -a $Record_File
	   exit -1
	fi

	if [ ! -d ${ONL_DIR} ]; then
	   echo $LINENO "missing ${ONL_DIR}" |  tee -a $Record_File
	   exit -1
	fi

	if [ ! -f ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME} ]; then
	   echo $LINENO "missing ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME}" |  tee -a $Record_File
	   exit -1
	fi

	if [ ! -f "${BROADCOM_DOWNLOAD_DIR}/${SDK_FILE}" ]; then
	   echo $LINENO "123missing ${BROADCOM_DOWNLOAD_DIR}/${SDK_FILE}" |  tee -a $Record_File
	   exit -1
	fi

	if [ ! -f "${EDGECORE_DOWNLOAD_DIR}/${PATCH_FILENAME_LATEST}" ]; then
	   echo $LINENO "missing ${BROADCOM_DOWNLOAD_DIR}/${PATCH_FILENAME_LATEST}" |  tee -a $Record_File
	   exit -1
	fi

	echo "-1.x Prepare BAL Root:"
	mkdir -p ${BAL_ROOT}

	for board in ${BOARD_NAME_LIST}
	do
	  echo "For the project:${BAL_NAME}-${project} "
          PROJECT_NAME=${board}-${BAL_NAME}
          BAL_DIR=${BAL_ROOT}/${PROJECT_NAME}
	  mkdir -p ${BAL_DIR}/
	  tar zxf ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME} -C ${BAL_DIR} --strip-components=1

	  cp ${BROADCOM_DOWNLOAD_DIR}/${SDK_FILE}  ${BAL_DIR}/switch_sdk/${SDK_VERSION}/.

	  TO_PREPARE_PATCH="y"
	  if [[ "${TO_PREPARE_PATCH}" == "y" ]]; then
	      # Copy the patch file to the Broadcom SDK directory:
	      chmod -R 744 ${BAL_DIR}
	      cd  ${BAL_DIR}
	      cat ${EDGECORE_DOWNLOAD_DIR}/${PATCH_FILENAME_LATEST} | patch -p1
	      cd ..
	  fi

	done

fi


cd  ${PPWW}


e_time=$(date +%s)
elap_s=$((e_time-s_time))
ss=$((elap_s%60))
mm=$(((elap_s/60)%60))
hh=$((elap_s/3600))
echo "==============================================================================" | tee -a $Record_File
echo "End:Prepare BAL:${TODAY}." | tee -a $Record_File
echo "Build total time: $hh:$mm:$ss" | tee -a $Record_File
echo "==============================================================================" | tee -a $Record_File

