# 
# Copyright (c) 2013, 2014 Kobler Systems GmbH
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of 
# 
# this software and 
# associated documentation files (the "Software"), 
# 
# to deal in the Software without restriction, 
# including without limitation the rights to use, copy, modify, merge, publish, distribute, 
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software 
# is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all 
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# Author: Jan Kobler, Kobler Systems GmbH, email: eng1@koblersystems.de
#


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
#################################################

MY_PD:=$(MY_DEVELOP)/PD
BSP_DIR:=$(MY_PD)/phyBOARD-WEGA-AM335x-PD13.0.0


# project folder contains makefile and state folder
MY_PROJECT:=$(MY_DEVELOP)/project/phyBOARD-WEGA-$(MY_VERSION)

# state of the make target is saved here
STATE_DIR:=$(MY_PROJECT)/state

IMAGE_VERSION:=$(MY_VERSION)
PTX_VERSION:=2013.01.0

PTX_DIR:=$(MY_PD)/ptxdist-$(PTX_VERSION)

# This is the PTXDIST_PTXRC file of ptxdist
PTX_PTXRC:=$${HOME}/.ptxdist/ptxdistrc-2013.01

MY_IMAGES:=$(MY_DEVELOP)/images/phyBOARD-WEGA-$(IMAGE_VERSION)

DISTRIB_OUT:=$(MY_DEVELOP)/distrib/$(MY_VERSION)

PTX_ARCHIVE:=ptxdist-Phytec-phyBOARD-WEGA-AM335x-$(MY_VERSION)
BSP_ARCHIVE:=PD.BSP-Phytec-phyBOARD-WEGA-AM335x-$(MY_VERSION)
TOOLCHAIN_ARCHIVE:=OSELAS.Toolchain-Phytec-phyBOARD-WEGA-AM335x-$(MY_VERSION)

PTXDIST:=$(MY_PD)/tools/bin/ptxdist-$(PTX_VERSION)

# Server with files and bundles for this tutorial
TUTORIAL_SERVER1:=http://www.koblersystems.de/bsp-doc

# Current version of the scripts 
SCRIPT_VERSION:=1


#################################################
# makefiles are loaded 
# don't change the code below this line
#################################################

include $(MY_SCRIPTS)/pd_src_start.mk
include $(MY_SCRIPTS)/pd_src_git.mk
include $(MY_SCRIPTS)/pd_src_build.mk
include $(MY_SCRIPTS)/pd_src_end.mk
