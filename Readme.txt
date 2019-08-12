This the build scrip for: Build-BAL-3.1.1.1 (kernel 4.14.109)

NDA files required from BROADCOM
1. ~/broadcom/download/sdk-all-6.5.13.tar.gz
2. ~/broadcom/download/SW-BCM68620_3_1_1_1.tgz
3. ~/edgecore/download/ACCTON_BAL_3.1.1.1-V201908010203.patch

HowToBuild
1 Prepare the requied for build the ONL and BAL
 $./1.0_Build-BAL-Prepare.sh

 Note:
   A. The default script is not to update the ONL Source.
      So, if you want to git update the ONL source, be sure to add [TO_UPDATE_ONL="y"]

2. Get in Docker environment
  $ cd OpenNetworkLinux/
  $ docker/tools/onlbuilder -8
  $ apt-cacher-ng
  $ source setup.env
  $ cd ..

3. Run the scrip o build code
  $ ./2.0_Build-BAL_ONL.sh
  $ ./2.1_Build-BAL_ASFVOLT16.sh
  $ ./2.2_Build-BAL_ASGVOLT64.sh

4. To copy ONL and BAL package in the folder in md64-<build date>-BAL-<BAL_VERSION>-Build
  $ ./3.0_Build-BAL_Copy_Image.sh
==============================================
