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

if [ ! -d $OPENOLT_DIR ]; then
	echo $LINENO "missing ${OPENOLT_DIR}" |  tee -a $Record_File
	exit -1
fi

TO_UPDATE_ONL="y"
if [[ "${TO_UPDATE_ONL}" == "y" ]]; then
   echo "-2. Prepare ONL Folder in OpenOLT: ${OPENOLT_DIR}"
   echo "==> Do you want make ONL(${ONL_DIR}) Link to OpenOLT ? "
   read -p " Yes-[Y or y] or No-[N or n]- Your select is Yes or No ?" -n 1 -r
   if [[ $REPLY =~ ^[Yy]$ ]]
   then
       echo "\nONL_DIR=${ONL_DIR}"
	echo "OPENOLT_DIR=${OPENOLT_DIR}"
	   if [ ! -d $ONL_DIR ]; then
	       echo $LINENO "missing ${ONL_DIR}" |  tee -a $Record_File
	       exit -1
	   fi
	   mkdir -p ${OPENOLT_DIR}/agent/build/onl
	   ln -s ${ONL_DIR} ${OPENOLT_DIR}/agent/build/onl/OpenNetworkLinux

   elif [[ $REPLY =~ ^[Nn]$ ]]
   then
       echo "Select to Y for Nothing !!"
   else
        echo "Select to exit !!"
	   exit -1
   fi
fi

TO_UPDATE_BAL="y"
if [[ "${TO_UPDATE_BAL}" == "y" ]]; then
	echo "-3.x Prepare BAL-${board} Linker for OpenOLT:"
	echo "==> Do you want make BAL-${borad} Link to OpenOLT ? "
	read -p " Yes-[Y or y] or No-[N or n]- Your select is Yes or No ?" -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	  echo "\nTo Create Link for OpenOLT."
	  for board in ${BOARD_NAME_LIST}
	  do
	    PROJECT_NAME=${board}-${BAL_NAME}
	    BAL_DIR=${BAL_ROOT}/${PROJECT_NAME}
 	    if [ ! -d $BAL_DIR ]; then
 	       echo $LINENO "missing ${BAL_DIR}" |  tee -a $Record_File
 	       exit -1
 	    fi

 	    echo "From: BAL_DIR=${BAL_DIR}"
 	    echo "OPENOLT_DIR=${OPENOLT_DIR}"
 	    echo "To : ${OPENOLT_DIR}/agent/build/${PROJECT_NAME}"
 	    mkdir -p ${OPENOLT_DIR}/agent/build
 	    ln -s ${BAL_DIR} ${OPENOLT_DIR}/agent/build/${PROJECT_NAME}
	  done
	elif [[ $REPLY =~ ^[Nn]$ ]]
	then
 	  echo "Select to Y for Nothing !!"
	else
 	  echo "Select to exit !!"
 	  exit -1
	fi
fi

TO_UPDATE_NDA="y"
if [[ "${TO_UPDATE_NDA}" == "y" ]]; then
   DOWNLOAD_DIR=${OPENOLT_DIR}/agent/download
   echo "-4. Copy NDA files in OpenOLT: ${OPENOLT_DIR}"
   echo "==> Do you want make NDA files Link to OpenOLT ? "
   read -p " Yes-[Y or y] or No-[N or n]- Your select is Yes or No ?" -n 1 -r
   if [[ $REPLY =~ ^[Yy]$ ]]
   then
       echo "\nDOWNLOAD_DIR=${DOWNLOAD_DIR}"
	   echo "OPENOLT_DIR=${OPENOLT_DIR}"
	   if [ ! -f ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME} ]; then
	    echo $LINENO "missing ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME}" |  tee -a $Record_File
	    exit -1
	   fi

	   if [ ! -f "${BROADCOM_DOWNLOAD_DIR}/${SDK_FILE}" ]; then
	    echo $LINENO "123missing ${BROADCOM_DOWNLOAD_DIR}/${SDK_FILE}" |  tee -a $Record_File
	    exit -1
	   fi

	   if [ ! -f "${EDGECORE_DOWNLOAD_DIR}/${PATCH_FILENAME}" ]; then
	    echo $LINENO "missing ${BROADCOM_DOWNLOAD_DIR}/${PATCH_FILENAME}" |  tee -a $Record_File
	    exit -1
	   fi

	   cp ${BROADCOM_DOWNLOAD_DIR}/${SDK_FILE}  ${DOWNLOAD_DIR}/.
 	   cp ${BROADCOM_DOWNLOAD_DIR}/${BALSRC_ZIPNAME}  ${DOWNLOAD_DIR}/.
	   cp ${BROADCOM_DOWNLOAD_DIR}/${SDK_FILE}  ${DOWNLOAD_DIR}/.
 	   cp ${EDGECORE_DOWNLOAD_DIR}/${PATCH_FILENAME}  ${DOWNLOAD_DIR}/.

   elif [[ $REPLY =~ ^[Nn]$ ]]
   then
       echo "Select to Y for Nothing !!"
   else
        echo "Select to exit !!"
	   exit -1
   fi
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

