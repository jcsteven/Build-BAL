#!/bin/bash
# -------------------------------------------------------
# Automatic preparation script for rtk_openwrt
# JC Yu,     Novenber 26,2015
# -------------------------------------------------------
# IMPORTANT:
#   When use: './<this script file>  '
# -------------------------------------------------------
./1.0_Build-ONL-Prepare.sh
./1.0_Build-BAL-Prepare.sh
./2.0_Build-BAL_ONL.sh
./2.1_Build-BAL_ASFVOLT16.sh
./2.2_Build-BAL_ASGVOLT64.sh





