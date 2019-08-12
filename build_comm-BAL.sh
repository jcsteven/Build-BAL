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
:${Record_File_name:=Build-BAL-3.1.1.1-logs.txt}
ONL_GIT_NAME="https://github.com/jcsteven/OpenNetworkLinux.git"
ONL_GIT_B=asxvolt16
ONL_NAME=OpenNetworkLinux
ONL_ROOT=${HOME}
ONL_DIR=${ONL_ROOT}/${ONL_NAME}

BOARD_NAME_LIST="asfvolt16 asgvolt64"
PROJECT_NAME_LIST="ASF ASG"

BAL_ROOT=${PPWW}/BAL
BAL_VERSION=3.1.1.1
BAL_NAME=release-${BAL_VERSION}
#BAL_BUILD_DIR=${ONL_DIR}/${BAL_NAME}

BROADCOM_DOWNLOAD_DIR=${HOME}/broadcom/download
EDGECORE_DOWNLOAD_DIR=${HOME}/edgecore/download
: ${BALSRC_ZIPNAME:=SW-BCM68620_3_1_1_1.tgz}
: ${SDK_VERSION:=6.5.13}
: ${PATCH_FILENAME:=ACCTON_BAL_3.1.1.1-V201908010203.patch}

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



