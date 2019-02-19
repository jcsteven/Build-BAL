This the build scrip for: Build-BAL2.6.1.3 (kernel 4.14.49)

NDA files required from BROADCOM
1. ~/broadcom/download/sdk-all-6.5.7.tar.gz
2. ~/broadcom/download/SW-BCM68620_2_6_0_1.zip
3. ~/edgecore/download/ACCTON_BAL_2.6.0.1-V201808011201.patch

HowToBuild
1 Prepare the requied for build the ONL and BAL
 $./1.0_Build-BAL-Prepare.sh

 Note:
   A. The default script is not to update the ONL Source.
      So, if you want to git update the ONL source, be sure to add [TO_UPDATE_ONL="y"]

2. Get in Docker environment
  This build environment assumes the ONL fol at ${HOME}/OpenNetworkLinux
  $ cd ${HOME}/OpenNetworkLinux/
  $ docker/tools/onlbuilder -8
  $ apt-cacher-ng
  $ source setup.env
  $ cd ..

3. Run the scrip o build code
  This build environment assumes the BAL_NAME at ./bal_src_release
  $ ./2.0_Build-BAL_ONL.sh
  $ ./2.1_Build-BAL_Maple.sh
  $ ./2.2_Build-BAL_Qumran.sh
  $ ./2.3_Build-BAL_API_Applicatio.sh
  $ ./2.4_Build-BAL_Board_Release_File.sh

4. To copy ONL and BAL package in the folder in md64-<build date>-BAL-Build
  $ ./3.0_Build-BAL_Copy_Image.sh
==============================================
