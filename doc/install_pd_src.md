
Build and Use Phytec Linux BSP on Phytec phyBOARD-WEGA-AM335x

## About this manual
This manual shows how to 

* install the source code of the Linux BSP for phyBOARD-WEGA-AM335x on the host, 
* build it, 
* install the resulting images on the target and 
* start Linux on the target. 
 

It is possible to boot the target 

* from NAND or
* from SD-card
 

It is possible to load the kernel and the rootfs 

* from NAND,
* from SD-card or
* via TFTP and NFS
 

This BSP is for use with:

* phyBOARD-WEGA-AM335x with carrier board 1405.0 or 1405.1
* HDMI Adapter PEB-AV-01 1406.0 or 1406.1
* Eval Module PEB-EVAL-01 1413.0 or 1413.1
 

This tutorial and the accompanying makefiles for this BSP have been tested on:

* phyBOARD-WEGA-AM335x with carrier board 1405.1
* HDMI Adapter PEB-AV-01 1406.1
* Eval Module PEB-EVAL-01 1413.1
 

Some parts of this tutorial are repeated at places where there are needed, to avoid jumping back in the text, when following the instructions. 

There are similar chapters in this text, because they describe the commands for a <i>quick start</i> or for <i>development</i> or usage of the commands for the <i>first time</i> or usage of the commands <i>again</i>.

* When you want to use only the necessary commands, follow the instructions in the [[Quick_Start_Source_1|quick start]] chapter. 
* When you want to use all commands or want to change the source code, then start with the [[Develop_Source_1|development]] chapter and skip the <i>quick start</i> and <i>again</i> chapters.
* When you want to use the commands again, then follow the instructions in the [[Develop_Source_1|development]] chapter and skip the <i>first time</i> chapters.
 

At first this might seem to be confusing, but in the long run it saves time, when regularly using this tutorial and the accompanying makefiles. 


## Folder, Filenames and Macros
Folders:<br/>
Folder for Phytec Linux software: <tt>${MY_DEVELOP}</tt><br/>
Folder for current software distribution: <tt>${DISTRIB_IN}</tt>

Filenames:<br/>
makefile: <tt>${BSP_MK}</tt>

Macros: <br/>
Version Identifier <tt>${MY_VERSION}</tt><br/>

## Environment
Define environment variables:
<pre>export MY_VERSION=20141113-1
export MY_DEVELOP=/MyDevelop/phyBOARD-WEGA-AM335x
export DISTRIB_IN=${MY_DEVELOP}/distrib/test-${MY_VERSION}
</pre>
Please adjust the value of <tt>MY_DEVELOP</tt> to your needs. Use the same value also in the makefile <tt>${BSP_MK}</tt>. 
## Install Software on the host
This section describes how to install Phytec and third party software on the host. 

