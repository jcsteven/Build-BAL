#!/bin/bash
# -------------------------------------------------------
# Automatic preparation script for rtk_openwrt 
# JC Yu,     Novenber 26,2015
# -------------------------------------------------------
# IMPORTANT:
#   When use: './<this script file>  '
# -------------------------------------------------------
# Install cmake 3.5.2
sudo apt-get purge cmake
rm  -rf cmake-3.5.2
wget https://cmake.org/files/v3.5/cmake-3.5.2.tar.gz
tar xzvf cmake-3.5.2.tar.gz
cd cmake-3.5.2/
./bootstrap
make
sudo make install
sudo ln -s /usr/local/bin/cmake /usr/bin/cmake

cd ..
