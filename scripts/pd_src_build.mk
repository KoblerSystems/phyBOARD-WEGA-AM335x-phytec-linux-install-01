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


##############################
# check PTXCONF_SETUP_SRCDIR in ptxdistrc for bsp
##############################

bsp_check_srcdir: 
	@cd  $(BSP_DIR)&&\
	PTXCONF_SETUP_SRCDIR=$$($(PTXDIST) print PTXCONF_SETUP_SRCDIR) &&\
	PTXDIST_PTXRC=$$($(PTXDIST) print PTXDIST_PTXRC) &&\
	if [ "$${PTXDIST_PTXRC}" != "$(PTX_PTXRC)" ]; then \
		echo "Wrong value for PTX_PTXRC  in makefile use '$${PTXDIST_PTXRC}'"; \
		exit -1;\
	else \
		echo "ptxdist settings are in '$${PTXDIST_PTXRC}'";\
	fi;\
	if [ "$${PTXCONF_SETUP_SRCDIR}" != "$(MY_DOWNLOAD_SRC)" ]; then \
		echo "Wrong value for PTXCONF_SETUP_SRCDIR '$${PTXCONF_SETUP_SRCDIR}' instead of MY_DOWNLOAD_SRC:=/MyDevelop/distfiles";\
		echo "Use make target ptxdist_setup_srcdir to change it"; \
		exit -1;\
	else \
		echo "Source archives are downloaded to '$${PTXCONF_SETUP_SRCDIR}'"; \
	fi;

.PHONY : bsp_check_srcdir

info_target_bsp_check_srcdir : 
	@echo "bsp_check_srcdir:	 check PTXCONF_SETUP_SRCDIR in ptxdistrc for bsp"

INFO_TARGET_LIST += info_target_bsp_check_srcdir


##############################
# Build BSP with ptxdist 
##############################

$(STATE_DIR)/bsp_go: 
	cd $(BSP_DIR) && \
	$(PTXDIST) go
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : bsp_go

bsp_go: $(STATE_DIR)/bsp_go

rm_bsp_go: 
	if [ -e $(STATE_DIR)/bsp_go ]; then rm $(STATE_DIR)/bsp_go; fi

CLEAN_STATE_LIST += rm_bsp_go

info_target_bsp_go : 
	@echo "bsp_go:	 Build BSP with ptxdist "

INFO_TARGET_LIST += info_target_bsp_go


##############################
# Create images for BSP with ptxdist 
##############################

$(STATE_DIR)/bsp_images: 
	cd $(BSP_DIR) && \
	$(PTXDIST) images
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : bsp_images

bsp_images: $(STATE_DIR)/bsp_images

rm_bsp_images: 
	if [ -e $(STATE_DIR)/bsp_images ]; then rm $(STATE_DIR)/bsp_images; fi

CLEAN_STATE_LIST += rm_bsp_images

info_target_bsp_images : 
	@echo "bsp_images:	 Create images for BSP with ptxdist "

INFO_TARGET_LIST += info_target_bsp_images


##############################
# Create root file system, which can be mounted via NFS. 
##############################

$(STATE_DIR)/create_rootfs_boot_tftp_nfs: 
	mkdir -p $(MY_DEVELOP)/rootfs/phyBOARD-WEGA-$(MY_VERSION)
	cd $(MY_DEVELOP)/rootfs/phyBOARD-WEGA-$(MY_VERSION) && \
	sudo tar xzf $(MY_IMAGES)/boot_tftp_nfs/root-phyBOARD-WEGA.tar.gz
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_rootfs_boot_tftp_nfs

create_rootfs_boot_tftp_nfs: $(STATE_DIR)/create_rootfs_boot_tftp_nfs

rm_create_rootfs_boot_tftp_nfs: 
	if [ -e $(STATE_DIR)/create_rootfs_boot_tftp_nfs ]; then rm $(STATE_DIR)/create_rootfs_boot_tftp_nfs; fi

CLEAN_STATE_LIST += rm_create_rootfs_boot_tftp_nfs

info_target_create_rootfs_boot_tftp_nfs : 
	@echo "create_rootfs_boot_tftp_nfs:	 Create root file system, which can be mounted via NFS. "

INFO_TARGET_LIST += info_target_create_rootfs_boot_tftp_nfs


##############################
# remove rootfs. Create root file system, which can be mounted via NFS. 
##############################

$(STATE_DIR)/remove_rootfs_boot_tftp_nfs: rm_create_rootfs_boot_tftp_nfs
	sudo rm -rf $(MY_DEVELOP)/rootfs/phyBOARD-WEGA-$(MY_VERSION)/
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : remove_rootfs_boot_tftp_nfs

remove_rootfs_boot_tftp_nfs: $(STATE_DIR)/remove_rootfs_boot_tftp_nfs

rm_remove_rootfs_boot_tftp_nfs: 
	if [ -e $(STATE_DIR)/remove_rootfs_boot_tftp_nfs ]; then rm $(STATE_DIR)/remove_rootfs_boot_tftp_nfs; fi

CLEAN_STATE_LIST += rm_remove_rootfs_boot_tftp_nfs

info_target_remove_rootfs_boot_tftp_nfs : 
	@echo "remove_rootfs_boot_tftp_nfs:	 remove rootfs. Create root file system, which can be mounted via NFS. "

INFO_TARGET_LIST += info_target_remove_rootfs_boot_tftp_nfs


##############################
# Copy RootFS Archive of boot_tftp_nfs
##############################

