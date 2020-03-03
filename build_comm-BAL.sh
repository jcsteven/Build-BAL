#!/bin/bash
# -------------------------------------------------------
# Automatic preparation script for rtk_openwrt
# JC Yu,     Novenber 26,2015
# -------------------------------------------------------
# IMPORTANT:
#   When use: './<this script file>  '
# -------------------------------------------------------
#TODAY=`date +"%Y-%m%d-%H%M"`
:${PPWW:=`pwd`}
:${Record_File_name:=Build-BAL-3.4.3.3-logs.txt}
ONL_GIT_NAME="https://github.com/jcsteven/OpenNetworkLinux.git -b ONL-4.14.151-72b95a72"
#ONL_GIT_NAME="https://github.com/opencomputeproject/OpenNetworkLinux.git"
ONL_GIT_B=ONL-4.14.151
ONL_COMMIT_ID=72b95a72
ONL_NAME=OpenNetworkLinux
ONL_ROOT=${HOME}
ONL_DIR=${ONL_ROOT}/${ONL_NAME}

OPENOLT_GIT_NAME="https://git88.accton.com.tw/cicada/vOLT/openolt.git -b bal31-dev"
#OPENOLT_GIT_NAME="https://git88.accton.com.tw/jcyu/openolt-gerrit.git -b bal31"
#OPENOLT_GIT_NAME="https://github.com/jcsteven/openolt.git"
#OPENOLT_GIT_NAME="https://github.com/opencord/openolt.git"
#OPENOLT_GIT_NAME="https://gerrit.opencord.org/openolt"
OPENOLT_GIT_B=bal31
OPENOLT_NAME=OpenOLT
OPENOLT_ROOT=${HOME}
OPENOLT_DIR=${OPENOLT_ROOT}/${OPENOLT_NAME}

BOARD_NAME_LIST="asfvolt16 asgvolt64"
PROJECT_NAME_LIST="ASF ASG"

BAL_ROOT=${HOME}/BAL
BAL_VERSION=3.4.0.0
BAL_NAME=bal
#BAL_BUILD_DIR=${ONL_DIR}/${BAL_NAME}

BROADCOM_DOWNLOAD_DIR=${HOME}/broadcom/download
EDGECORE_DOWNLOAD_DIR=${HOME}/edgecore/download
: ${BALSRC_ZIPNAME:=SW-BCM686OLT_3_4_3_3.tgz}
: ${SDK_VERSION:=6.5.13}
: ${PATCH_FILENAME:=ACCTON_BAL_3.4.3.3-V202002100101.patch}
: ${PATCH_FILENAME_LATEST:=ACCTON_BAL_3.4.3.3-V202002100101.patch}

SWISDK_TARNAME=sdk-all-${SDK_VERSION}
SDK_FILE=${SWISDK_TARNAME}.tar.gz



BLOG_DIR="Build-log"
BLOG_DIR_WK=${HOME}/${BLOG_DIR}
Record_File=${BLOG_DIR_WK}/${Record_File_name}

echo "PPWW=${PPWW}"

echo "ONL_GIT_NAME=${ONL_GIT_NAME}"
echo "ONL_GIT_B=${ONL_GIT_B}"
echo "ONL_NAME=${ONL_NAME}"

echo "BROADCOM_DOWNLOAD_DIR=${BROADCOM_DOWNLOAD_DIR}"
echo "EDGECORE_DOWNLOAD_DIR=${EDGECORE_DOWNLOAD_DIR}"
echo "BALSRC_ZIPNAME=${BALSRC_ZIPNAME}"
echo "SWISDK_TARNAME=${SWISDK_TARNAME}"
echo "PATCH_FILENAME=${PATCH_FILENAME}"

echo "BLOG_DIR=${BLOG_DIR}"
echo "BLOG_DIR_WK=${BLOG_DIR_WK}"
echo "Record_File=${Record_File}"