The commands in this tutorial have been tested on a system running [http://www.gentoo.org Gentoo Linux]. Most commands should be the same on other Linux systems.


### Install third party software on the host
For building the Linux BSP from source you need the tools: <tt>wget, expect, sudo, fakeroot</tt><br/>
On Gentoo Linux you can install these tools with
<pre>emerge --ask -v wget expect sudo fakeroot</pre>
<tt>emerge</tt> is a Gentoo specific command for installing software.

For testing and using the Linux BSP on a Phytec phyBOARD-WEGA-AM335x board you need the utilities: <tt>tftp, nfs, minicom, taylor-uucp</tt><br/>
You can install these tools with<br/>

<pre>emerge --ask -v tftp-hpa nfs-utils minicom taylor-uucp</pre>
For working with git repositories you need: <tt>git</tt>

If you want to use the GUI of git you need also: <tt>git gui, gitk</tt>

<tt>nano</tt> is used as editor. 

You need a TFTP server on your host system for installing the binary images on the target and boot from NAND. 

You need a NFS and TFTP server on your host system for [[Boot_via_TFTP_and_NFS]]

<tt>make</tt> is usally used in the commands in this manual. 

Install missing software on the host. 
### Install Phytec software on the host
Phytec software for Linux for phyBOARD-WEGA-AM335x is shipped in several parts. The first part is shipped  as git repository. 

Please install the software into the folder <tt>${DISTRIB_IN}</tt>
<pre>mkdir -p ${DISTRIB_IN}/install
git clone http://github.com/koblersystems/phyBOARD-WEGA-AM335x-phytec-linux-install-01 ${DISTRIB_IN}/install
</pre>
So far only a small part of the software has been installed into the folder <tt>${DISTRIB_IN}</tt>. The rest of the Phytec software is downloaded later. 

The tutorial has also been installed. You can now switch to the installed tutorial, if you like. 
<pre>firefox ${DISTRIB_IN}/install/doc/install_pd_src.html</pre>

## Barebox configuration
This section describes how to edit the config files of the bootloader barebox on the target and how to return to the default environment.

When you follow the instructions in this manual, you usually don't need to edit files on the target, because the files are edited instead on the host and downloaded via tftp to the target. 
### Edit barebox files on the target
When you need to edit a file on the target e.g. <tt>/env/network/eth0</tt>, you can use the command <tt>edit</tt>
<pre>edit /env/network/eth0</pre>
Save the file with CTRL-D or close the file without saving by pressing CTRL-C.

Save changes
<pre>saveenv</pre>

### Default settings
When you want to return to the default settings, erase all your changes.
<pre>erase /dev/nand0.bareboxenv
</pre>

## Makefile
The makefile <tt>${BSP_MK}</tt> contains the code to install and use Phytec Linux for phyBOARD-WEGA-AM335x. 

Define environment variable:
<pre>export BSP_MK=${DISTRIB_IN}/install/scripts/pd_src.mk
</pre>
Define alias <tt>bmk </tt> for the make command:
<pre>alias bmk="make --makefile ${BSP_MK} -C $(dirname ${BSP_MK})"
</pre>
Before using the makefile, you need to set some variables in it
<pre>nano ${BSP_MK}</pre>
Especially set the value of <tt>${MY_DEVELOP}</tt> to the same value you have already defined in the environment. 

New or changed content of file <tt>${BSP_MK}</tt>: 
<pre>
#################################################
# User specific settings
# Please set the variables below this line
#################################################

# Set the root folder for the Phytec Linux BSP software
# most of the files and directories are installed or created in this folder or subfolders.
MY_DEVELOP:=/MyDevelop/phyBOARD-WEGA-AM335x

# current version number
MY_VERSION:=20141113-1

# VERY IMPORTANT: This is the device name of the SD-card on the host, when it is inserted in the card reader.
# This device will be ERASED and FORMATTED!!!
# Don't select a disk of your host, otherwise it will be erased !!
# You can use 'dmesg' to find out the device name, after the SD-card has been inserted in the card reader.
# If you don't know the device name use /dev/null
SDCARD_DEV:=/dev/null
# This is the prefix of the partition name: usally it is the same as $(SDCARD_DEV)
# but sometimes its value is '$(SDCARD_DEV)p'.
SDCARD_PART:=$(SDCARD_DEV)

# The distribution archive has been extracted into this folder
DISTRIB_IN:=$(MY_DEVELOP)/distrib/test-$(MY_VERSION)

# Please set the download folder for software archives, which can be shared with other development environments.
MY_DOWNLOAD_SRC:=/MyDevelop/distfiles

# Download folder for archives which are specific to this board
MY_DOWNLOAD_BOARD:=/MyDownload/phyBOARD-WEGA-AM335x

# Install the toolchain into this folder, i.e. the compiler is installed in this folder. 
MY_TOOLCHAIN:=$(MY_DEVELOP)/toolchain

# Please set folder of the tftp server
MY_TFTPBOOT:=/tftpboot

# Please set the IP addresses of your host and the target.
IP_ADDR_TARGET:=192.168.1.8
IP_ADDR_HOST:=192.168.1.32
IP_NETMASK:=255.255.255.0
IP_ADDR_GATEWAY:=192.168.1.1

# This client address is used in the file /etc/exports
IP_NFS_CLIENT:=192.168.1.255/24

# Folder for the  local git repositories. This folder may be shared by several projects. 
LOCAL_GIT:=$(MY_DEVELOP)/git-PD

# Folder for the makefiles which are included at the end of this file. 
# If you move this file into another folder, you can define the include directory for the makefiles. 
# Default value is the current working directory. 
MY_SCRIPTS:=.

#################################################
#
#              Git Repositories 
#
# For the first tests you don't need to change the following values. 
#
# Only when you change the source code of the BSP
# and save the changes in git repositories 
# you need to adjust the following values as needed 
#
# The values are used in pd_src_git.mk. 
# Please search there for these macros before you change them. 
#
# Revision names or commit ids or start numbers for git repositories
# GIT_REV_NAME_*: 	git branch or tag name
# GIT_REV_ID_*: 	git commit id
# GIT_START_NUMBER_*: 	git start number of patch numbers
#
#################################################

GIT_REV_NAME_bsp:=master
GIT_REV_ID_bsp:=fb5de7ae1f61a84793bbc4d5fc5c66ec9eccd49b
GIT_REV_NAME_ptxdist:=master
GIT_REV_ID_ptxdist:=d72665bd5e4565c6793f78ae99e6e22113faed0f
GIT_REV_NAME_barebox:=master
GIT_REV_ID_barebox:=0000000
GIT_REV_ID_barebox_start:=0000000
GIT_START_NUMBER_barebox:=20
GIT_REV_NAME_linux:=master
GIT_REV_ID_linux:=00000000
GIT_REV_ID_linux_start:=00000000
GIT_START_NUMBER_linux:=120
GIT_REV_NAME_toolchain:=master
GIT_REV_ID_toolchain:=90a8fe685cb903b4cf2b668be54029d3524207b2
GIT_REV_NAME_gcc-linaro:=master
GIT_REV_ID_gcc-linaro:=00000000
GIT_REV_ID_gcc-linaro_start:=000000000
GIT_START_NUMBER_gcc-linaro:=400
GIT_REV_NAME_tftpboot:=phyBOARD-WEGA-13.0.0-01
GIT_REV_ID_tftpboot:=7f123cdf7aa7a2a4a2a58af3edfcd7c11b5541ae

#################################################
# No need to change the variables below this line
#################################################</pre>


<b>Note: </b>All needed variables are defined inside the makefile. No specific environment variable needs to be defined outside the makefile. 

Both commands list the available make targets
<pre>bmk 
bmk info_target</pre>
Before you make a target, you can check which commands will be used by using the option <tt>-n</tt>. 
<pre>bmk doc_download -n</pre>


<b>Note: </b>It is important to check which commands are used to avoid any damage to your computer system. 

When some of the make targets are succesfully made, then a state file is created for each target in the folder <tt>$(STATE)</tt>. These targets are again made only, when there is no state file. You can remove such a state file by using a target name, which is the old target name with the prefix <tt>rm_</tt>. Make e.g. the target <tt>doc_download</tt>
<pre>bmk doc_download -n
bmk doc_download</pre>
List the target states. 
<pre>bmk list_states</pre>
Before you can make the target <tt>doc_download</tt> again, you have to remove the correspondig state file by making the target <tt>rm_doc_download</tt>. 
<pre>bmk rm_doc_download
bmk doc_download</pre>
The intention of the makefile <tt>${BSP_MK}</tt> is to show or execute the correct commands, which are needed to install and use the software Phytec Linux for phyBOARD-WEGA-AM335x. It is important, that the user understands, what the commands like <tt>ptxdist</tt> are doing. This manual tries to show how to use these commands in the correct sequence. 

The makefile is not intended to replace any existing tool. Feel free to create your own scripts, makefiles or call the resulting commands directly. 

Changes in config files are often achieved by using the stream editor <tt>sed</tt>. The scripts for the stream editor search for specific patterns in the config files. Be careful when changing the config files yourself.
## Quick Start: Use the Source Code of Phytec Linux Without Changing It
If you want to get quickly up and running, 

* follow first the instructions from the beginning of this document until this chapter 
* and then the instructions in this chapter. 
 

In this chapter only the commands are shown, which are needed 

* to install the tools, 
* to build the BSP, 
* to install the images on the target and 
* to boot the target from different sources
 for the first time. 

In other parts of this document more commands are shown, which can help you with working with the BSP and developing software. Also if you run into problems when executing the commands in this quick start chapter, you should find some solutions in the rest of this document. 
### Install Tools and BSP

#### Install Tools and BSP for Phytec Linux - First Time
This chapter shows how to install the tool ptxdist, the toolchain and the BSP on the host.
##### Download Docs
download docs for bsp
<pre>bmk doc_download</pre>

##### Ptxdist
download files for ptxdist
<pre>bmk ptxdist_download</pre>
Extract ptxdist
<pre>bmk ptxdist_extract</pre>
Install ptxdist
<pre>bmk ptxdist_install</pre>
Select <tt>${MY_DOWNLOAD_SRC}</tt> as common source directory, where all the archives are downloaded, only missing archives are downloaded. All archives which will be downloaded when building the toolchain or the bsp are downloaded in this folder. 
<pre>bmk ptxdist_setup_srcdir</pre>

##### Toolchain
download files for toolchain
<pre>bmk toolchain_download</pre>
Extract Toolchain
<pre>bmk toolchain_extract</pre>
This describes the usage of <tt>ptxdist</tt> for building the toolchain. You don't need to call any of the commands, which are shown in the output, to install the toolchain right now. If you run into problems building the toolchain, you will need to call ptxdist directly. At the moment the output is only for your info: 
<pre>bmk toolchain_ptxdist</pre>
Set prefix for toolchain folder. The default is /opt. Here a local folder is selected in order not to interfere with other toolchains. 
<pre>bmk toolchain_prefix</pre>
select the toolchain
<pre>bmk toolchain_select</pre>
migrate the config file to a new ptxdist version
<pre>bmk toolchain_migrate</pre>
check PTXCONF_SETUP_SRCDIR in ptxdistrc for toolchain
<pre>bmk toolchain_check_srcdir</pre>
build the toolchain from scratch
<pre>bmk toolchain_build</pre>
remove temporary files of toolchain in order to save disk space
<pre>bmk toolchain_clean_build</pre>

##### BSP
download files for bsp
<pre>bmk bsp_download</pre>
Preparations for installing the BSP
<pre>bmk bsp_prepare</pre>
Extract BSP
<pre>bmk bsp_extract</pre>
Select the configuration files
<pre>bmk bsp_config</pre>
The compiler is searched in the /opt folder. If it is found a link is created. Select the compiler, which you have just built. 
<pre>bmk bsp_compiler</pre>
Check PTXCONF_SETUP_SRCDIR in ptxdistrc for bsp
<pre>bmk bsp_check_srcdir</pre>

##### Barebox environment for tftpboot folder
Create repository of local repository of tftpboot
<pre>bmk create_git_tftpboot_local</pre>
Create new git work repository of current tftpboot and checkout files in new source folder for existing local repositories 
<pre>bmk create_co_git_tftpboot_work</pre>
cp env into images. Copy the prepared tftpboot files into the images folder
<pre>bmk archive_barebox_env</pre>

##### Summary
Install Tools and BSP
<pre>bmk  \
	doc_download \
	ptxdist_download \
	ptxdist_extract \
	ptxdist_install \
	ptxdist_setup_srcdir \
	toolchain_download \
	toolchain_extract \
	toolchain_ptxdist \
	toolchain_prefix \
	toolchain_select \
	toolchain_migrate \
	toolchain_check_srcdir \
	toolchain_build \
	toolchain_clean_build \
	bsp_download \
	bsp_prepare \
	bsp_extract \
	bsp_config \
	bsp_compiler \
	bsp_check_srcdir \
	create_git_tftpboot_local \
	create_co_git_tftpboot_work \
	archive_barebox_env</pre>

### Build BSP for Phytec Linux - First Time
This chapter shows how to build the BSP on the host.

Build BSP with ptxdist 
<pre>bmk bsp_go</pre>
At the end you get the message: <br/>

<pre>-------------------------------------------------------------------
For a proper NFS-root environment, some device nodes are essential.
In order to create them root privileges are required.
-------------------------------------------------------------------

(Please press enter to start 'sudo' to gain root privileges.)


WARNING: NFS-root might not be working correctly!</pre>
If you missed it you can build the bsp again with:
<pre>bmk rm_bsp_go
bmk bsp_go</pre>

<pre>-------------------------------------------------------------------
For a proper NFS-root environment, some device nodes are essential.
In order to create them root privileges are required.
-------------------------------------------------------------------

(Please press enter to start 'sudo' to gain root privileges.)</pre>
Press enter.


<pre>Password: </pre>
Enter the root password. 
<pre>creating device node: platform-phyBOARD-WEGA-AM335x/root/dev/null
creating device node: platform-phyBOARD-WEGA-AM335x/root/dev/zero
creating device node: platform-phyBOARD-WEGA-AM335x/root/dev/console
creating device node: platform-phyBOARD-WEGA-AM335x/root-debug/dev/null
creating device node: platform-phyBOARD-WEGA-AM335x/root-debug/dev/zero
creating device node: platform-phyBOARD-WEGA-AM335x/root-debug/dev/console</pre>
Create images for BSP with ptxdist 
<pre>bmk bsp_images</pre>
All binaries for the target have been created now. 
### Use Binary Versions of Phytec Linux - First Time
This chapter shows how to download the binary images of the bootloader, Linux kernel and the root file system and boot the device in different ways. 
#### Create Archives of Filesystems and Install  Phytec Linux BSP on SD-Card for boot_mmc
Save barebox image, kernel image and device tree in image folder. 
<pre>bmk kernel_01</pre>
overwrite image area on SD-card with zeros , format SD-card, create binary image
<pre>bmk  parted_sdcard_01 cp_archive_sdcard_01 cp_file_sdcard_01</pre>

#### Update Bootloader in NAND
You can update the bootloader in NAND:

* by copying the images from SD-Card or 
* by downloading the images from an TFTP server. 
 
##### Use images from SD-Card
You can copy the images from an SD-card :

* after booting from the SD-Card or
* after mounting the SD-Card manually. 
 
###### Boot from SD-Card
When you boot from SD-card, the card is already mounted at /boot.<br/>
Check which devices are known
<pre>devinfo</pre>
Check which images are on the SD-card
<pre>ls /boot</pre>

<pre>MLO            barebox.bin    barebox.env    linuximage    </pre>
Update x-loader MLO
<pre>erase /dev/nand0.xload.bb
cp /boot/MLO /dev/nand0.xload.bb</pre>
Update barebox
<pre>erase /dev/nand0.barebox.bb
cp /boot/barebox.bin /dev/nand0.barebox.bb</pre>
When the bootloader has changed significantly, it is also necessary to erase the barebox environment:
<pre>erase /dev/nand0.bareboxenv</pre>

###### Mount SD-Card
Further information is available in L-775e_3.pdf on page 22. <br/>
Insert SD-Card and mount it. <br/>
Check which devices are known
<pre>devinfo</pre>
Mount the SD-card, if it is not already mounted:
<pre>mci0.probe=1
ls /mnt
mkdir /mnt/disk
mount /dev/disk0.0 /mnt/disk</pre>
Check which images are on the SD-card
<pre>ls /mnt/disk</pre>

<pre>MLO            barebox.bin    linuximage    </pre>
Update x-loader MLO
<pre>erase /dev/nand0.xload.bb
cp /mnt/disk/MLO /dev/nand0.xload.bb</pre>
Update barebox
<pre>erase /dev/nand0.barebox.bb
cp /mnt/disk/barebox.bin /dev/nand0.barebox.bb</pre>
When the bootloader has changed significantly, it is also necessary to erase the barebox environment:
<pre>erase /dev/nand0.bareboxenv</pre>

##### Download images from TFTP Server
Copy barebox image of boot_nand into images folder
<pre>bmk cp_barebox_boot_nand</pre>
Copy barebox from images folder into tftp folder
<pre>bmk tftpboot_barebox</pre>
Update barebox via TFTP
<pre>bmk update_barebox</pre>

#### Boot via NAND
copy kernel image for boot_tftp_nfs and boot_nand into images folder
<pre>bmk kernel_boot_tftp_nfs</pre>
Copy kernel into tftp folder
<pre>bmk tftpboot_kernel</pre>
Copy the ubi image of boot_nand
<pre>bmk cp_image_boot_nand</pre>
Copy root.ubi into tftp folder
<pre>bmk tftpboot_root_ubi</pre>
Update kernel and root on target for boot_nand
<pre>bmk update_target_boot_nand</pre>

#### Boot via TFTP and NFS

##### Prepare tftp config
cp env into images. Copy the prepared tftpboot files into the images folder
<pre>bmk archive_barebox_env</pre>
Barebox config files are copied into the real folder tftpboot, which is used by the tftp server. Do it only once. Default settings are to boot from NAND. 
<pre>bmk cp_barebox_config</pre>
Because the config files contain dummy ip addresses, it is important to set the correct ip addresses.
<pre>bmk set_ip_barebox_config</pre>

##### Copy init files to the Target 
Copy <tt>env/boot/net-02</tt> and some other files to the target.
<pre>bmk cp_init_board</pre>
The output of this make command describes how to download files to the target. Follow the instructions.

When barebox is restarted, <tt>/env/network/eth0</tt> is used to configure the Ethernet port. When you call 
<pre>boot net-02</pre>
 you can boot the board via TFTP and NFS. The file <tt>/env/boot/net-02</tt> is executed and loads the file <tt>/env/bin/net-03</tt> from the TFTP server. This file is also executed. 

<b>Note: </b>It is very important that you copy the init files to the target. Some commands in the makefile are changing the config file in the tftpboot folder on the host.


##### Setup barebox config to boot via tftp and nfs 
Adjust boot.default in env/config to boot from TFTP and NFS
<pre>bmk tftpboot_config_loc_boot_tftp_nfs</pre>

##### Prepare kernel and rootfs for boot via TFTP and NFS 
Build BSP with ptxdist 
<pre>bmk bsp_go</pre>
Create images for BSP with ptxdist 
<pre>bmk bsp_images</pre>
copy kernel image for boot_tftp_nfs into images folder
<pre>bmk kernel_boot_tftp_nfs</pre>
Copy kernel from images into tftp folder
<pre>bmk tftpboot_kernel</pre>
Copy RootFS Archive of boot_tftp_nfs into images
<pre>bmk cp_image_boot_tftp_nfs</pre>
Create root file system, which can be mounted via NFS. 
<pre>bmk create_rootfs_boot_tftp_nfs</pre>
Setup NFS, add rootfs to /etc/exports
<pre>bmk export_rootfs</pre>
exportfs -r
<pre>bmk export_refresh</pre>
remove fingerprint in .ssh/known_hosts
<pre>bmk ssh_fingerprint</pre>
Adjust nfsroot in env/config
<pre>bmk tftpboot_config</pre>
show command for netconsole
<pre>bmk netconsole</pre>

##### Switching between booting from NAND and via TFTP and NFS
You have just configured the board to boot via TFTP and NFS. If you want to switch back to booting from NAND, you can use the following command. 

Adjust boot.default in env/config to boot from NAND
<pre>bmk tftpboot_config_loc_boot_nand</pre>
If you want to switch again to booting via TFTP and NFS, you can use again the following command. 

Adjust boot.default in env/config to boot from TFTP and NFS
<pre>bmk rm_tftpboot_config_loc_boot_tftp_nfs
bmk tftpboot_config_loc_boot_tftp_nfs</pre>

#### Boot the board
Check if you have the correct hardware versions:

* phyBOARD-WEGA-AM335x with carrier board 1405.0 or 1405.1
* HDMI Adapter PEB-AV-01 1406.0 or 1406.1
* Eval Module PEB-EVAL-01 1413.0 or 1413.1
 

By default the board tries to boot from NAND at first. Without any valid bootloader in NAND, the board will try to boot from SD-card next.

You can force the board to try to boot from SD-card at first. This allows you to test the bootloader on the SD-card without changing anything in NAND.

If you have the carrier board 1405.0:<br/>
You can force the board to boot from SD-card by connecting X_LCD_D2 (pin 8 at X70) to a high-level (e.g. VCC3V3 – pin13 at X71) during the power-up sequence.

If you have the carrier board 1405.1: <br/>
Take off the expansion board PEB-AV-01 or PEB-AV-02. Move the DIP switch to ON, to force booting from SD-card. When you have moved the switch in direction of the SD-card slot, the switch is in position ON. 

The description how to boot from SD-card can be found in L-792e_0.pdf on page 77 and in http://www.phytec.de/de/support/faq/faq-phyboard-wega.html. 

Connect the board to the host, network and display: 

* Connect a serial cable (one-to-one) to the DB9 connector on PEB-EVAL-01. Set the speed to 115200 8N1 in your terminal application on the host. 
* Connect an ethernet cable to the port X16 on the carrier board. This is the ethernet port next to the USB port. 
* If you want to work with an SD-card, insert the SD-card into carrier board. 
* You can connect also a display to the HDMI port on PEB-AV-01. 
 

Boot the board again. 
#### Summary
Create images for SD-card
<pre>bmk  \
	kernel_01 \
	parted_sdcard_01 \
	cp_archive_sdcard_01 \
	cp_file_sdcard_01</pre>
update barebox, kernel and root file system in NAND
<pre>bmk  \
	cp_barebox_boot_nand \
	tftpboot_barebox \
	update_barebox \
	cp_image_boot_nand \
	tftpboot_root_ubi \
	kernel_boot_tftp_nfs \
	tftpboot_kernel \
	update_target_boot_nand</pre>
update kernel and root file system in NAND
<pre>bmk  \
	cp_image_boot_nand \
	tftpboot_root_ubi \
	kernel_boot_tftp_nfs \
	tftpboot_kernel \
	update_target_boot_nand</pre>
Prepare tftp config for boot via tftp and nfs
<pre>bmk  \
	archive_barebox_env \
	cp_barebox_config \
	set_ip_barebox_config \
	cp_init_board \
	tftpboot_config_loc_boot_tftp_nfs</pre>
Prepare kernel and rootfs for boot via TFTP and NFS 
<pre>bmk  \
	bsp_go \
	bsp_images \
	kernel_boot_tftp_nfs \
	cp_image_boot_tftp_nfs \
	tftpboot_kernel \
	create_rootfs_boot_tftp_nfs \
	export_rootfs \
	export_refresh \
	ssh_fingerprint \
	tftpboot_config \
	netconsole</pre>
Switch back to boot from NAND. Adjust boot.default in env/config to boot from NAND
<pre>bmk  \
	tftpboot_config_loc_boot_nand</pre>
Switch again to boot via TFTP and NFS. Adjust boot.default in env/config to boot from TFTP and NFS
<pre>bmk  \
	rm_tftpboot_config_loc_boot_tftp_nfs
bmk  \
	tftpboot_config_loc_boot_tftp_nfs</pre>

### Test or Debug
dmesg over ssh
<pre>bmk ssh_dmesg</pre>

## Development: Use and Change the Source Code of Phytec Linux
Install the tools and the BSP and create the binaries from scratch. 
### Install Tools and BSP for Phytec Linux - First Time
This chapter shows how to install the tool ptxdist, the toolchain and the BSP on the host.
#### Download Docs
download docs for bsp
<pre>bmk doc_download</pre>

#### Ptxdist
download files for ptxdist
<pre>bmk ptxdist_download</pre>
Extract ptxdist
<pre>bmk ptxdist_extract</pre>
This creates a new and empty local repository for ptxdist, if it doesn't exist already. 
<pre>bmk create_new_git_ptxdist_local</pre>
Create new repository of current ptxdist and add source code to it. This creates a new work repository, adds the current source code to it and pushes it to the local repository. 
<pre>bmk create_new_git_ptxdist_work</pre>
Push changes in  ptxdist_work to local repository. If you have changed the work repository, push changes to the local repository. When you have just extracted the archive i.e. you have not done any changes, you can skip this command.
<pre>bmk push_git_ptxdist_work</pre>
Install ptxdist
<pre>bmk ptxdist_install</pre>
Select <tt>${MY_DOWNLOAD_SRC}</tt> as common source directory, where all the archives are downloaded, only missing archives are downloaded. All archives which will be downloaded when building the toolchain or the bsp are downloaded in this folder. 
<pre>bmk ptxdist_setup_srcdir</pre>

#### Toolchain
download files for toolchain
<pre>bmk toolchain_download</pre>
Extract Toolchain
<pre>bmk toolchain_extract</pre>
This creates a new and empty local repository for toolchain, if it doesn't exist already. 
<pre>bmk create_new_git_toolchain_local</pre>
Create new repository of current toolchain and add source code to it. This creates a new work repository, adds the current source code to it and pushes it to the local repository. 
<pre>bmk create_new_git_toolchain_work</pre>
Push changes in  toolchain_work to local repository. If you have changed the work repository, push changes to the local repository. When you have just extracted the archive i.e. you have not done any changes, you can skip this command.
<pre>bmk push_git_toolchain_work</pre>
This describes the usage of <tt>ptxdist</tt> for building the toolchain. You don't need to call any of the commands, which are shown in the output, to install the toolchain right now. If you run into problems building the toolchain, you will need to call ptxdist directly. At the moment the output is only for your info: 
<pre>bmk toolchain_ptxdist</pre>
Set prefix for toolchain folder. The default is /opt. Here a local folder is selected in order not to interfere with other toolchains. 
<pre>bmk toolchain_prefix</pre>
select the toolchain
<pre>bmk toolchain_select</pre>
migrate the config file to a new ptxdist version
<pre>bmk toolchain_migrate</pre>
check PTXCONF_SETUP_SRCDIR in ptxdistrc for toolchain
<pre>bmk toolchain_check_srcdir</pre>
build the toolchain from scratch
<pre>bmk toolchain_build</pre>
remove temporary files of toolchain in order to save disk space
<pre>bmk toolchain_clean_build</pre>

#### BSP
download files for bsp
<pre>bmk bsp_download</pre>
Preparations for installing the BSP
<pre>bmk bsp_prepare</pre>
Extract BSP
<pre>bmk bsp_extract</pre>
This creates a new and empty local repository for bsp, if it doesn't exist already. 
<pre>bmk create_new_git_bsp_local</pre>
Create new repository of current bsp and add source code to it.This creates a new work repository, adds the current source code to it and pushes it to the local repository. 
<pre>bmk create_new_git_bsp_work</pre>
Push changes in bsp_work to local repository. If you have changed the work repository, push changes to the local repository. When you have just extracted the archive i.e. you have not done any changes, you can skip this command.
<pre>bmk push_git_bsp_work</pre>
Select the configuration files
<pre>bmk bsp_config</pre>
The compiler is searched in the /opt folder. If it is found a link is created. Select the compiler, which you have just built. 
<pre>bmk bsp_compiler</pre>
Check PTXCONF_SETUP_SRCDIR in ptxdistrc for bsp
<pre>bmk bsp_check_srcdir</pre>

#### Barebox environment for tftpboot folder
Create repository of local repository of tftpboot
<pre>bmk create_git_tftpboot_local</pre>
Create new git work repository of current tftpboot and checkout files in new source folder for existing local repositories 
<pre>bmk create_co_git_tftpboot_work</pre>
cp env into images. Copy the prepared tftpboot files into the images folder
<pre>bmk archive_barebox_env</pre>

#### Summary
Install Tools and BSP
<pre>bmk  \
	doc_download \
	ptxdist_download \
	ptxdist_extract \
	create_new_git_ptxdist_local \
	create_new_git_ptxdist_work \
	ptxdist_install \
	ptxdist_setup_srcdir \
	toolchain_download \
	toolchain_extract \
	create_new_git_toolchain_local \
	create_new_git_toolchain_work \
	toolchain_ptxdist \
	toolchain_prefix \
	toolchain_select \
	toolchain_migrate \
	toolchain_check_srcdir \
	toolchain_build \
	toolchain_clean_build \
	bsp_download \
	bsp_prepare \
	bsp_extract \
	create_new_git_bsp_local \
	create_new_git_bsp_work \
	bsp_config \
	bsp_compiler \
	bsp_check_srcdir \
	create_git_tftpboot_local \
	create_co_git_tftpboot_work \
	archive_barebox_env</pre>
Push changes in work folder to local repository
<pre>bmk  \
	push_git_ptxdist_work \
	push_git_toolchain_work \
	push_git_bsp_work</pre>

### Install Tools and BSP for Phytec Linux - Again
When you want to install the tools and the bsp on the host again, you have to remove the make states before you can use the make targets. The additional commands are shown. 

You have to understand what the commands are doing. Perhaps you have do remove some files or folders before you can use the make targets. 

This chapter shows how to install the tool ptxdist, the toolchain and the BSP on the host.
#### Download Docs
download docs for bsp
<pre>bmk rm_doc_download
bmk doc_download</pre>

#### Ptxdist
download files for ptxdist
<pre>bmk rm_ptxdist_download
bmk ptxdist_download</pre>
Extract ptxdist
<pre>bmk rm_ptxdist_extract
bmk ptxdist_extract</pre>
This creates a new and empty local repository for ptxdist, if it doesn't exist already. 
<pre>bmk rm_create_new_git_ptxdist_local
bmk create_new_git_ptxdist_local</pre>
Create new repository of current ptxdist and add source code to it. This creates a new work repository, adds the current source code to it and pushes it to the local repository. 
<pre>bmk rm_create_new_git_ptxdist_work
bmk create_new_git_ptxdist_work</pre>
Push changes in  ptxdist_work to local repository. If you have changed the work repository, push changes to the local repository. When you have just extracted the archive i.e. you have not done any changes, you can skip this command.
<pre>bmk rm_push_git_ptxdist_work
bmk push_git_ptxdist_work</pre>
Install ptxdist
<pre>bmk rm_ptxdist_install
bmk ptxdist_install</pre>
Select <tt>${MY_DOWNLOAD_SRC}</tt> as common source directory, where all the archives are downloaded, only missing archives are downloaded. All archives which will be downloaded when building the toolchain or the bsp are downloaded in this folder. 
<pre>bmk rm_ptxdist_setup_srcdir
bmk ptxdist_setup_srcdir</pre>

#### Toolchain
download files for toolchain
<pre>bmk rm_toolchain_download
bmk toolchain_download</pre>
Extract Toolchain
<pre>bmk rm_toolchain_extract
bmk toolchain_extract</pre>
This creates a new and empty local repository for toolchain, if it doesn't exist already. 
<pre>bmk rm_create_new_git_toolchain_local
bmk create_new_git_toolchain_local</pre>
Create new repository of current toolchain and add source code to it. This creates a new work repository, adds the current source code to it and pushes it to the local repository. 
<pre>bmk rm_create_new_git_toolchain_work
bmk create_new_git_toolchain_work</pre>
Push changes in  toolchain_work to local repository. If you have changed the work repository, push changes to the local repository. When you have just extracted the archive i.e. you have not done any changes, you can skip this command.
<pre>bmk rm_push_git_toolchain_work
bmk push_git_toolchain_work</pre>
This describes the usage of <tt>ptxdist</tt> for building the toolchain. You don't need to call any of the commands, which are shown in the output, to install the toolchain right now. If you run into problems building the toolchain, you will need to call ptxdist directly. At the moment the output is only for your info: 
<pre>bmk toolchain_ptxdist</pre>
Set prefix for toolchain folder. The default is /opt. Here a local folder is selected in order not to interfere with other toolchains. 
<pre>bmk rm_toolchain_prefix
bmk toolchain_prefix</pre>
select the toolchain
<pre>bmk rm_toolchain_select
bmk toolchain_select</pre>
migrate the config file to a new ptxdist version
<pre>bmk rm_toolchain_migrate
bmk toolchain_migrate</pre>
check PTXCONF_SETUP_SRCDIR in ptxdistrc for toolchain
<pre>bmk rm_toolchain_check_srcdir
bmk toolchain_check_srcdir</pre>
build the toolchain from scratch
<pre>bmk rm_toolchain_build
bmk toolchain_build</pre>
remove temporary files of toolchain in order to save disk space
<pre>bmk rm_toolchain_clean_build
bmk toolchain_clean_build</pre>

#### BSP
download files for bsp
<pre>bmk rm_bsp_download
bmk bsp_download</pre>
Preparations for installing the BSP
<pre>bmk bsp_prepare</pre>
Extract BSP
<pre>bmk rm_bsp_extract
bmk bsp_extract</pre>
This creates a new and empty local repository for bsp, if it doesn't exist already. 
<pre>bmk rm_create_new_git_bsp_local
bmk create_new_git_bsp_local</pre>
Create new repository of current bsp and add source code to it.This creates a new work repository, adds the current source code to it and pushes it to the local repository. 
<pre>bmk rm_create_new_git_bsp_work
bmk create_new_git_bsp_work</pre>
Push changes in bsp_work to local repository. If you have changed the work repository, push changes to the local repository. When you have just extracted the archive i.e. you have not done any changes, you can skip this command.
<pre>bmk rm_push_git_bsp_work
bmk push_git_bsp_work</pre>
Select the configuration files
<pre>bmk rm_bsp_config
bmk bsp_config</pre>
The compiler is searched in the /opt folder. If it is found a link is created. Select the compiler, which you have just built. 
<pre>bmk rm_bsp_compiler
bmk bsp_compiler</pre>
Check PTXCONF_SETUP_SRCDIR in ptxdistrc for bsp
<pre>bmk rm_bsp_check_srcdir
bmk bsp_check_srcdir</pre>

#### Barebox environment for tftpboot folder
Create repository of local repository of tftpboot
<pre>bmk rm_create_git_tftpboot_local
bmk create_git_tftpboot_local</pre>
Create new git work repository of current tftpboot and checkout files in new source folder for existing local repositories 
<pre>bmk rm_create_co_git_tftpboot_work
bmk create_co_git_tftpboot_work</pre>
cp env into images. Copy the prepared tftpboot files into the images folder
<pre>bmk rm_archive_barebox_env
bmk archive_barebox_env</pre>

#### Summary
Install Tools and BSP
<pre>bmk  \
	rm_doc_download \
	rm_ptxdist_download \
	rm_ptxdist_extract \
	rm_create_new_git_ptxdist_local \
	rm_create_new_git_ptxdist_work \
	rm_ptxdist_install \
	rm_ptxdist_setup_srcdir \
	rm_toolchain_download \
	rm_toolchain_extract \
	rm_create_new_git_toolchain_local \
	rm_create_new_git_toolchain_work \
	rm_toolchain_prefix \
	rm_toolchain_select \
	rm_toolchain_migrate \
	rm_toolchain_check_srcdir \
	rm_toolchain_build \
	rm_toolchain_clean_build \
	rm_bsp_download \
	rm_bsp_extract \
	rm_create_new_git_bsp_local \
	rm_create_new_git_bsp_work \
	rm_bsp_config \
	rm_bsp_compiler \
	rm_bsp_check_srcdir \
	rm_create_git_tftpboot_local \
	rm_create_co_git_tftpboot_work \
	rm_archive_barebox_env
bmk  \
	doc_download \
	ptxdist_download \
	ptxdist_extract \
	create_new_git_ptxdist_local \
	create_new_git_ptxdist_work \
	ptxdist_install \
	ptxdist_setup_srcdir \
	toolchain_download \
	toolchain_extract \
	create_new_git_toolchain_local \
	create_new_git_toolchain_work \
	toolchain_ptxdist \
	toolchain_prefix \
	toolchain_select \
	toolchain_migrate \
	toolchain_check_srcdir \
	toolchain_build \
	toolchain_clean_build \
	bsp_download \
	bsp_prepare \
	bsp_extract \
	create_new_git_bsp_local \
	create_new_git_bsp_work \
	bsp_config \
	bsp_compiler \
	bsp_check_srcdir \
	create_git_tftpboot_local \
	create_co_git_tftpboot_work \
	archive_barebox_env</pre>
Push changes in work folder to local repository
<pre>bmk  \
	rm_push_git_ptxdist_work \
	rm_push_git_toolchain_work \
	rm_push_git_bsp_work
bmk  \
	push_git_ptxdist_work \
	push_git_toolchain_work \
	push_git_bsp_work</pre>

### Build BSP for Phytec Linux - First Time
This chapter shows how to build the BSP on the host.

Build BSP with ptxdist 
<pre>bmk bsp_go</pre>
At the end you get the message: <br/>

<pre>-------------------------------------------------------------------
For a proper NFS-root environment, some device nodes are essential.
In order to create them root privileges are required.
-------------------------------------------------------------------

(Please press enter to start 'sudo' to gain root privileges.)


WARNING: NFS-root might not be working correctly!</pre>
If you missed it you can build the bsp again with:
<pre>bmk rm_bsp_go
bmk bsp_go</pre>

<pre>-------------------------------------------------------------------
For a proper NFS-root environment, some device nodes are essential.
In order to create them root privileges are required.
-------------------------------------------------------------------

(Please press enter to start 'sudo' to gain root privileges.)</pre>
Press enter.


<pre>Password: </pre>
Enter the root password. 
<pre>creating device node: platform-phyBOARD-WEGA-AM335x/root/dev/null
creating device node: platform-phyBOARD-WEGA-AM335x/root/dev/zero
creating device node: platform-phyBOARD-WEGA-AM335x/root/dev/console
creating device node: platform-phyBOARD-WEGA-AM335x/root-debug/dev/null
creating device node: platform-phyBOARD-WEGA-AM335x/root-debug/dev/zero
creating device node: platform-phyBOARD-WEGA-AM335x/root-debug/dev/console</pre>
Create images for BSP with ptxdist 
<pre>bmk bsp_images</pre>
All binaries for the target have been created now. 
### Develop BSP Phytec Linux - First Time
This chapter shows how to change the source code for some packages.


#### Call the ptxdist command directly
This describes the usage of <tt>ptxdist</tt> for developing and building the BSP:
<pre>bmk bsp_ptxdist</pre>
You can create an environment setup file for using ptxdist and git on the commandline. 
<pre>bmk setup_env_git_bsp_work</pre>
The output of this make command describes the usage of the setup-env file. Follow the instructions.

Show examples for applying patches to bsp_work. 
<pre>bmk apply_patches_git_bsp_work</pre>
The output of this make command describes the usage of git to apply patches to the BSP. Follow the instructions.
#### Development of the Kernel

##### Kernel config
Call menuconfig for kernel
<pre>bmk bsp_kernelconfig</pre>
The kernel config file is saved in the BSP. Check the changed kernel config file into the repository bsp_work. 
<pre>bmk gui_git_bsp_work</pre>

##### Kernel source
Create new repository of local repository of linux
<pre>bmk create_new_git_linux_local</pre>
Create new repository of current linux with <tt>ptxdist --git extract kernel</tt>. 

<b>Note: </b>ptxdist clean kernel will be called. The source code folder will be deleted!


<pre>bmk create_new_git_ptxdist_linux_work</pre>
Now you have a repository of the current linux which contains all the patches which have been shipped with the BSP. 

You can create an environment setup file when you want to enter some git commands on the commandline.
<pre>bmk setup_env_git_linux_work</pre>
The output of this make command describes the usage of the setup-env file. Follow the instructions.

Show examples for applying patches to linux_work. 
<pre>bmk apply_patches_git_linux_work</pre>
The output of this make command describes the usage of git to apply patches to the linux source. 

After changing the source code of the kernel, you can compile it again. The kernel is built only with one make thread. If there is an error in the source code, it is easier to find. 
<pre>bmk kernel-compile</pre>
Check the changes of the source code into the repository linux_work. You can do it with the help of a GUI. 
<pre>bmk gui_git_linux_work</pre>
Create new patches for the BSP patches folder for Linux. 
<pre>bmk create_ptx_patches_git_linux_work</pre>
Now the patches for the Linux kernel have been saved in the BSP and you may remove the kernel source. 

Clean kernel: you can remove all software parts of the kernel and force a complete rebuilt. If you have changed the source code of the kernel, you have to create the patches for it before you clean the kernel software. Otherwise all your changes are lost. 
<pre>bmk kernel-clean</pre>

#### Development of barebox

##### Barebox source
Create new repository of local repository of barebox
<pre>bmk create_new_git_barebox_local</pre>
Create new repository of current barebox with <tt>ptxdist --git extract barebox</tt>. 

<b>Note: </b>ptxdist clean barebox will be called. The source code folder will be deleted!


<pre>bmk create_new_git_ptxdist_barebox_work</pre>
Now you have a repository of the current barebox which contains all the patches which have been shipped with the BSP. 

You can create an environment setup file when you want to enter some git commands on the commandline.
<pre>bmk setup_env_git_barebox_work</pre>
The output of this make command describes the usage of the setup-env file. Follow the instructions.

Show examples for applying patches to barebox_work. 
<pre>bmk apply_patches_git_barebox_work</pre>
The output of this make command describes the usage of git to apply patches to the barebox source. 

After changing the source code of barebox, you can compile it again. 
<pre>bmk barebox-compile</pre>
Check the changes of the source code into the repository barebox_work. You can do it with the help of a GUI. 
<pre>bmk gui_git_barebox_work</pre>
Create new patches for the BSP patches folder for Barebox. 
<pre>bmk create_ptx_patches_git_barebox_work</pre>
Now the patches for barebox have been saved in the BSP and you may remove barebox source. 

Clean barebox: you can remove all software parts of barebox and force a complete rebuilt. If you have changed the source code of barebox, you have to create the patches for it before you clean barebox software. Otherwise all your changes are lost. 
<pre>bmk barebox-clean</pre>

##### After changes in tftpboot environment
Compare new env in folder tftpboot with current env
<pre>bmk compare_barebox_env</pre>
cp env into images. Copy the prepared tftpboot files into the images folder
<pre>bmk archive_barebox_env</pre>
Copy barebox config files into tftp folder. Now the files are copied into the real folder tftpboot, which is used by the tftp server. 
<pre>bmk cp_barebox_config</pre>

### Develop BSP for Phytec Linux - Again
When you want to change the source code of some packages and build the BSP again, you have to remove the make states before you can use the make targets. The additional commands are shown. 

This chapter shows how to change the source code for some packages.


#### Call the ptxdist command directly
This describes the usage of <tt>ptxdist</tt> for developing and building the BSP:
<pre>bmk bsp_ptxdist</pre>
You can create an environment setup file for using ptxdist and git on the commandline. 
<pre>bmk rm_setup_env_git_bsp_work
bmk setup_env_git_bsp_work</pre>
The output of this make command describes the usage of the setup-env file. Follow the instructions.

Show examples for applying patches to bsp_work. 
<pre>bmk apply_patches_git_bsp_work</pre>
The output of this make command describes the usage of git to apply patches to the BSP. Follow the instructions.
#### Development of the Kernel

##### Kernel config
Call menuconfig for kernel
<pre>bmk bsp_kernelconfig</pre>
The kernel config file is saved in the BSP. Check the changed kernel config file into the repository bsp_work. 
<pre>bmk gui_git_bsp_work</pre>

##### Kernel source
Create new repository of local repository of linux
<pre>bmk rm_create_new_git_linux_local
bmk create_new_git_linux_local</pre>
Create new repository of current linux with <tt>ptxdist --git extract kernel</tt>. 

<b>Note: </b>ptxdist clean kernel will be called. The source code folder will be deleted!


<pre>bmk rm_create_new_git_ptxdist_linux_work
bmk create_new_git_ptxdist_linux_work</pre>
Now you have a repository of the current linux which contains all the patches which have been shipped with the BSP. 

You can create an environment setup file when you want to enter some git commands on the commandline.
<pre>bmk rm_setup_env_git_linux_work
bmk setup_env_git_linux_work</pre>
The output of this make command describes the usage of the setup-env file. Follow the instructions.

Show examples for applying patches to linux_work. 
<pre>bmk apply_patches_git_linux_work</pre>
The output of this make command describes the usage of git to apply patches to the linux source. 

After changing the source code of the kernel, you can compile it again. The kernel is built only with one make thread. If there is an error in the source code, it is easier to find. 
<pre>bmk rm_kernel-compile
bmk kernel-compile</pre>
Check the changes of the source code into the repository linux_work. You can do it with the help of a GUI. 
<pre>bmk gui_git_linux_work</pre>
Create new patches for the BSP patches folder for Linux. 
<pre>bmk rm_create_ptx_patches_git_linux_work
bmk create_ptx_patches_git_linux_work</pre>
Now the patches for the Linux kernel have been saved in the BSP and you may remove the kernel source. 

Clean kernel: you can remove all software parts of the kernel and force a complete rebuilt. If you have changed the source code of the kernel, you have to create the patches for it before you clean the kernel software. Otherwise all your changes are lost. 
<pre>bmk rm_kernel-clean
bmk kernel-clean</pre>

#### Development of barebox

##### Barebox source
Create new repository of local repository of barebox
<pre>bmk rm_create_new_git_barebox_local
bmk create_new_git_barebox_local</pre>
Create new repository of current barebox with <tt>ptxdist --git extract barebox</tt>. 

<b>Note: </b>ptxdist clean barebox will be called. The source code folder will be deleted!


<pre>bmk rm_create_new_git_ptxdist_barebox_work
bmk create_new_git_ptxdist_barebox_work</pre>
Now you have a repository of the current barebox which contains all the patches which have been shipped with the BSP. 

You can create an environment setup file when you want to enter some git commands on the commandline.
<pre>bmk rm_setup_env_git_barebox_work
bmk setup_env_git_barebox_work</pre>
The output of this make command describes the usage of the setup-env file. Follow the instructions.

Show examples for applying patches to barebox_work. 
<pre>bmk apply_patches_git_barebox_work</pre>
The output of this make command describes the usage of git to apply patches to the barebox source. 

After changing the source code of barebox, you can compile it again. 
<pre>bmk rm_barebox-compile
bmk barebox-compile</pre>
Check the changes of the source code into the repository barebox_work. You can do it with the help of a GUI. 
<pre>bmk gui_git_barebox_work</pre>
Create new patches for the BSP patches folder for Barebox. 
<pre>bmk rm_create_ptx_patches_git_barebox_work
bmk create_ptx_patches_git_barebox_work</pre>
Now the patches for barebox have been saved in the BSP and you may remove barebox source. 

Clean barebox: you can remove all software parts of barebox and force a complete rebuilt. If you have changed the source code of barebox, you have to create the patches for it before you clean barebox software. Otherwise all your changes are lost. 
<pre>bmk rm_barebox-clean
bmk barebox-clean</pre>

##### After changes in tftpboot environment
Compare new env in folder tftpboot with current env
<pre>bmk compare_barebox_env</pre>
cp env into images. Copy the prepared tftpboot files into the images folder
<pre>bmk rm_archive_barebox_env
bmk archive_barebox_env</pre>
Copy barebox config files into tftp folder. Now the files are copied into the real folder tftpboot, which is used by the tftp server. 
<pre>bmk rm_cp_barebox_config
bmk cp_barebox_config</pre>

### Build BSP for Phytec Linux - Again
When you want to install the tools and the bsp on the host again, you have to remove the make states before you can use the make targets. The additional commands are shown. 

You have to understand what the commands are doing. Perhaps you have do remove some files or folders before you can use the make targets. 

This chapter shows how to build the BSP on the host.

Build BSP with ptxdist 
<pre>bmk rm_bsp_go
bmk bsp_go</pre>
Create images for BSP with ptxdist 
<pre>bmk rm_bsp_images
bmk bsp_images</pre>
All binaries for the target have been created now. 
### Use Binary Versions of Phytec Linux - First Time
This chapter shows how to download the binary images of the bootloader, Linux kernel and the root file system and boot the device in different ways. 
#### Create Archives of Filesystems and Install  Phytec Linux BSP on SD-Card for boot_mmc
Save barebox image, kernel image and device tree in image folder. 
<pre>bmk kernel_01</pre>
overwrite image area on SD-card with zeros , format SD-card, create binary image
<pre>bmk  parted_sdcard_01 cp_archive_sdcard_01 cp_file_sdcard_01</pre>

#### Update Bootloader in NAND
You can update the bootloader in NAND:

* by copying the images from SD-Card or 
* by downloading the images from an TFTP server. 
 
##### Use images from SD-Card
You can copy the images from an SD-card :

* after booting from the SD-Card or
* after mounting the SD-Card manually. 
 
###### Boot from SD-Card
When you boot from SD-card, the card is already mounted at /boot.<br/>
Check which devices are known
<pre>devinfo</pre>
Check which images are on the SD-card
<pre>ls /boot</pre>

<pre>MLO            barebox.bin    barebox.env    linuximage    </pre>
Update x-loader MLO
<pre>erase /dev/nand0.xload.bb
cp /boot/MLO /dev/nand0.xload.bb</pre>
Update barebox
<pre>erase /dev/nand0.barebox.bb
cp /boot/barebox.bin /dev/nand0.barebox.bb</pre>
When the bootloader has changed significantly, it is also necessary to erase the barebox environment:
<pre>erase /dev/nand0.bareboxenv</pre>

###### Mount SD-Card
Further information is available in L-775e_3.pdf on page 22. <br/>
Insert SD-Card and mount it. <br/>
Check which devices are known
<pre>devinfo</pre>
Mount the SD-card, if it is not already mounted:
<pre>mci0.probe=1
ls /mnt
mkdir /mnt/disk
mount /dev/disk0.0 /mnt/disk</pre>
Check which images are on the SD-card
<pre>ls /mnt/disk</pre>

<pre>MLO            barebox.bin    linuximage    </pre>
Update x-loader MLO
<pre>erase /dev/nand0.xload.bb
cp /mnt/disk/MLO /dev/nand0.xload.bb</pre>
Update barebox
<pre>erase /dev/nand0.barebox.bb
cp /mnt/disk/barebox.bin /dev/nand0.barebox.bb</pre>
When the bootloader has changed significantly, it is also necessary to erase the barebox environment:
<pre>erase /dev/nand0.bareboxenv</pre>

##### Download images from TFTP Server
Copy barebox image of boot_nand into images folder
<pre>bmk cp_barebox_boot_nand</pre>
Copy barebox from images folder into tftp folder
<pre>bmk tftpboot_barebox</pre>
Update barebox via TFTP
<pre>bmk update_barebox</pre>

#### Boot via NAND
copy kernel image for boot_tftp_nfs and boot_nand into images folder
<pre>bmk kernel_boot_tftp_nfs</pre>
Copy kernel into tftp folder
<pre>bmk tftpboot_kernel</pre>
Copy the ubi image of boot_nand
<pre>bmk cp_image_boot_nand</pre>
Copy root.ubi into tftp folder
<pre>bmk tftpboot_root_ubi</pre>
Update kernel and root on target for boot_nand
<pre>bmk update_target_boot_nand</pre>

#### Boot via TFTP and NFS

##### Prepare tftp config
cp env into images. Copy the prepared tftpboot files into the images folder
<pre>bmk archive_barebox_env</pre>
Barebox config files are copied into the real folder tftpboot, which is used by the tftp server. Do it only once. Default settings are to boot from NAND. 
<pre>bmk cp_barebox_config</pre>
Because the config files contain dummy ip addresses, it is important to set the correct ip addresses.
<pre>bmk set_ip_barebox_config</pre>

##### Copy init files to the Target 
Copy <tt>env/boot/net-02</tt> and some other files to the target.
<pre>bmk cp_init_board</pre>
The output of this make command describes how to download files to the target. Follow the instructions.

When barebox is restarted, <tt>/env/network/eth0</tt> is used to configure the Ethernet port. When you call 
<pre>boot net-02</pre>
 you can boot the board via TFTP and NFS. The file <tt>/env/boot/net-02</tt> is executed and loads the file <tt>/env/bin/net-03</tt> from the TFTP server. This file is also executed. 

<b>Note: </b>It is very important that you copy the init files to the target. Some commands in the makefile are changing the config file in the tftpboot folder on the host.


##### Setup barebox config to boot via tftp and nfs 
Adjust boot.default in env/config to boot from TFTP and NFS
<pre>bmk tftpboot_config_loc_boot_tftp_nfs</pre>

##### Prepare kernel and rootfs for boot via TFTP and NFS 
Build BSP with ptxdist 
<pre>bmk bsp_go</pre>
Create images for BSP with ptxdist 
<pre>bmk bsp_images</pre>
copy kernel image for boot_tftp_nfs into images folder
<pre>bmk kernel_boot_tftp_nfs</pre>
Copy kernel from images into tftp folder
<pre>bmk tftpboot_kernel</pre>
Copy RootFS Archive of boot_tftp_nfs into images
<pre>bmk cp_image_boot_tftp_nfs</pre>
Create root file system, which can be mounted via NFS. 
<pre>bmk create_rootfs_boot_tftp_nfs</pre>
Setup NFS, add rootfs to /etc/exports
<pre>bmk export_rootfs</pre>
exportfs -r
<pre>bmk export_refresh</pre>
remove fingerprint in .ssh/known_hosts
<pre>bmk ssh_fingerprint</pre>
Adjust nfsroot in env/config
<pre>bmk tftpboot_config</pre>
show command for netconsole
<pre>bmk netconsole</pre>

##### Switching between booting from NAND and via TFTP and NFS
You have just configured the board to boot via TFTP and NFS. If you want to switch back to booting from NAND, you can use the following command. 

Adjust boot.default in env/config to boot from NAND
<pre>bmk tftpboot_config_loc_boot_nand</pre>
If you want to switch again to booting via TFTP and NFS, you can use again the following command. 

Adjust boot.default in env/config to boot from TFTP and NFS
<pre>bmk rm_tftpboot_config_loc_boot_tftp_nfs
bmk tftpboot_config_loc_boot_tftp_nfs</pre>

#### Boot the board
Check if you have the correct hardware versions:

* phyBOARD-WEGA-AM335x with carrier board 1405.0 or 1405.1
* HDMI Adapter PEB-AV-01 1406.0 or 1406.1
* Eval Module PEB-EVAL-01 1413.0 or 1413.1
 

By default the board tries to boot from NAND at first. Without any valid bootloader in NAND, the board will try to boot from SD-card next.

You can force the board to try to boot from SD-card at first. This allows you to test the bootloader on the SD-card without changing anything in NAND.

If you have the carrier board 1405.0:<br/>
You can force the board to boot from SD-card by connecting X_LCD_D2 (pin 8 at X70) to a high-level (e.g. VCC3V3 – pin13 at X71) during the power-up sequence.

If you have the carrier board 1405.1: <br/>
Take off the expansion board PEB-AV-01 or PEB-AV-02. Move the DIP switch to ON, to force booting from SD-card. When you have moved the switch in direction of the SD-card slot, the switch is in position ON. 

The description how to boot from SD-card can be found in L-792e_0.pdf on page 77 and in http://www.phytec.de/de/support/faq/faq-phyboard-wega.html. 

Connect the board to the host, network and display: 

* Connect a serial cable (one-to-one) to the DB9 connector on PEB-EVAL-01. Set the speed to 115200 8N1 in your terminal application on the host. 
* Connect an ethernet cable to the port X16 on the carrier board. This is the ethernet port next to the USB port. 
* If you want to work with an SD-card, insert the SD-card into carrier board. 
* You can connect also a display to the HDMI port on PEB-AV-01. 
 

Boot the board again. 
#### Summary
Create images for SD-card
<pre>bmk  \
	kernel_01 \
	parted_sdcard_01 \
	cp_archive_sdcard_01 \
	cp_file_sdcard_01</pre>
update barebox, kernel and root file system in NAND
<pre>bmk  \
	cp_barebox_boot_nand \
	tftpboot_barebox \
	update_barebox \
	cp_image_boot_nand \
	tftpboot_root_ubi \
	kernel_boot_tftp_nfs \
	tftpboot_kernel \
	update_target_boot_nand</pre>
update kernel and root file system in NAND
<pre>bmk  \
	cp_image_boot_nand \
	tftpboot_root_ubi \
	kernel_boot_tftp_nfs \
	tftpboot_kernel \
	update_target_boot_nand</pre>
Prepare tftp config for boot via tftp and nfs
<pre>bmk  \
	archive_barebox_env \
	cp_barebox_config \
	set_ip_barebox_config \
	cp_init_board \
	tftpboot_config_loc_boot_tftp_nfs</pre>
Prepare kernel and rootfs for boot via TFTP and NFS 
<pre>bmk  \
	bsp_go \
	bsp_images \
	kernel_boot_tftp_nfs \
	cp_image_boot_tftp_nfs \
	tftpboot_kernel \
	create_rootfs_boot_tftp_nfs \
	export_rootfs \
	export_refresh \
	ssh_fingerprint \
	tftpboot_config \
	netconsole</pre>
Switch back to boot from NAND. Adjust boot.default in env/config to boot from NAND
<pre>bmk  \
	tftpboot_config_loc_boot_nand</pre>
Switch again to boot via TFTP and NFS. Adjust boot.default in env/config to boot from TFTP and NFS
<pre>bmk  \
	rm_tftpboot_config_loc_boot_tftp_nfs
bmk  \
	tftpboot_config_loc_boot_tftp_nfs</pre>

### Use Binary Versions of Phytec Linux - Again
When you want to install the binary images in the internal flash again, you have to remove the make states before you can use the make targets. The additional commands are shown. 

This chapter shows how to download the binary images of the bootloader, Linux kernel and the root file system and boot the device in different ways. 
#### Create Archives of Filesystems and Install  Phytec Linux BSP on SD-Card for boot_mmc
Build Phytec Linux BSP, if you have not already done it.Build BSP with ptxdist 
<pre>bmk rm_bsp_go
bmk bsp_go</pre>
Create images for BSP with ptxdist 
<pre>bmk rm_bsp_images
bmk bsp_images</pre>
Save barebox image, kernel image and device tree in image folder. 

<b>Note: </b>You only have to do this again, when the image has been rebuilt. 


<pre>bmk rm_kernel_01 rm_kernel_boot_tftp_nfs rm_cp_image_boot_tftp_nfs
bmk kernel_01</pre>
overwrite image area on SD-card with zeros , format SD-card, create binary image
<pre>bmk  rm_parted_sdcard_01
bmk  parted_sdcard_01 cp_archive_sdcard_01 cp_file_sdcard_01</pre>

#### Update Bootloader in NAND
You can update the bootloader in NAND:

* by copying the images from SD-Card or 
* by downloading the images from an TFTP server. 
 
##### Use images from SD-Card
You can copy the images from an SD-card :

* after booting from the SD-Card or
* after mounting the SD-Card manually. 
 
###### Boot from SD-Card
When you boot from SD-card, the card is already mounted at /boot.<br/>
Check which devices are known
<pre>devinfo</pre>
Check which images are on the SD-card
<pre>ls /boot</pre>

<pre>MLO            barebox.bin    barebox.env    linuximage    </pre>
Update x-loader MLO
<pre>erase /dev/nand0.xload.bb
cp /boot/MLO /dev/nand0.xload.bb</pre>
Update barebox
<pre>erase /dev/nand0.barebox.bb
cp /boot/barebox.bin /dev/nand0.barebox.bb</pre>
When the bootloader has changed significantly, it is also necessary to erase the barebox environment:
<pre>erase /dev/nand0.bareboxenv</pre>

###### Mount SD-Card
Further information is available in L-775e_3.pdf on page 22. <br/>
Insert SD-Card and mount it. <br/>
Check which devices are known
<pre>devinfo</pre>
Mount the SD-card, if it is not already mounted:
<pre>mci0.probe=1
ls /mnt
mkdir /mnt/disk
mount /dev/disk0.0 /mnt/disk</pre>
Check which images are on the SD-card
<pre>ls /mnt/disk</pre>

<pre>MLO            barebox.bin    linuximage    </pre>
Update x-loader MLO
<pre>erase /dev/nand0.xload.bb
cp /mnt/disk/MLO /dev/nand0.xload.bb</pre>
Update barebox
<pre>erase /dev/nand0.barebox.bb
cp /mnt/disk/barebox.bin /dev/nand0.barebox.bb</pre>
When the bootloader has changed significantly, it is also necessary to erase the barebox environment:
<pre>erase /dev/nand0.bareboxenv</pre>

##### Download images from TFTP Server
Copy barebox image of boot_nand into images folder
<pre>bmk rm_cp_barebox_boot_nand
bmk cp_barebox_boot_nand</pre>
Copy barebox from images folder into tftp folder
<pre>bmk rm_tftpboot_barebox
bmk tftpboot_barebox</pre>
Update barebox via TFTP
<pre>bmk rm_update_barebox
bmk update_barebox</pre>

#### Boot via NAND
copy kernel image for boot_tftp_nfs and boot_nand into images folder
<pre>bmk rm_kernel_boot_tftp_nfs
bmk kernel_boot_tftp_nfs</pre>
Copy kernel into tftp folder
<pre>bmk rm_tftpboot_kernel
bmk tftpboot_kernel</pre>
Copy the ubi image of boot_nand
<pre>bmk rm_cp_image_boot_nand
bmk cp_image_boot_nand</pre>
Copy root.ubi into tftp folder
<pre>bmk rm_tftpboot_root_ubi
bmk tftpboot_root_ubi</pre>
Update kernel and root on target for boot_nand
<pre>bmk update_target_boot_nand</pre>

#### Boot via TFTP and NFS

##### Copy init files to the Target 
Copy <tt>env/boot/net-02</tt> and some other files to the target.
<pre>bmk rm_cp_init_board
bmk cp_init_board</pre>
The output of this make command describes how to download files to the target. Follow the instructions.

When barebox is restarted, <tt>/env/network/eth0</tt> is used to configure the Ethernet port. When you call 
<pre>boot net-02</pre>
 you can boot the board via TFTP and NFS. The file <tt>/env/boot/net-02</tt> is executed and loads the file <tt>/env/bin/net-03</tt> from the TFTP server. This file is also executed. 

<b>Note: </b>It is very important that you copy the init files to the target. Some commands in the makefile are changing the config file in the tftpboot folder on the host.


##### Setup barebox config to boot via tftp and nfs 
Adjust boot.default in env/config to boot from TFTP and NFS
<pre>bmk rm_tftpboot_config_loc_boot_tftp_nfs
bmk tftpboot_config_loc_boot_tftp_nfs</pre>

##### Prepare kernel and rootfs for boot via TFTP and NFS 
Build BSP with ptxdist 
<pre>bmk rm_bsp_go
bmk bsp_go</pre>
Create images for BSP with ptxdist 
<pre>bmk rm_bsp_images
bmk bsp_images</pre>
copy kernel image for boot_tftp_nfs into images folder
<pre>bmk rm_kernel_boot_tftp_nfs
bmk kernel_boot_tftp_nfs</pre>
Copy kernel from images into tftp folder
<pre>bmk rm_tftpboot_kernel
bmk tftpboot_kernel</pre>
Copy RootFS Archive of boot_tftp_nfs into images
<pre>bmk rm_cp_image_boot_tftp_nfs
bmk cp_image_boot_tftp_nfs</pre>
Remove root file system, which can be mounted via NFS. 
<pre>bmk rm_remove_rootfs_boot_tftp_nfs
bmk remove_rootfs_boot_tftp_nfs -n
bmk remove_rootfs_boot_tftp_nfs</pre>
Create root file system, which can be mounted via NFS. 
<pre>bmk rm_create_rootfs_boot_tftp_nfs
bmk create_rootfs_boot_tftp_nfs</pre>
exportfs -r
<pre>bmk export_refresh</pre>
remove fingerprint in .ssh/known_hosts
<pre>bmk rm_ssh_fingerprint
bmk ssh_fingerprint</pre>
show command for netconsole
<pre>bmk rm_netconsole
bmk netconsole</pre>

##### Switching between booting from NAND and via TFTP and NFS
You have just configured the board to boot via TFTP and NFS. If you want to switch back to booting from NAND, you can use the following command. 

Adjust boot.default in env/config to boot from NAND
<pre>bmk rm_tftpboot_config_loc_boot_nand
bmk tftpboot_config_loc_boot_nand</pre>
If you want to switch again to booting via TFTP and NFS, you can use again the following command. 

Adjust boot.default in env/config to boot from TFTP and NFS
<pre>bmk rm_tftpboot_config_loc_boot_tftp_nfs
bmk tftpboot_config_loc_boot_tftp_nfs</pre>

#### Boot the board
Check if you have the correct hardware versions:

* phyBOARD-WEGA-AM335x with carrier board 1405.0 or 1405.1
* HDMI Adapter PEB-AV-01 1406.0 or 1406.1
* Eval Module PEB-EVAL-01 1413.0 or 1413.1
 

By default the board tries to boot from NAND at first. Without any valid bootloader in NAND, the board will try to boot from SD-card next.

You can force the board to try to boot from SD-card at first. This allows you to test the bootloader on the SD-card without changing anything in NAND.

If you have the carrier board 1405.0:<br/>
You can force the board to boot from SD-card by connecting X_LCD_D2 (pin 8 at X70) to a high-level (e.g. VCC3V3 – pin13 at X71) during the power-up sequence.

If you have the carrier board 1405.1: <br/>
Take off the expansion board PEB-AV-01 or PEB-AV-02. Move the DIP switch to ON, to force booting from SD-card. When you have moved the switch in direction of the SD-card slot, the switch is in position ON. 

The description how to boot from SD-card can be found in L-792e_0.pdf on page 77 and in http://www.phytec.de/de/support/faq/faq-phyboard-wega.html. 

Connect the board to the host, network and display: 

* Connect a serial cable (one-to-one) to the DB9 connector on PEB-EVAL-01. Set the speed to 115200 8N1 in your terminal application on the host. 
* Connect an ethernet cable to the port X16 on the carrier board. This is the ethernet port next to the USB port. 
* If you want to work with an SD-card, insert the SD-card into carrier board. 
* You can connect also a display to the HDMI port on PEB-AV-01. 
 

Boot the board again. 
#### Summary
Create images for SD-card
<pre>bmk  \
	rm_bsp_go \
	rm_bsp_images \
	rm_kernel_01 \
	rm_kernel_boot_tftp_nfs \
	rm_cp_image_boot_tftp_nfs
bmk  \
	bsp_go \
	bsp_images \
	kernel_01</pre>

<pre>bmk  \
	rm_parted_sdcard_01
bmk  \
	parted_sdcard_01 \
	cp_archive_sdcard_01 \
	cp_file_sdcard_01</pre>
update barebox, kernel and root file system in NAND
<pre>bmk  \
	rm_cp_barebox_boot_nand \
	rm_tftpboot_barebox \
	rm_update_barebox \
	rm_cp_image_boot_nand \
	rm_tftpboot_root_ubi \
	rm_kernel_boot_tftp_nfs \
	rm_tftpboot_kernel
bmk  \
	cp_barebox_boot_nand \
	tftpboot_barebox \
	update_barebox \
	cp_image_boot_nand \
	tftpboot_root_ubi \
	kernel_boot_tftp_nfs \
	tftpboot_kernel \
	update_target_boot_nand</pre>
update kernel and root file system in NAND
<pre>bmk  \
	rm_cp_image_boot_nand \
	rm_tftpboot_root_ubi \
	rm_kernel_boot_tftp_nfs \
	rm_tftpboot_kernel
bmk  \
	cp_image_boot_nand \
	tftpboot_root_ubi \
	kernel_boot_tftp_nfs \
	tftpboot_kernel \
	update_target_boot_nand</pre>
Prepare tftp config for boot via tftp and nfs
<pre>bmk  \
	rm_set_ip_barebox_config \
	rm_cp_init_board \
	rm_tftpboot_config_loc_boot_tftp_nfs
bmk  \
	set_ip_barebox_config \
	cp_init_board \
	tftpboot_config_loc_boot_tftp_nfs</pre>
Prepare kernel and rootfs for boot via TFTP and NFS 
<pre>bmk  \
	rm_bsp_go \
	rm_bsp_images \
	rm_kernel_boot_tftp_nfs \
	rm_cp_image_boot_tftp_nfs \
	rm_tftpboot_kernel \
	rm_remove_rootfs_boot_tftp_nfs \
	rm_create_rootfs_boot_tftp_nfs \
	rm_ssh_fingerprint
bmk  \
	bsp_go \
	bsp_images \
	kernel_boot_tftp_nfs \
	cp_image_boot_tftp_nfs \
	tftpboot_kernel \
	remove_rootfs_boot_tftp_nfs \
	create_rootfs_boot_tftp_nfs \
	export_refresh \
	ssh_fingerprint \
	netconsole</pre>
Switch back to boot from NAND. Adjust boot.default in env/config to boot from NAND
<pre>bmk  \
	rm_tftpboot_config_loc_boot_nand
bmk  \
	tftpboot_config_loc_boot_nand</pre>
Switch again to boot via TFTP and NFS. Adjust boot.default in env/config to boot from TFTP and NFS
<pre>bmk  \
	rm_tftpboot_config_loc_boot_tftp_nfs
bmk  \
	tftpboot_config_loc_boot_tftp_nfs</pre>
This is usually used only once, but may be reused: Copy barebox config files into tftp folder and adjust all the settings to boot via TFTP and NFS.
<pre>bmk  \
	rm_cp_barebox_config \
	rm_set_ip_barebox_config \
	rm_tftpboot_config \
	rm_tftpboot_config_loc_boot_tftp_nfs
bmk  \
	cp_barebox_config \
	set_ip_barebox_config \
	tftpboot_config \
	tftpboot_config_loc_boot_tftp_nfs</pre>
This is usually used only once, but may be reused: Adjust nfsroot in env/config
<pre>bmk  \
	rm_tftpboot_config
bmk  \
	tftpboot_config</pre>
This is usually used only once, but may be reused: Setup NFS, add rootfs to /etc/exports
<pre>bmk  \
	rm_export_rootfs
bmk  \
	export_rootfs</pre>

## Test or Debug
Remove fingerprint in .ssh/known_hosts
<pre>bmk rm_ssh_fingerprint
bmk ssh_fingerprint</pre>
show command for netconsole
<pre>bmk netconsole</pre>
dmesg over ssh
<pre>bmk ssh_dmesg</pre>

## Version Control with Git
Create and manage git repositories for the source code of the BSP and its software packages. 

If you want to learn more about git, there is a book on git : [http://www.git-scm.com/book Pro Git]

There are many more make targets in the makefile <tt>${DISTRIB_IN}/install/scripts/pd_src_git.mk</tt> which have not been described so far. You can list most of the make targets with the following command:
<pre>bmk | grep git</pre>
You can look at the contents of the file <tt>${DISTRIB_IN}/install/scripts/pd_src_git.mk</tt>
<pre>more ${DISTRIB_IN}/install/scripts/pd_src_git.mk</pre>
In this tutorial and the accompanying makefile some specific names are used for the repositories:

* A repository is called <i>work</i>, when it is used to checkout and edit the current version of the source code. 
* A repository is called <i>local</i>, when it is used to save the current state of the source code on your computer. You push your changes from the <i>work</i> repository to the <i>local</i> repository, to save it there. This is a bare repository. 
* A <i>remote</i> repository is used to create or update the <i>local</i> repository. Usually you don't have write access to the <i>remote</i> repository. 
 In the following chapters some useful commands are shown.
### Create environment setup files
For the work with repositories of some source code folders you need to define an environment.

Create environment setup file for barebox_work
<pre>bmk rm_setup_env_git_barebox_work
bmk setup_env_git_barebox_work</pre>
The output of this make command describes the usage of the setup-env file. Follow the instructions.

Create environment setup file for linux_work
<pre>bmk rm_setup_env_git_linux_work
bmk setup_env_git_linux_work</pre>
The output of this make command describes the usage of the setup-env file. Follow the instructions.

Create environment setup file for gcc-linaro_work
<pre>bmk rm_setup_env_git_gcc-linaro_work
bmk setup_env_git_gcc-linaro_work</pre>
The output of this make command describes the usage of the setup-env file. Follow the instructions.


### Start Tools with GUI for Repositories
Start tools with GUI like <tt>git gui</tt> and <tt>gitk</tt>. 

start git gui or gitk  for bsp_local
<pre>bmk gui_git_bsp_local</pre>
start git gui or gitk  for bsp_work
<pre>bmk gui_git_bsp_work</pre>
start git gui or gitk  for ptxdist_local
<pre>bmk gui_git_ptxdist_local</pre>
start git gui or gitk  for ptxdist_work
<pre>bmk gui_git_ptxdist_work</pre>
start git gui or gitk  for barebox_local
<pre>bmk gui_git_barebox_local</pre>
start git gui or gitk  for barebox_work
<pre>bmk gui_git_barebox_work</pre>
start git gui or gitk  for linux_local
<pre>bmk gui_git_linux_local</pre>
start git gui or gitk  for linux_work
<pre>bmk gui_git_linux_work</pre>
start git gui or gitk  for toolchain_local
<pre>bmk gui_git_toolchain_local</pre>
start git gui or gitk  for toolchain_work
<pre>bmk gui_git_toolchain_work</pre>
start git gui or gitk  for gcc-linaro_local
<pre>bmk gui_git_gcc-linaro_local</pre>
start git gui or gitk  for gcc-linaro_work
<pre>bmk gui_git_gcc-linaro_work</pre>
start git gui or gitk  for tftpboot_local
<pre>bmk gui_git_tftpboot_local</pre>
start git gui or gitk  for tftpboot_work
<pre>bmk gui_git_tftpboot_work</pre>

### Show and Check Repositories
Show and check current state of the git repositories.  

show branches and HEAD of all repositories
<pre>bmk show_branch_git</pre>
check branch and HEAD of all repositories
<pre>bmk check_branch_git</pre>
show commit id of release branch
<pre>bmk show_release_git</pre>

### Summary
Create environment setup files
<pre>bmk  \
	rm_setup_env_git_barebox_work \
	rm_setup_env_git_linux_work \
	rm_setup_env_git_gcc-linaro_work
bmk  \
	setup_env_git_barebox_work \
	setup_env_git_linux_work \
	setup_env_git_gcc-linaro_work</pre>
Show and check current state of the git repositories.
<pre>bmk  \
	show_branch_git \
	check_branch_git \
	show_release_git</pre>
