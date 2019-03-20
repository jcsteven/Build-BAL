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

ONL_GIT_NAME="https://github.com/jcsteven/OpenNetworkLinux.git"
ONL_GIT_B=2019-0103-fixed-tg3
ONL_NAME=OpenNetworkLinux
ONL_DIR=${HOME}/${ONL_NAME}

BAL_NAME=G64
BAL_DIR=${HOME}/${BAL_NAME}
BAL_BUILD_DIR=${BAL_DIR}/bal_release

BROADCOM_DOWNLOAD_DIR=${HOME}/broadcom/download
EDGECORE_DOWNLOAD_DIR=${HOME}/edgecore/download
: ${BALSRC_ZIPNAME:=SW-BCM68620_2_6_1_3.zip}

: ${SWISDK_TARNAME:=sdk-all-6.5.7}
: ${PATCH_FILENAME:=ACCTON_BAL_2.6.1.3-V201901010306.patch}


BLOG_DIR="Build-log"
BLOG_DIR_WK=${HOME}/${BLOG_DIR}
Record_File=${BLOG_DIR_WK}/onl-bal-log.txt

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