$(STATE_DIR)/cp_image_boot_tftp_nfs: 
	mkdir -p $(MY_IMAGES)/boot_tftp_nfs
	cp $(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/images/root.tgz $(MY_IMAGES)/boot_tftp_nfs/root-phyBOARD-WEGA.tar.gz
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : cp_image_boot_tftp_nfs

cp_image_boot_tftp_nfs: $(STATE_DIR)/cp_image_boot_tftp_nfs

rm_cp_image_boot_tftp_nfs: 
	if [ -e $(STATE_DIR)/cp_image_boot_tftp_nfs ]; then rm $(STATE_DIR)/cp_image_boot_tftp_nfs; fi

CLEAN_STATE_LIST += rm_cp_image_boot_tftp_nfs

info_target_cp_image_boot_tftp_nfs : 
	@echo "cp_image_boot_tftp_nfs:	 Copy RootFS Archive of boot_tftp_nfs"

INFO_TARGET_LIST += info_target_cp_image_boot_tftp_nfs


##############################
# Setup NFS, add rootfs to /etc/exports
##############################

$(STATE_DIR)/export_rootfs: 
	if grep -q "$(MY_DEVELOP)/rootfs/phyBOARD-WEGA-$(MY_VERSION)" /etc/exports ; then  \
		true; \
	else \
		sudo sed -i '$$ a\$(MY_DEVELOP)/rootfs/phyBOARD-WEGA-$(MY_VERSION)  $(IP_NFS_CLIENT)(rw,no_root_squash,async,subtree_check)\' /etc/exports; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : export_rootfs

export_rootfs: $(STATE_DIR)/export_rootfs

rm_export_rootfs: 
	if [ -e $(STATE_DIR)/export_rootfs ]; then rm $(STATE_DIR)/export_rootfs; fi

CLEAN_STATE_LIST += rm_export_rootfs

info_target_export_rootfs : 
	@echo "export_rootfs:	 Setup NFS, add rootfs to /etc/exports"

INFO_TARGET_LIST += info_target_export_rootfs


##############################
# exportfs -r
##############################

export_refresh: 
	sudo exportfs -r

.PHONY : export_refresh

info_target_export_refresh : 
	@echo "export_refresh:	 exportfs -r"

INFO_TARGET_LIST += info_target_export_refresh


##############################
# copy kernel image for boot_tftp_nfs into images folder
##############################

$(STATE_DIR)/kernel_boot_tftp_nfs: 
	mkdir -p $(MY_IMAGES)/boot_tftp_nfs/
	cp $(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/images/linuximage $(MY_IMAGES)/boot_tftp_nfs/uImage-phyBOARD-WEGA
	cp $(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/images/barebox-image $(MY_IMAGES)/boot_tftp_nfs/barebox-phyBOARD-WEGA.img
	cp $(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/images/MLO $(MY_IMAGES)/boot_tftp_nfs/MLO-phyBOARD-WEGA.img
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : kernel_boot_tftp_nfs

kernel_boot_tftp_nfs: $(STATE_DIR)/kernel_boot_tftp_nfs

rm_kernel_boot_tftp_nfs: 
	if [ -e $(STATE_DIR)/kernel_boot_tftp_nfs ]; then rm $(STATE_DIR)/kernel_boot_tftp_nfs; fi

CLEAN_STATE_LIST += rm_kernel_boot_tftp_nfs

info_target_kernel_boot_tftp_nfs : 
	@echo "kernel_boot_tftp_nfs:	 copy kernel image for boot_tftp_nfs into images folder"

INFO_TARGET_LIST += info_target_kernel_boot_tftp_nfs


##############################
# prepare kernel image for boot_mmc
##############################

$(STATE_DIR)/kernel_01: kernel_boot_tftp_nfs \
    cp_image_boot_tftp_nfs
	mkdir -p $(MY_IMAGES)/boot_mmc
	ln -sf ../boot_tftp_nfs/uImage-phyBOARD-WEGA $(MY_IMAGES)/boot_mmc/uImage-phyBOARD-WEGA
	ln -sf ../boot_tftp_nfs/barebox-phyBOARD-WEGA.img $(MY_IMAGES)/boot_mmc/barebox-phyBOARD-WEGA.img
	ln -sf ../boot_tftp_nfs/MLO-phyBOARD-WEGA.img $(MY_IMAGES)/boot_mmc/MLO-phyBOARD-WEGA.img
	ln -sf ../boot_tftp_nfs/root-phyBOARD-WEGA.tar.gz $(MY_IMAGES)/boot_mmc/root-phyBOARD-WEGA.tar.gz
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : kernel_01

kernel_01: $(STATE_DIR)/kernel_01

rm_kernel_01: 
	if [ -e $(STATE_DIR)/kernel_01 ]; then rm $(STATE_DIR)/kernel_01; fi

CLEAN_STATE_LIST += rm_kernel_01

info_target_kernel_01 : 
	@echo "kernel_01:	 prepare kernel image for boot_mmc"

INFO_TARGET_LIST += info_target_kernel_01


##############################
# Copy the ubifs image of boot_nand
##############################

$(STATE_DIR)/cp_image_boot_nand: 
	mkdir -p $(MY_IMAGES)/boot_nand
	cp $(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/images/root.ubifs $(MY_IMAGES)/boot_nand/root-phyBOARD-WEGA.ubifs
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : cp_image_boot_nand

cp_image_boot_nand: $(STATE_DIR)/cp_image_boot_nand

rm_cp_image_boot_nand: 
	if [ -e $(STATE_DIR)/cp_image_boot_nand ]; then rm $(STATE_DIR)/cp_image_boot_nand; fi

CLEAN_STATE_LIST += rm_cp_image_boot_nand

info_target_cp_image_boot_nand : 
	@echo "cp_image_boot_nand:	 Copy the ubifs image of boot_nand"

INFO_TARGET_LIST += info_target_cp_image_boot_nand


##############################
# Copy kernel from images folder into tftp folder
##############################

$(STATE_DIR)/tftpboot_kernel: $(MY_IMAGES)/boot_tftp_nfs/uImage-phyBOARD-WEGA
	mkdir -p $(MY_TFTPBOOT)/phyBOARD-WEGA
	cp $(MY_IMAGES)/boot_tftp_nfs/uImage-phyBOARD-WEGA $(MY_TFTPBOOT)/phyBOARD-WEGA/uImage-phyBOARD-WEGA-$(MY_VERSION)
	ln -sf phyBOARD-WEGA/uImage-phyBOARD-WEGA-$(MY_VERSION) $(MY_TFTPBOOT)/uImage-phyBOARD-WEGA
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : tftpboot_kernel

tftpboot_kernel: $(STATE_DIR)/tftpboot_kernel

rm_tftpboot_kernel: 
	if [ -e $(STATE_DIR)/tftpboot_kernel ]; then rm $(STATE_DIR)/tftpboot_kernel; fi

CLEAN_STATE_LIST += rm_tftpboot_kernel

info_target_tftpboot_kernel : 
	@echo "tftpboot_kernel:	 Copy kernel from images folder into tftp folder"

INFO_TARGET_LIST += info_target_tftpboot_kernel


##############################
# Adjust nfsroot in env/config
##############################

$(STATE_DIR)/tftpboot_config: 
	@if [ -e $(MY_TFTPBOOT)/phyBOARD-WEGA/env/bin/net-03 ] ; then  \
		sed -i '/# define nfsroot/,+2 s%nfsroot=.*%nfsroot="$(MY_DEVELOP)/rootfs/phyBOARD-WEGA-$(MY_VERSION)"%' $(MY_TFTPBOOT)/phyBOARD-WEGA/env/bin/net-03; \
		echo "In $(MY_TFTPBOOT)/phyBOARD-WEGA/env/bin/net-03 new value nfsroot=\"$(MY_DEVELOP)/rootfs/phyBOARD-WEGA-$(MY_VERSION)\""; \
	else     \
		echo "$(MY_TFTPBOOT)/phyBOARD-WEGA/env/bin/net-03 doesn't exist"; \
		exit 1; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : tftpboot_config

tftpboot_config: $(STATE_DIR)/tftpboot_config

rm_tftpboot_config: 
	if [ -e $(STATE_DIR)/tftpboot_config ]; then rm $(STATE_DIR)/tftpboot_config; fi

CLEAN_STATE_LIST += rm_tftpboot_config

info_target_tftpboot_config : 
	@echo "tftpboot_config:	 Adjust nfsroot in env/config"

INFO_TARGET_LIST += info_target_tftpboot_config


##############################
# Adjust env/config to boot from TFTP and NFS
##############################

$(STATE_DIR)/tftpboot_config_loc_boot_tftp_nfs: 
	@echo "# If you want to boot permanently with net-02, then "
	@echo "# set the value of global.boot.default to net-02 in the env/config file:"
	@echo ""
	@echo "edit env/config"
	@echo ""
	@echo "global.boot.default=net-02"
	@echo ""
	@echo "# CTRL-D to save changes, CTRL-C to abort editing"
	@echo "# saveenv"
	@echo ""
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : tftpboot_config_loc_boot_tftp_nfs

tftpboot_config_loc_boot_tftp_nfs: $(STATE_DIR)/tftpboot_config_loc_boot_tftp_nfs

rm_tftpboot_config_loc_boot_tftp_nfs: 
	if [ -e $(STATE_DIR)/tftpboot_config_loc_boot_tftp_nfs ]; then rm $(STATE_DIR)/tftpboot_config_loc_boot_tftp_nfs; fi

CLEAN_STATE_LIST += rm_tftpboot_config_loc_boot_tftp_nfs

info_target_tftpboot_config_loc_boot_tftp_nfs : 
	@echo "tftpboot_config_loc_boot_tftp_nfs:	 Adjust env/config to boot from TFTP and NFS"

INFO_TARGET_LIST += info_target_tftpboot_config_loc_boot_tftp_nfs


##############################
# Adjust env/config to boot from NAND
##############################

$(STATE_DIR)/tftpboot_config_loc_boot_nand: 
	@echo "# If you want to boot the default way, then "
	@echo "# set the value of global.boot.default to \$$bootsource in the env/config file:"
	@echo ""
	@echo "edit env/config"
	@echo ""
	@echo "global.boot.default=\$$bootsource"
	@echo ""
	@echo "# CTRL-D to save changes, CTRL-C to abort editing"
	@echo "# saveenv"
	@echo ""
	@echo ""
	@echo "# If you want to boot from NAND, independent of what the boot source is, then "
	@echo "# set the value of global.boot.default to nand in the env/config file:"
	@echo ""
	@echo "edit env/config"
	@echo ""
	@echo "global.boot.default=nand"
	@echo ""
	@echo "# CTRL-D to save changes, CTRL-C to abort editing"
	@echo "# saveenv"
	@echo ""
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : tftpboot_config_loc_boot_nand

tftpboot_config_loc_boot_nand: $(STATE_DIR)/tftpboot_config_loc_boot_nand

rm_tftpboot_config_loc_boot_nand: 
	if [ -e $(STATE_DIR)/tftpboot_config_loc_boot_nand ]; then rm $(STATE_DIR)/tftpboot_config_loc_boot_nand; fi

CLEAN_STATE_LIST += rm_tftpboot_config_loc_boot_nand

info_target_tftpboot_config_loc_boot_nand : 
	@echo "tftpboot_config_loc_boot_nand:	 Adjust env/config to boot from NAND"

INFO_TARGET_LIST += info_target_tftpboot_config_loc_boot_nand


##############################
# Copy root.ubi into tftp folder
##############################

$(STATE_DIR)/tftpboot_root_ubi: $(MY_IMAGES)/boot_nand/root-phyBOARD-WEGA.ubifs
	mkdir -p $(MY_TFTPBOOT)/phyBOARD-WEGA
	cp $(MY_IMAGES)/boot_nand/root-phyBOARD-WEGA.ubifs $(MY_TFTPBOOT)/phyBOARD-WEGA/root-phyBOARD-WEGA.ubifs-$(MY_VERSION)
	ln -sf phyBOARD-WEGA/root-phyBOARD-WEGA.ubifs-$(MY_VERSION) $(MY_TFTPBOOT)/root-phyBOARD-WEGA.ubifs
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : tftpboot_root_ubi

tftpboot_root_ubi: $(STATE_DIR)/tftpboot_root_ubi

rm_tftpboot_root_ubi: 
	if [ -e $(STATE_DIR)/tftpboot_root_ubi ]; then rm $(STATE_DIR)/tftpboot_root_ubi; fi

CLEAN_STATE_LIST += rm_tftpboot_root_ubi

info_target_tftpboot_root_ubi : 
	@echo "tftpboot_root_ubi:	 Copy root.ubi into tftp folder"

INFO_TARGET_LIST += info_target_tftpboot_root_ubi


##############################
# update kernel and root on target for boot_nand
##############################

update_target_boot_nand: 
	@echo "# On the barebox command line:"
	@echo ""
	@echo "# Configure the ip addresses for tftp, if necessary"
	@echo "# change the ip addresses in the /env/network/eth0 file:"
	@echo "edit /env/network/eth0"
	@echo "# CTRL-D to save changes, CTRL-C to abort editing"
	@echo "ipaddr=$(IP_ADDR_TARGET)"
	@echo "netmask=$(IP_NETMASK)"
	@echo "serverip=$(IP_ADDR_HOST)"
	@echo "gateway=$(IP_ADDR_GATEWAY)"
	@echo ""
	@echo ""
	@echo "# save the new settings"
	@echo "saveenv"
	@echo "# reset the board, the new settings are applied"
	@echo "reset"
	@echo "# check if the settings have been saved"
	@echo "cat /env/network/eth0"
	@echo ""
	@echo ""
	@echo "# Write the kernel into flash"
	@echo "erase /dev/nand0.kernel.bb"
	@echo "cp /mnt/tftp/uImage-phyBOARD-WEGA /dev/nand0.kernel.bb"
	@echo ""
	@echo "# Write the root file system into flash"
	@echo "ubiformat /dev/nand0.root"
	@echo "ubiattach /dev/nand0.root"
	@echo "ubimkvol /dev/ubi0 root 0"
	@echo "cp /mnt/tftp/root-phyBOARD-WEGA.ubifs /dev/ubi0.root"
	@echo ""

.PHONY : update_target_boot_nand

info_target_update_target_boot_nand : 
	@echo "update_target_boot_nand:	 update kernel and root on target for boot_nand"

INFO_TARGET_LIST += info_target_update_target_boot_nand


##############################
# format SD-card!! create partition table on SD-card
##############################

$(STATE_DIR)/parted_sdcard_01:  \
    rm_cp_archive_sdcard_01 \
    rm_cp_file_sdcard_01
	sudo dd if=/dev/zero of=$(SDCARD_DEV) bs=512 count=16384
	sudo parted -s $(SDCARD_DEV) mklabel msdos
	sudo parted -s $(SDCARD_DEV) mkpart primary fat16 1MB 33MB
	sudo parted -s $(SDCARD_DEV) mkpart primary ext3 33MB 289MB
	sudo parted -s $(SDCARD_DEV) set 1 boot on
	
	sudo parted $(SDCARD_DEV) print
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : parted_sdcard_01

parted_sdcard_01: $(STATE_DIR)/parted_sdcard_01

rm_parted_sdcard_01: 
	if [ -e $(STATE_DIR)/parted_sdcard_01 ]; then rm $(STATE_DIR)/parted_sdcard_01; fi

CLEAN_STATE_LIST += rm_parted_sdcard_01

info_target_parted_sdcard_01 : 
	@echo "parted_sdcard_01:	 format SD-card!! create partition table on SD-card"

INFO_TARGET_LIST += info_target_parted_sdcard_01


##############################
# format SD-card!! copy files to SD-card
##############################

$(STATE_DIR)/cp_file_sdcard_01: 
	@echo
	@echo "create boot on $(SDCARD_PART)1"
	sudo mkfs.vfat -F 16 -n "boot" $(SDCARD_PART)1
	sync
	COPY_DEV=$$(mktemp -d /tmp/copy_fs_XXXX) &&  \
	sudo mount $(SDCARD_PART)1 $${COPY_DEV} &&  \
	sudo cp $(MY_IMAGES)/boot_mmc/MLO-phyBOARD-WEGA.img $${COPY_DEV}/MLO && \
	sudo cp $(MY_IMAGES)/boot_mmc/barebox-phyBOARD-WEGA.img $${COPY_DEV}/barebox.bin && \
	sudo cp $(MY_IMAGES)/boot_mmc/uImage-phyBOARD-WEGA $${COPY_DEV}/linuximage && \
	sudo umount $${COPY_DEV};
	sync
	sudo fsck.vfat -n $(SDCARD_PART)1
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : cp_file_sdcard_01

cp_file_sdcard_01: $(STATE_DIR)/cp_file_sdcard_01

rm_cp_file_sdcard_01: 
	if [ -e $(STATE_DIR)/cp_file_sdcard_01 ]; then rm $(STATE_DIR)/cp_file_sdcard_01; fi

CLEAN_STATE_LIST += rm_cp_file_sdcard_01

info_target_cp_file_sdcard_01 : 
	@echo "cp_file_sdcard_01:	 format SD-card!! copy files to SD-card"

INFO_TARGET_LIST += info_target_cp_file_sdcard_01


##############################
# format SD-card!! extract archive to SD-card
##############################

$(STATE_DIR)/cp_archive_sdcard_01: 
	@echo
	@echo "create root on $(SDCARD_PART)2"
	sudo mkfs.ext3 -L "root" $(SDCARD_PART)2
	COPY_DEV=$$(mktemp -d /tmp/copy_fs_XXXX) &&  \
	sudo mount $(SDCARD_PART)2 $${COPY_DEV} &&  \
	sudo tar -xzf $(MY_IMAGES)/boot_mmc/root-phyBOARD-WEGA.tar.gz -C $${COPY_DEV} && \
	sudo umount $${COPY_DEV};
	
	sync
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : cp_archive_sdcard_01

cp_archive_sdcard_01: $(STATE_DIR)/cp_archive_sdcard_01

rm_cp_archive_sdcard_01: 
	if [ -e $(STATE_DIR)/cp_archive_sdcard_01 ]; then rm $(STATE_DIR)/cp_archive_sdcard_01; fi

CLEAN_STATE_LIST += rm_cp_archive_sdcard_01

info_target_cp_archive_sdcard_01 : 
	@echo "cp_archive_sdcard_01:	 format SD-card!! extract archive to SD-card"

INFO_TARGET_LIST += info_target_cp_archive_sdcard_01


##############################
# format SD-card. Erase image area of SD-card
##############################

$(STATE_DIR)/clean_image_sdcard_01:  \
    rm_cp_archive_sdcard_01 \
    rm_cp_file_sdcard_01 \
    rm_parted_sdcard_01
	@echo "erase image area of SD-card"
	sudo dd if=/dev/zero of="$(SDCARD_DEV)" conv=notrunc bs=512 count=591872
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : clean_image_sdcard_01

clean_image_sdcard_01: $(STATE_DIR)/clean_image_sdcard_01

rm_clean_image_sdcard_01: 
	if [ -e $(STATE_DIR)/clean_image_sdcard_01 ]; then rm $(STATE_DIR)/clean_image_sdcard_01; fi

CLEAN_STATE_LIST += rm_clean_image_sdcard_01

info_target_clean_image_sdcard_01 : 
	@echo "clean_image_sdcard_01:	 format SD-card. Erase image area of SD-card"

INFO_TARGET_LIST += info_target_clean_image_sdcard_01


##############################
# Copy barebox config files into tftp folder
##############################

$(STATE_DIR)/cp_barebox_config: 
	mkdir -p $(MY_TFTPBOOT)/phyBOARD-WEGA/
	cd $(MY_IMAGES)/barebox/ && \
	cp --parents env/network/eth0 env/boot/net-02 env/bin/net-03 env/boot/mmc-02 env/init/automount $(MY_TFTPBOOT)/phyBOARD-WEGA/
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : cp_barebox_config

cp_barebox_config: $(STATE_DIR)/cp_barebox_config

rm_cp_barebox_config: 
	if [ -e $(STATE_DIR)/cp_barebox_config ]; then rm $(STATE_DIR)/cp_barebox_config; fi

CLEAN_STATE_LIST += rm_cp_barebox_config

info_target_cp_barebox_config : 
	@echo "cp_barebox_config:	 Copy barebox config files into tftp folder"

INFO_TARGET_LIST += info_target_cp_barebox_config


##############################
# Edit the config files, set the ip address
##############################

$(STATE_DIR)/set_ip_barebox_config: 
	@echo "# set ip addresses in $(MY_TFTPBOOT)/phyBOARD-WEGA/env/network/eth0"
	sed -i \
	-e "/\# ip setting/,+1 s/.*ip=.*/ip=static/" \
	-e "/\# static setup/,+4 { ; \
	 s/.*ipaddr=.*/ipaddr=$(IP_ADDR_TARGET)/; \
	 s/.*netmask=.*/netmask=$(IP_NETMASK)/; \
	 s/.*serverip=.*/serverip=$(IP_ADDR_HOST)/; \
	 s/.*gateway=.*/gateway=$(IP_ADDR_GATEWAY)/ \
	}" \
	$(MY_TFTPBOOT)/phyBOARD-WEGA/env/network/eth0
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : set_ip_barebox_config

set_ip_barebox_config: $(STATE_DIR)/set_ip_barebox_config

rm_set_ip_barebox_config: 
	if [ -e $(STATE_DIR)/set_ip_barebox_config ]; then rm $(STATE_DIR)/set_ip_barebox_config; fi

CLEAN_STATE_LIST += rm_set_ip_barebox_config

info_target_set_ip_barebox_config : 
	@echo "set_ip_barebox_config:	 Edit the config files, set the ip address"

INFO_TARGET_LIST += info_target_set_ip_barebox_config


##############################
# Copy init files to the target
##############################

$(STATE_DIR)/cp_init_board: 
	@echo "# On the barebox command line:"
	@echo "# Install or update init files manually"
	@echo ""
	@echo "# Configure  at first the ip addresses for tftp, if necessary:"
	@echo ""
	@echo "eth0.ipaddr=$(IP_ADDR_TARGET)"
	@echo "eth0.netmask=$(IP_NETMASK)"
	@echo "eth0.serverip=$(IP_ADDR_HOST)"
	@echo "eth0.gateway=$(IP_ADDR_GATEWAY)"
	@echo ""
	@echo "# Download files"
	@echo "tftp phyBOARD-WEGA/env/boot/net-02 /env/boot/net-02"
	@echo "tftp phyBOARD-WEGA/env/network/eth0 /env/network/eth0"
	@echo "tftp phyBOARD-WEGA/env/boot/mmc-02 /env/boot/mmc-02"
	@echo "tftp phyBOARD-WEGA/env/init/automount /env/init/automount"
	@echo ""
	@echo "# save the environment after the files have been downloaded"
	@echo "saveenv"
	@echo ""
	@echo "# Boot the board via TFTP and NFS"
	@echo "boot net-02"
	@echo ""
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : cp_init_board

cp_init_board: $(STATE_DIR)/cp_init_board

rm_cp_init_board: 
	if [ -e $(STATE_DIR)/cp_init_board ]; then rm $(STATE_DIR)/cp_init_board; fi

CLEAN_STATE_LIST += rm_cp_init_board

info_target_cp_init_board : 
	@echo "cp_init_board:	 Copy init files to the target"

INFO_TARGET_LIST += info_target_cp_init_board


##############################
# cp env into images
##############################

$(STATE_DIR)/archive_barebox_env: 
	mkdir -p $(MY_IMAGES)/barebox/
	cd $(MY_PD)/tftpboot/phyBOARD-WEGA && \
	cp --parents env/network/eth0 env/boot/net-02 env/bin/net-03 env/boot/mmc-02 env/init/automount $(MY_IMAGES)/barebox/
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : archive_barebox_env

archive_barebox_env: $(STATE_DIR)/archive_barebox_env

rm_archive_barebox_env: 
	if [ -e $(STATE_DIR)/archive_barebox_env ]; then rm $(STATE_DIR)/archive_barebox_env; fi

CLEAN_STATE_LIST += rm_archive_barebox_env

info_target_archive_barebox_env : 
	@echo "archive_barebox_env:	 cp env into images"

INFO_TARGET_LIST += info_target_archive_barebox_env


##############################
# Compare new env in folder tftpboot with current env
##############################

compare_barebox_env: 
	kdiff3 $(MY_TFTPBOOT)/phyBOARD-WEGA/env $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/barebox-defaultenv &
	kdiff3 $(MY_TFTPBOOT)/phyBOARD-WEGA/env $(MY_PD)/tftpboot/phyBOARD-WEGA/env &
	kdiff3 $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/barebox-defaultenv $(MY_PD)/tftpboot/phyBOARD-WEGA/env &
	kdiff3 $(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/build-target/barebox-2013.11.0/arch/arm/boards/pcm051/env $(MY_PD)/tftpboot/phyBOARD-WEGA/env &
	kdiff3 $(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/build-target/barebox-2013.11.0/defaultenv-2/base $(MY_PD)/tftpboot/phyBOARD-WEGA/env &
	kdiff3 $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/barebox-defaultenv $(MY_TFTPBOOT)/phyBOARD-WEGA/env &
	kdiff3 $(MY_PD)/tftpboot/phyBOARD-WEGA/env $(MY_TFTPBOOT)/phyBOARD-WEGA/env &
	kdiff3 $(MY_PD)/tftpboot/phyBOARD-WEGA/env $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/barebox-defaultenv &

.PHONY : compare_barebox_env

info_target_compare_barebox_env : 
	@echo "compare_barebox_env:	 Compare new env in folder tftpboot with current env"

INFO_TARGET_LIST += info_target_compare_barebox_env


##############################
# call menuconfig for kernel
##############################

bsp_kernelconfig: 
	cd $(BSP_DIR) && \
	$(PTXDIST) kernelconfig

.PHONY : bsp_kernelconfig

info_target_bsp_kernelconfig : 
	@echo "bsp_kernelconfig:	 call menuconfig for kernel"

INFO_TARGET_LIST += info_target_bsp_kernelconfig


##############################
# clean barebox
##############################

$(STATE_DIR)/barebox-clean: 
	cd $(BSP_DIR) && \
	$(PTXDIST) clean barebox
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : barebox-clean

barebox-clean: $(STATE_DIR)/barebox-clean

rm_barebox-clean: 
	if [ -e $(STATE_DIR)/barebox-clean ]; then rm $(STATE_DIR)/barebox-clean; fi

CLEAN_STATE_LIST += rm_barebox-clean

info_target_barebox-clean : 
	@echo "barebox-clean:	 clean barebox"

INFO_TARGET_LIST += info_target_barebox-clean


##############################
# compile barebox after changing source code
##############################

$(STATE_DIR)/barebox-compile: 
	cd $(BSP_DIR) && \
	if [ -e platform-phyBOARD-WEGA-AM335x/state/barebox.compile ] ; then \
		$(PTXDIST) drop barebox.compile ; \
	fi && \
	$(PTXDIST) compile barebox
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : barebox-compile

barebox-compile: $(STATE_DIR)/barebox-compile

rm_barebox-compile: 
	if [ -e $(STATE_DIR)/barebox-compile ]; then rm $(STATE_DIR)/barebox-compile; fi

CLEAN_STATE_LIST += rm_barebox-compile

info_target_barebox-compile : 
	@echo "barebox-compile:	 compile barebox after changing source code"

INFO_TARGET_LIST += info_target_barebox-compile


##############################
# clean kernel
##############################

$(STATE_DIR)/kernel-clean: 
	cd $(BSP_DIR) && \
	$(PTXDIST) clean kernel
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : kernel-clean

kernel-clean: $(STATE_DIR)/kernel-clean

rm_kernel-clean: 
	if [ -e $(STATE_DIR)/kernel-clean ]; then rm $(STATE_DIR)/kernel-clean; fi

CLEAN_STATE_LIST += rm_kernel-clean

info_target_kernel-clean : 
	@echo "kernel-clean:	 clean kernel"

INFO_TARGET_LIST += info_target_kernel-clean


##############################
# compile kernel after changing source code
##############################

$(STATE_DIR)/kernel-compile: 
	cd $(BSP_DIR) && \
	if [ -e platform-phyBOARD-WEGA-AM335x/state/kernel.compile ] ; then \
		$(PTXDIST) drop kernel.compile ; \
	fi && \
	$(PTXDIST) -ji1 compile kernel
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : kernel-compile

kernel-compile: $(STATE_DIR)/kernel-compile

rm_kernel-compile: 
	if [ -e $(STATE_DIR)/kernel-compile ]; then rm $(STATE_DIR)/kernel-compile; fi

CLEAN_STATE_LIST += rm_kernel-compile

info_target_kernel-compile : 
	@echo "kernel-compile:	 compile kernel after changing source code"

INFO_TARGET_LIST += info_target_kernel-compile


##############################
# dmesg over ssh
##############################

ssh_dmesg: 
	@mkdir -p $(MY_DEVELOP)/log/$(MY_VERSION)
	@SSH_DMESG=$$(mktemp $(MY_DEVELOP)/log/$(MY_VERSION)/dmesg-$$(date -u '+%Y%m%d%H%M')-XXXX.txt) &&  \
	ssh root@$(IP_ADDR_TARGET) dmesg > $${SSH_DMESG} &&  \
	echo "Dmesg has been written to $${SSH_DMESG}"

.PHONY : ssh_dmesg

info_target_ssh_dmesg : 
	@echo "ssh_dmesg:	 dmesg over ssh"

INFO_TARGET_LIST += info_target_ssh_dmesg


##############################
# remove fingerprint in .ssh/known_hosts
##############################

$(STATE_DIR)/ssh_fingerprint: 
	@sed -i -e "/$(IP_ADDR_TARGET)/ d" $${HOME}/.ssh/known_hosts 
	@echo "Fingerprint of $(IP_ADDR_TARGET) has been removed"
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : ssh_fingerprint

ssh_fingerprint: $(STATE_DIR)/ssh_fingerprint

rm_ssh_fingerprint: 
	if [ -e $(STATE_DIR)/ssh_fingerprint ]; then rm $(STATE_DIR)/ssh_fingerprint; fi

CLEAN_STATE_LIST += rm_ssh_fingerprint

info_target_ssh_fingerprint : 
	@echo "ssh_fingerprint:	 remove fingerprint in .ssh/known_hosts"

INFO_TARGET_LIST += info_target_ssh_fingerprint


##############################
# Copy barebox image of boot_nand into images folder
##############################

$(STATE_DIR)/cp_barebox_boot_nand: 
	mkdir -p $(MY_IMAGES)/boot_nand
	cp $(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/images/barebox-image $(MY_IMAGES)/boot_nand/barebox-phyBOARD-WEGA.img
	cp $(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/images/MLO $(MY_IMAGES)/boot_nand/MLO-phyBOARD-WEGA.img
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : cp_barebox_boot_nand

cp_barebox_boot_nand: $(STATE_DIR)/cp_barebox_boot_nand

rm_cp_barebox_boot_nand: 
	if [ -e $(STATE_DIR)/cp_barebox_boot_nand ]; then rm $(STATE_DIR)/cp_barebox_boot_nand; fi

CLEAN_STATE_LIST += rm_cp_barebox_boot_nand

info_target_cp_barebox_boot_nand : 
	@echo "cp_barebox_boot_nand:	 Copy barebox image of boot_nand into images folder"

INFO_TARGET_LIST += info_target_cp_barebox_boot_nand


##############################
# Copy barebox from images folder into tftp folder
##############################

$(STATE_DIR)/tftpboot_barebox: 
	mkdir -p $(MY_TFTPBOOT)/phyBOARD-WEGA
	cp $(MY_IMAGES)/boot_nand/barebox-phyBOARD-WEGA.img $(MY_TFTPBOOT)/phyBOARD-WEGA/barebox-phyBOARD-WEGA.img-$(MY_VERSION)
	ln -sf phyBOARD-WEGA/barebox-phyBOARD-WEGA.img-$(MY_VERSION) $(MY_TFTPBOOT)/barebox-phyBOARD-WEGA.img
	
	cp $(MY_IMAGES)/boot_nand/MLO-phyBOARD-WEGA.img $(MY_TFTPBOOT)/phyBOARD-WEGA/MLO-phyBOARD-WEGA.img-$(MY_VERSION)
	ln -sf phyBOARD-WEGA/MLO-phyBOARD-WEGA.img-$(MY_VERSION) $(MY_TFTPBOOT)/MLO-phyBOARD-WEGA.img
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : tftpboot_barebox

tftpboot_barebox: $(STATE_DIR)/tftpboot_barebox

rm_tftpboot_barebox: 
	if [ -e $(STATE_DIR)/tftpboot_barebox ]; then rm $(STATE_DIR)/tftpboot_barebox; fi

CLEAN_STATE_LIST += rm_tftpboot_barebox

info_target_tftpboot_barebox : 
	@echo "tftpboot_barebox:	 Copy barebox from images folder into tftp folder"

INFO_TARGET_LIST += info_target_tftpboot_barebox


##############################
# Update barebox via TFTP
##############################

$(STATE_DIR)/update_barebox: 
	@echo "# On the barebox command line:"
	@echo ""
	@echo "# Configure the ip addresses for tftp, if necessary"
	@echo "# change the ip addresses in the /env/network/eth0 file:"
	@echo "edit /env/network/eth0"
	@echo "# CTRL-D to save changes, CTRL-C to abort editing"
	@echo "ipaddr=$(IP_ADDR_TARGET)"
	@echo "netmask=$(IP_NETMASK)"
	@echo "serverip=$(IP_ADDR_HOST)"
	@echo "gateway=$(IP_ADDR_GATEWAY)"
	@echo ""
	@echo ""
	@echo "# save the new settings"
	@echo "saveenv"
	@echo "# reset the board, the new settings are applied"
	@echo "reset"
	@echo "# check if the settings have been saved"
	@echo "cat /env/network/eth0"
	@echo ""
	@echo ""
	@echo "# Write the barebox image into flash"
	@echo "erase /dev/nand0.barebox.bb"
	@echo "cp /tmp/tftp/barebox-phyBOARD-WEGA.img /dev/nand0.barebox.bb"
	@echo ""
	@echo "# IMPORTANT: Usally you don't need to update MLO. Updated it only, when you know what you are doing!!!"
	@echo "# Write the MLO into flash"
	@echo "erase /dev/nand0.xload.bb"
	@echo "cp /tmp/tftp/MLO-phyBOARD-WEGA.img /dev/nand0.xload.bb"
	@echo ""
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : update_barebox

update_barebox: $(STATE_DIR)/update_barebox

rm_update_barebox: 
	if [ -e $(STATE_DIR)/update_barebox ]; then rm $(STATE_DIR)/update_barebox; fi

CLEAN_STATE_LIST += rm_update_barebox

info_target_update_barebox : 
	@echo "update_barebox:	 Update barebox via TFTP"

INFO_TARGET_LIST += info_target_update_barebox


##############################
# show command for netconsole
##############################

netconsole: 
	@echo
	@echo "# Use the script netconsole to connect to the target"
	@echo "$(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/build-target/barebox-2013.07.0/scripts/netconsole $(IP_ADDR_TARGET)"
	@echo

.PHONY : netconsole

info_target_netconsole : 
	@echo "netconsole:	 show command for netconsole"

INFO_TARGET_LIST += info_target_netconsole


##############################
# download files for bsp
##############################

$(STATE_DIR)/bsp_download: 
	
	# Download BSP
	mkdir -p $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	cd $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	wget ftp://ftp.phytec.de/pub/Products/phyBOARD-WEGA-AM335x/Linux/PD13.0.0/phyBOARD-WEGA-AM335x-PD13.0.0.tar.gz ;
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : bsp_download

bsp_download: $(STATE_DIR)/bsp_download

rm_bsp_download: 
	if [ -e $(STATE_DIR)/bsp_download ]; then rm $(STATE_DIR)/bsp_download; fi

CLEAN_STATE_LIST += rm_bsp_download

info_target_bsp_download : 
	@echo "bsp_download:	 download files for bsp"

INFO_TARGET_LIST += info_target_bsp_download


##############################
# download files for ptxdist
##############################

$(STATE_DIR)/ptxdist_download: 
	
	# Download ptxdist
	mkdir -p $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	cd $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	wget ftp://ftp.phytec.de/pub/Products/phyBOARD-WEGA-AM335x/Linux/PD13.0.0/ptxdist-$(PTX_VERSION).tar.bz2 ;
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : ptxdist_download

ptxdist_download: $(STATE_DIR)/ptxdist_download

rm_ptxdist_download: 
	if [ -e $(STATE_DIR)/ptxdist_download ]; then rm $(STATE_DIR)/ptxdist_download; fi

CLEAN_STATE_LIST += rm_ptxdist_download

info_target_ptxdist_download : 
	@echo "ptxdist_download:	 download files for ptxdist"

INFO_TARGET_LIST += info_target_ptxdist_download


##############################
# download files for toolchain
##############################

$(STATE_DIR)/toolchain_download: 
	
	# Download toolchain
	mkdir -p $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	cd $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	wget ftp://ftp.phytec.de/pub/Products/phyBOARD-WEGA-AM335x/Linux/PD13.0.0/OSELAS.Toolchain-2012.12.1.tar.bz2 ;
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : toolchain_download

toolchain_download: $(STATE_DIR)/toolchain_download

rm_toolchain_download: 
	if [ -e $(STATE_DIR)/toolchain_download ]; then rm $(STATE_DIR)/toolchain_download; fi

CLEAN_STATE_LIST += rm_toolchain_download

info_target_toolchain_download : 
	@echo "toolchain_download:	 download files for toolchain"

INFO_TARGET_LIST += info_target_toolchain_download


##############################
# download docs for bsp
##############################

$(STATE_DIR)/doc_download: 
	
	# Download installation doc
	mkdir -p $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	cd $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	wget http://www.phytec.de/fileadmin/user_upload/pictures/Produkte/phyBOARDs/L-792e_0.pdf ;
	
	# Download phyBOARD-WEGA-AM335x Quick Start
	mkdir -p $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	cd $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	wget http://www.phytec.de/fileadmin/user_upload/pictures/Produkte/phyBOARDs/phyBOARD-Wega_AM3354_QuickStart_Guide_Linux.pdf ;
	
	# Download phyBOARD-WEGA-AM335x Expansion Boards
	mkdir -p $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	cd $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	wget http://www.phytec.de/fileadmin/user_upload/downloads/Manuals/L-793e_0.pdf ;
	
	# Download Release Notes
	mkdir -p $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	cd $(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0 && \
	wget ftp://ftp.phytec.de/pub/Products/phyBOARD-WEGA-AM335x/Linux/PD13.0.0/ReleaseNotes ;
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : doc_download

doc_download: $(STATE_DIR)/doc_download

rm_doc_download: 
	if [ -e $(STATE_DIR)/doc_download ]; then rm $(STATE_DIR)/doc_download; fi

CLEAN_STATE_LIST += rm_doc_download

info_target_doc_download : 
	@echo "doc_download:	 download docs for bsp"

INFO_TARGET_LIST += info_target_doc_download


##############################
# Extract ptxdist
##############################

$(STATE_DIR)/ptxdist_extract: 
	mkdir -p $(MY_PD)
	tar -jxf "$(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0/ptxdist-$(PTX_VERSION).tar.bz2" -C $(MY_PD)
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : ptxdist_extract

ptxdist_extract: $(STATE_DIR)/ptxdist_extract

rm_ptxdist_extract: 
	if [ -e $(STATE_DIR)/ptxdist_extract ]; then rm $(STATE_DIR)/ptxdist_extract; fi

CLEAN_STATE_LIST += rm_ptxdist_extract

info_target_ptxdist_extract : 
	@echo "ptxdist_extract:	 Extract ptxdist"

INFO_TARGET_LIST += info_target_ptxdist_extract


##############################
# Install ptxdist
##############################

$(STATE_DIR)/ptxdist_install: 
	cd $(PTX_DIR)/ && \
	./configure --prefix $(MY_PD)/tools && \
	make -C $(PTX_DIR)/ && \
	make -C $(PTX_DIR)/ install
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : ptxdist_install

ptxdist_install: $(STATE_DIR)/ptxdist_install

rm_ptxdist_install: 
	if [ -e $(STATE_DIR)/ptxdist_install ]; then rm $(STATE_DIR)/ptxdist_install; fi

CLEAN_STATE_LIST += rm_ptxdist_install

info_target_ptxdist_install : 
	@echo "ptxdist_install:	 Install ptxdist"

INFO_TARGET_LIST += info_target_ptxdist_install


##############################
# setup ptxdist
##############################

$(STATE_DIR)/ptxdist_setup: 
	@echo
	@echo "Source Directories  ---> "
	@echo "old value"
	@echo "\$${PTXDIST_WORKSPACE}/src "
	@echo
	@echo "new value"
	@echo "$(MY_DOWNLOAD_SRC)"
	@echo
	@read -p "Remember the new value $(MY_SRC) and enter it in the following config dialog. Please press a key to continue. " A
	cd $(PTX_DIR)/ && \
	$(PTXDIST) setup
	@echo "The variable PTXCONF_SETUP_SRCDIR is set to the new value in $${HOME}/.ptxdist/ptxdistrc-*:"
	@grep PTXCONF_SETUP_SRCDIR $${HOME}/.ptxdist/ptxdistrc-*
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : ptxdist_setup

ptxdist_setup: $(STATE_DIR)/ptxdist_setup

rm_ptxdist_setup: 
	if [ -e $(STATE_DIR)/ptxdist_setup ]; then rm $(STATE_DIR)/ptxdist_setup; fi

CLEAN_STATE_LIST += rm_ptxdist_setup

info_target_ptxdist_setup : 
	@echo "ptxdist_setup:	 setup ptxdist"

INFO_TARGET_LIST += info_target_ptxdist_setup


##############################
# set PTXCONF_SETUP_SRCDIR in ptxdistrc
##############################

$(STATE_DIR)/ptxdist_setup_srcdir: 
	sed -i -e "/PTXCONF_SETUP_SRCDIR=/ s%PTXCONF_SETUP_SRCDIR=.*$$%PTXCONF_SETUP_SRCDIR=\"$(MY_DOWNLOAD_SRC)\"%" \
	$(PTX_PTXRC) ;
	@echo "The variable PTXCONF_SETUP_SRCDIR is set to the new value '$(MY_DOWNLOAD_SRC)' in $(PTX_PTXRC)"
	@grep PTXCONF_SETUP_SRCDIR $(PTX_PTXRC)
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : ptxdist_setup_srcdir

ptxdist_setup_srcdir: $(STATE_DIR)/ptxdist_setup_srcdir

rm_ptxdist_setup_srcdir: 
	if [ -e $(STATE_DIR)/ptxdist_setup_srcdir ]; then rm $(STATE_DIR)/ptxdist_setup_srcdir; fi

CLEAN_STATE_LIST += rm_ptxdist_setup_srcdir

info_target_ptxdist_setup_srcdir : 
	@echo "ptxdist_setup_srcdir:	 set PTXCONF_SETUP_SRCDIR in ptxdistrc"

INFO_TARGET_LIST += info_target_ptxdist_setup_srcdir


##############################
# Extract Toolchain
##############################

$(STATE_DIR)/toolchain_extract: 
	tar -jxf "${MY_DOWNLOAD_BOARD}/phytec/PD13.0.0/OSELAS.Toolchain-2012.12.1.tar.bz2" -C $(MY_PD)
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : toolchain_extract

toolchain_extract: $(STATE_DIR)/toolchain_extract

rm_toolchain_extract: 
	if [ -e $(STATE_DIR)/toolchain_extract ]; then rm $(STATE_DIR)/toolchain_extract; fi

CLEAN_STATE_LIST += rm_toolchain_extract

info_target_toolchain_extract : 
	@echo "toolchain_extract:	 Extract Toolchain"

INFO_TARGET_LIST += info_target_toolchain_extract


##############################
# usage of ptxdist for toolchain
##############################

toolchain_ptxdist: 
	@echo ""
	@echo "# Usage of ptxdist for toolchain:"
	@echo ""
	@echo "# You can call ptxdist directly. It is VERY IMPORTANT, that you are in the correct directory."
	@echo "cd $(MY_PD)/OSELAS.Toolchain-2012.12.1; \\"
	@echo "$(PTXDIST)"
	@echo ""
	@echo "# Open menu:"
	@echo "cd $(MY_PD)/OSELAS.Toolchain-2012.12.1; \\"
	@echo "$(PTXDIST) menu"
	@echo ""
	@echo "# Change paths:"
	@echo "cd $(MY_PD)/OSELAS.Toolchain-2012.12.1; \\"
	@echo "$(PTXDIST) menuconfig"
	@echo ""

.PHONY : toolchain_ptxdist

info_target_toolchain_ptxdist : 
	@echo "toolchain_ptxdist:	 usage of ptxdist for toolchain"

INFO_TARGET_LIST += info_target_toolchain_ptxdist


##############################
# Create toolchain folder and make it accessible. Only needed when root is the owner of the folder.
##############################

$(STATE_DIR)/toolchain_folder: 
	sudo mkdir -p $(MY_TOOLCHAIN)/OSELAS.Toolchain-2012.12.1
	sudo chown root:$(USER) $(MY_TOOLCHAIN)/OSELAS.Toolchain-2012.12.1
	sudo chmod g+w $(MY_TOOLCHAIN)/OSELAS.Toolchain-2012.12.1
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : toolchain_folder

toolchain_folder: $(STATE_DIR)/toolchain_folder

rm_toolchain_folder: 
	if [ -e $(STATE_DIR)/toolchain_folder ]; then rm $(STATE_DIR)/toolchain_folder; fi

CLEAN_STATE_LIST += rm_toolchain_folder

info_target_toolchain_folder : 
	@echo "toolchain_folder:	 Create toolchain folder and make it accessible. Only needed when root is the owner of the folder."

INFO_TARGET_LIST += info_target_toolchain_folder


##############################
# set prefix for toolchain folder, default is /opt
##############################

$(STATE_DIR)/toolchain_prefix: 
	sed -i -e "/PTXCONF_PREFIX=/ s%PTXCONF_PREFIX=.*$$%PTXCONF_PREFIX=\"$(MY_TOOLCHAIN)\"%" \
	$(MY_PD)/OSELAS.Toolchain-2012.12.1/ptxconfigs/arm-cortexa8-linux-gnueabihf_gcc-4.7.3_glibc-2.16.0_binutils-2.22_kernel-3.6-sanitized.ptxconfig ;
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : toolchain_prefix

toolchain_prefix: $(STATE_DIR)/toolchain_prefix

rm_toolchain_prefix: 
	if [ -e $(STATE_DIR)/toolchain_prefix ]; then rm $(STATE_DIR)/toolchain_prefix; fi

CLEAN_STATE_LIST += rm_toolchain_prefix

info_target_toolchain_prefix : 
	@echo "toolchain_prefix:	 set prefix for toolchain folder, default is /opt"

INFO_TARGET_LIST += info_target_toolchain_prefix


##############################
# select the toolchain
##############################

$(STATE_DIR)/toolchain_select: 
	cd $(MY_PD)/OSELAS.Toolchain-2012.12.1; $(PTXDIST) select ptxconfigs/arm-cortexa8-linux-gnueabihf_gcc-4.7.3_glibc-2.16.0_binutils-2.22_kernel-3.6-sanitized.ptxconfig
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : toolchain_select

toolchain_select: $(STATE_DIR)/toolchain_select

rm_toolchain_select: 
	if [ -e $(STATE_DIR)/toolchain_select ]; then rm $(STATE_DIR)/toolchain_select; fi

CLEAN_STATE_LIST += rm_toolchain_select

info_target_toolchain_select : 
	@echo "toolchain_select:	 select the toolchain"

INFO_TARGET_LIST += info_target_toolchain_select


##############################
# migrate the config file to a new ptxdist version
##############################

$(STATE_DIR)/toolchain_migrate: 
	cd $(MY_PD)/OSELAS.Toolchain-2012.12.1 && \
	$(PTXDIST) migrate ;
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : toolchain_migrate

toolchain_migrate: $(STATE_DIR)/toolchain_migrate

rm_toolchain_migrate: 
	if [ -e $(STATE_DIR)/toolchain_migrate ]; then rm $(STATE_DIR)/toolchain_migrate; fi

CLEAN_STATE_LIST += rm_toolchain_migrate

info_target_toolchain_migrate : 
	@echo "toolchain_migrate:	 migrate the config file to a new ptxdist version"

INFO_TARGET_LIST += info_target_toolchain_migrate


##############################
# check PTXCONF_SETUP_SRCDIR in ptxdistrc for toolchain
##############################

toolchain_check_srcdir: 
	@cd  $(MY_PD)/OSELAS.Toolchain-2012.12.1&&\
	PTXCONF_SETUP_SRCDIR=$$($(PTXDIST) print PTXCONF_SETUP_SRCDIR) &&\
	PTXDIST_PTXRC=$$($(PTXDIST) print PTXDIST_PTXRC) &&\
	if [ "$${PTXDIST_PTXRC}" != "$(PTX_PTXRC)" ]; then \
		echo "Wrong value for PTX_PTXRC  in makefile use '$${PTXDIST_PTXRC}'"; \
		exit -1;\
	else \
		echo "ptxdist settings are in '$${PTXDIST_PTXRC}'";\
	fi;\
	if [ "$${PTXCONF_SETUP_SRCDIR}" != "$(MY_DOWNLOAD_SRC)" ]; then \
		echo "Wrong value for PTXCONF_SETUP_SRCDIR '$${PTXCONF_SETUP_SRCDIR}' instead of MY_DOWNLOAD_SRC:=/MyDevelop/distfiles";\
		echo "Use make target ptxdist_setup_srcdir to change it"; \
		exit -1;\
	else \
		echo "Source archives are downloaded to '$${PTXCONF_SETUP_SRCDIR}'"; \
	fi;

.PHONY : toolchain_check_srcdir

info_target_toolchain_check_srcdir : 
	@echo "toolchain_check_srcdir:	 check PTXCONF_SETUP_SRCDIR in ptxdistrc for toolchain"

INFO_TARGET_LIST += info_target_toolchain_check_srcdir


##############################
# build the toolchain from scratch
##############################

$(STATE_DIR)/toolchain_build: 
	@echo ""
	@echo "You need write permission to the new toolchain folder, when it is built. If you encounter an error just check the permissions and adjust them."
	@echo ""
	cd $(MY_PD)/OSELAS.Toolchain-2012.12.1 && \
	$(PTXDIST) go
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : toolchain_build

toolchain_build: $(STATE_DIR)/toolchain_build

rm_toolchain_build: 
	if [ -e $(STATE_DIR)/toolchain_build ]; then rm $(STATE_DIR)/toolchain_build; fi

CLEAN_STATE_LIST += rm_toolchain_build

info_target_toolchain_build : 
	@echo "toolchain_build:	 build the toolchain from scratch"

INFO_TARGET_LIST += info_target_toolchain_build


##############################
# remove temporary files of toolchain in order to save disk space
##############################

$(STATE_DIR)/toolchain_clean_build: 
	@echo "delete temporary files of toolchain in order to save disk space "
	if [ -e  "$(MY_PD)/OSELAS.Toolchain-2012.12.1/platform-arm-cortexa8-linux-gnueabihf-gcc-4.7.3-glibc-2.16.0-binutils-2.22-kernel-3.6-sanitized" ]; then rm -r "$(MY_PD)/OSELAS.Toolchain-2012.12.1/platform-arm-cortexa8-linux-gnueabihf-gcc-4.7.3-glibc-2.16.0-binutils-2.22-kernel-3.6-sanitized"; fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : toolchain_clean_build

toolchain_clean_build: $(STATE_DIR)/toolchain_clean_build

rm_toolchain_clean_build: 
	if [ -e $(STATE_DIR)/toolchain_clean_build ]; then rm $(STATE_DIR)/toolchain_clean_build; fi

CLEAN_STATE_LIST += rm_toolchain_clean_build

info_target_toolchain_clean_build : 
	@echo "toolchain_clean_build:	 remove temporary files of toolchain in order to save disk space"

INFO_TARGET_LIST += info_target_toolchain_clean_build


##############################
# Preparations for installing the BSP
##############################

bsp_prepare: 
	@echo ""
	@echo "Preparations:"
	@echo ""
	@echo "This makefile has been tested on a Gentoo installation www.gentoo.org."
	@echo ""
	@echo "You have to be able to use the command 'sudo'"
	@echo "If you are not able to use it, then edit the file '/etc/sudoers' and add the line"
	@echo "${USER}     ALL=(ALL) ALL"
	@echo
	@echo "The source code packages in the folder '$(MY_DOWNLOAD_SRC)' are used."
	@echo "If they are not available, they are downloaded in this folder."
	@echo "If you have already downloaded these files somewhere else, copy them to this folder or change the macro MY_DOWNLOAD_SRC accordingly."
	@echo ""
	@echo ""

.PHONY : bsp_prepare

info_target_bsp_prepare : 
	@echo "bsp_prepare:	 Preparations for installing the BSP"

INFO_TARGET_LIST += info_target_bsp_prepare


##############################
# extract BSP
##############################

$(STATE_DIR)/bsp_extract: 
	mkdir -p $(MY_PD)
	tar -zxf "$(MY_DOWNLOAD_BOARD)/phytec/PD13.0.0/phyBOARD-WEGA-AM335x-PD13.0.0.tar.gz" -C $(MY_PD)
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : bsp_extract

bsp_extract: $(STATE_DIR)/bsp_extract

rm_bsp_extract: 
	if [ -e $(STATE_DIR)/bsp_extract ]; then rm $(STATE_DIR)/bsp_extract; fi

CLEAN_STATE_LIST += rm_bsp_extract

info_target_bsp_extract : 
	@echo "bsp_extract:	 extract BSP"

INFO_TARGET_LIST += info_target_bsp_extract


##############################
# select the compiler
##############################

$(STATE_DIR)/bsp_compiler: 
	cd $(BSP_DIR) && \
	$(PTXDIST) toolchain $(MY_TOOLCHAIN)/OSELAS.Toolchain-2012.12.1/arm-cortexa8-linux-gnueabihf/gcc-4.7.3-glibc-2.16.0-binutils-2.22-kernel-3.6-sanitized/bin
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : bsp_compiler

bsp_compiler: $(STATE_DIR)/bsp_compiler

rm_bsp_compiler: 
	if [ -e $(STATE_DIR)/bsp_compiler ]; then rm $(STATE_DIR)/bsp_compiler; fi

CLEAN_STATE_LIST += rm_bsp_compiler

info_target_bsp_compiler : 
	@echo "bsp_compiler:	 select the compiler"

INFO_TARGET_LIST += info_target_bsp_compiler


##############################
# select the configuration files
##############################

$(STATE_DIR)/bsp_config: 
	cd $(BSP_DIR) && \
	$(PTXDIST) select configs/ptxconfig && \
	$(PTXDIST) platform configs/phyBOARD-WEGA-AM335x/platformconfig
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : bsp_config

bsp_config: $(STATE_DIR)/bsp_config

rm_bsp_config: 
	if [ -e $(STATE_DIR)/bsp_config ]; then rm $(STATE_DIR)/bsp_config; fi

CLEAN_STATE_LIST += rm_bsp_config

info_target_bsp_config : 
	@echo "bsp_config:	 select the configuration files"

INFO_TARGET_LIST += info_target_bsp_config


##############################
# usage of ptxdist for bsp
##############################

bsp_ptxdist: 
	@echo ""
	@echo "# Usage of ptxdist for bsp:"
	@echo ""
	@echo "# You can call ptxdist directly. It is VERY IMPORTANT, that you are in the correct directory."
	@echo ""
	@echo "# Call it without argument to show some help text."
	@echo "cd $(BSP_DIR); \\"
	@echo "$(PTXDIST)"
	@echo ""
	@echo "# Open menu:"
	@echo "cd $(BSP_DIR); \\"
	@echo "$(PTXDIST) menu"
	@echo ""
	@echo "# Configure the software platform:"
	@echo "cd $(BSP_DIR); \\"
	@echo "$(PTXDIST) menuconfig"
	@echo ""

.PHONY : bsp_ptxdist

info_target_bsp_ptxdist : 
	@echo "bsp_ptxdist:	 usage of ptxdist for bsp"

INFO_TARGET_LIST += info_target_bsp_ptxdist

