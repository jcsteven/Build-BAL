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
Support to work build OpenOLT agent
0. Prepare OpenNeworkLinix, BAL and OpenOLT is fixed folders.
  ONL: 
      ~/OpenNetworkLinux
  BAL: 
      ~/BAL/asfvolt16-bal (ASFVOLT16)
  OpenOLT:
      ~/OpenOLT

1.Check out code 
  git clone https://git88.accton.com.tw/jcyu/openolt-gerrit.git -b bal31 ~/OpenOLT

2. Make linkers for OpenOLT 
   mkdir  ~/openolt/build
   mkdir  ~/openolt/build/onl 
   ln -s ~/OpenNetworkLinux  ./build/onl/OpenNetworkLinux
   ln -s ~/BAL/asfvolt16-bal  ./build/asfvolt16-bal
   ln -s ~/BAL/asfvolt16-bal  ./build/asgvolt64-bal

/home/voltha/Build-BAL/BAL

3. To skip build ONL and BAL in OpenAgent
	make distclean
	make onl --skip
	make sdk --skip
	make protos
	make protos-clean

