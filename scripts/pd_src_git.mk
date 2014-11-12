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
# Paths to git repository directory and git working directory
# GIT_REPO_DIR_*: git repository
# GIT_WORK_DIR_*: git working directory
##############################

GIT_REPO_DIR_bsp_local:=$(LOCAL_GIT)/phyBOARD-WEGA-AM335x-PD13.0.0.git
GIT_WORK_DIR_bsp_work:=$(BSP_DIR)
GIT_REPO_DIR_bsp_work:=$(GIT_WORK_DIR_bsp_work)/.git
GIT_REPO_DIR_ptxdist_local:=$(LOCAL_GIT)/ptxdist-2013.01.0.git
GIT_WORK_DIR_ptxdist_work:=$(PTX_DIR)
GIT_REPO_DIR_ptxdist_work:=$(GIT_WORK_DIR_ptxdist_work)/.git
GIT_REPO_DIR_barebox_local:=$(LOCAL_GIT)/barebox-2013.07.0.git
GIT_REPO_DIR_barebox_work:=$(BSP_DIR)/git-platform-phyBOARD-WEGA-AM335x/build-target/barebox-2013.07.0.git
GIT_WORK_DIR_barebox_work:=$(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/build-target/barebox-2013.07.0
GIT_REPO_DIR_linux_local:=$(LOCAL_GIT)/linux-3.2.git
GIT_REPO_DIR_linux_work:=$(BSP_DIR)/git-platform-phyBOARD-WEGA-AM335x/build-target/linux-3.2.git
GIT_WORK_DIR_linux_work:=$(BSP_DIR)/platform-phyBOARD-WEGA-AM335x/build-target/linux-3.2
GIT_REPO_DIR_toolchain_local:=$(LOCAL_GIT)/OSELAS.Toolchain-2012.12.1.git
GIT_WORK_DIR_toolchain_work:=$(MY_PD)/OSELAS.Toolchain-2012.12.1
GIT_REPO_DIR_toolchain_work:=$(GIT_WORK_DIR_toolchain_work)/.git
GIT_REPO_DIR_gcc-linaro_local:=$(LOCAL_GIT)/gcc-linaro-4.6-2011.11.git
GIT_REPO_DIR_gcc-linaro_work:=$(MY_PD)/git-OSELAS.Toolchain-2012.12.1/platform-arm-cortexa8-linux-gnueabi-gcc-4.6.2-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/build-cross/gcc-linaro-4.6-2011.11.git
GIT_WORK_DIR_gcc-linaro_work:=$(MY_PD)/OSELAS.Toolchain-2012.12.1/platform-arm-cortexa8-linux-gnueabi-gcc-4.6.2-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/build-cross/gcc-linaro-4.6-2011.11
GIT_REPO_DIR_tftpboot_remote_url:=$(TUTORIAL_SERVER1)/bundles/tftpboot-phyBOARD-WEGA.bundle
GIT_REPO_DIR_tftpboot_remote:=$(DISTRIB_IN)/bundles/tftpboot-phyBOARD-WEGA.bundle
GIT_REPO_DIR_tftpboot_local:=$(LOCAL_GIT)/tftpboot/phyBOARD-WEGA.git
GIT_WORK_DIR_tftpboot_work:=$(MY_PD)/tftpboot/phyBOARD-WEGA
GIT_REPO_DIR_tftpboot_work:=$(GIT_WORK_DIR_tftpboot_work)/.git

##############################
# Create new repository of local repository of bsp and add source code to it
##############################

$(STATE_DIR)/create_new_git_bsp_local: 
	@if [ ! -e  $(GIT_REPO_DIR_bsp_local) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_bsp_local)) && \
		git --git-dir=$(GIT_REPO_DIR_bsp_local) init --bare; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_bsp_local)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_bsp_local

create_new_git_bsp_local: $(STATE_DIR)/create_new_git_bsp_local

rm_create_new_git_bsp_local: 
	if [ -e $(STATE_DIR)/create_new_git_bsp_local ]; then rm $(STATE_DIR)/create_new_git_bsp_local; fi

CLEAN_STATE_LIST += rm_create_new_git_bsp_local

info_target_create_new_git_bsp_local : 
	@echo "create_new_git_bsp_local:	 Create new repository of local repository of bsp and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_bsp_local


##############################
# show branches in bsp_local
##############################

show_branch_git_bsp_local: 
	@if [  -e  $(GIT_REPO_DIR_bsp_local) ] ; then \
		echo "Repository: bsp_local $(GIT_REPO_DIR_bsp_local)" && \
		git --git-dir=$(GIT_REPO_DIR_bsp_local) branch -v --no-abbrev ; \
	else \
		echo "Repository: bsp_local $(GIT_REPO_DIR_bsp_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_bsp_local

info_target_show_branch_git_bsp_local : 
	@echo "show_branch_git_bsp_local:	 show branches in bsp_local"

INFO_TARGET_LIST += info_target_show_branch_git_bsp_local


##############################
# start git gui or gitk  for bsp_local
##############################

gui_git_bsp_local: 
	@if [  -e  $(GIT_REPO_DIR_bsp_local) ] ; then \
		cd  $(GIT_REPO_DIR_bsp_local) && gitk --all & \
	fi

.PHONY : gui_git_bsp_local

info_target_gui_git_bsp_local : 
	@echo "gui_git_bsp_local:	 start git gui or gitk  for bsp_local"

INFO_TARGET_LIST += info_target_gui_git_bsp_local


##############################
# check rev name and commit id in bsp_local
##############################

check_branch_git_bsp_local: 
	@if [  -e  $(GIT_REPO_DIR_bsp_local) ] ; then \
		echo "Repository: bsp_local $(GIT_REPO_DIR_bsp_local)" && \
		if [[ "$(GIT_REV_ID_bsp)" == `git --git-dir=$(GIT_REPO_DIR_bsp_local) rev-parse $(GIT_REV_NAME_bsp)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_bsp) in project 'bsp_local'"; \
		else echo "rev is wrong, use for project 'bsp_local' rev $(GIT_REV_NAME_bsp) in makefile GIT_REV_ID_bsp:=" `git --git-dir=$(GIT_REPO_DIR_bsp_local) rev-parse $(GIT_REV_NAME_bsp)`  "(old value: $(GIT_REV_ID_bsp))"; \
		fi ; \
	else \
		echo "Repository: bsp_local $(GIT_REPO_DIR_bsp_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_bsp_local

info_target_check_branch_git_bsp_local : 
	@echo "check_branch_git_bsp_local:	 check rev name and commit id in bsp_local"

INFO_TARGET_LIST += info_target_check_branch_git_bsp_local


##############################
# Create new repository of current bsp and add source code to it
##############################

$(STATE_DIR)/create_new_git_bsp_work: 
	@if [ ! -e  $(GIT_REPO_DIR_bsp_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_bsp_work)) && \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ add .; \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ commit -s; \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ remote add origin $(GIT_REPO_DIR_bsp_local); \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ push origin --tags $(GIT_REV_NAME_bsp) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_bsp_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_bsp_work

create_new_git_bsp_work: $(STATE_DIR)/create_new_git_bsp_work

rm_create_new_git_bsp_work: 
	if [ -e $(STATE_DIR)/create_new_git_bsp_work ]; then rm $(STATE_DIR)/create_new_git_bsp_work; fi

CLEAN_STATE_LIST += rm_create_new_git_bsp_work

info_target_create_new_git_bsp_work : 
	@echo "create_new_git_bsp_work:	 Create new repository of current bsp and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_bsp_work


##############################
# Push changes in  bsp_work to remote repository
##############################

$(STATE_DIR)/push_git_bsp_work: 
	@if [ -e  $(GIT_REPO_DIR_bsp_work) ] ; then \
		A=$$(git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ config remote.origin.url); \
		B="$(GIT_REPO_DIR_bsp_local)"; \
		if [  "x$${A}" != "x$${B}" -a "x$${A}" != "xfile://$${B%.git}" ] ; then \
			git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ remote set-url origin $(GIT_REPO_DIR_bsp_local); \
		fi ; \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ push origin --tags $(GIT_REV_NAME_bsp) ; \
	else \
		echo "Repository doesn't exists: $(GIT_REPO_DIR_bsp_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : push_git_bsp_work

push_git_bsp_work: $(STATE_DIR)/push_git_bsp_work

rm_push_git_bsp_work: 
	if [ -e $(STATE_DIR)/push_git_bsp_work ]; then rm $(STATE_DIR)/push_git_bsp_work; fi

CLEAN_STATE_LIST += rm_push_git_bsp_work

info_target_push_git_bsp_work : 
	@echo "push_git_bsp_work:	 Push changes in  bsp_work to remote repository"

INFO_TARGET_LIST += info_target_push_git_bsp_work


##############################
# Create new git repositories of current bsp and checkout files in new source folder for existing remote repositories 
##############################

$(STATE_DIR)/create_co_git_bsp_work: 
	@if [ ! -e  $(GIT_REPO_DIR_bsp_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_bsp_work)) && \
		echo "Create source code folder, checkout files ." ; \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ remote add origin $(GIT_REPO_DIR_bsp_local); \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ fetch origin ; \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ checkout $(GIT_REV_NAME_bsp) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_bsp_work)" ; \
		exit 1; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_co_git_bsp_work

create_co_git_bsp_work: $(STATE_DIR)/create_co_git_bsp_work

rm_create_co_git_bsp_work: 
	if [ -e $(STATE_DIR)/create_co_git_bsp_work ]; then rm $(STATE_DIR)/create_co_git_bsp_work; fi

CLEAN_STATE_LIST += rm_create_co_git_bsp_work

info_target_create_co_git_bsp_work : 
	@echo "create_co_git_bsp_work:	 Create new git repositories of current bsp and checkout files in new source folder for existing remote repositories "

INFO_TARGET_LIST += info_target_create_co_git_bsp_work


##############################
# Create environment setup file for bsp_work
##############################

$(STATE_DIR)/setup_env_git_bsp_work: 
	@# Create environment setup file for repository bsp
	@mkdir -p $$(dirname $(BSP_DIR)/setup-env)
	@{ \
	echo "# git dir and work_tree "; \
	echo "# Path to ptxdist is added to PATH"; \
	echo "export PATH=$(MY_PD)/tools/bin:$$PATH"; \
	echo "export unset GIT_WORK_TREE"; \
	echo "export unset GIT_DIR"; \
	echo "export WORK_DIR=\"$(GIT_WORK_DIR_bsp_work)/\""; \
	echo "export PS1=\"(ptx-pcm051) \$${PS1}\""; \
	} > $(BSP_DIR)/setup-env
	@echo ""
	@echo "# Environment setup file $(BSP_DIR)/setup-env for bsp has been created"
	@echo "# Look at the contents of the file"
	@echo "cat $(BSP_DIR)/setup-env"
	@echo ""
	@echo "# Open a NEW terminal window and use the setup-env script to define the environment for bsp. "
	@echo "# The path to ptxdist will be setup. You can call just 'ptxdist'"
	@echo "# usage:"
	@echo ""
	@echo "source $(BSP_DIR)/setup-env"
	@echo ""
	@echo "# usage of ptxdist:"
	@echo ""
	@echo "cd \$${WORK_DIR}"
	@echo ""
	@echo "ptxdist"
	@echo ""
	@echo "# usage of git"
	@echo ""
	@echo "cd \$${WORK_DIR}"
	@echo ""
	@echo "git status"
	@echo "git add"
	@echo "git commit -s"
	@echo ""
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : setup_env_git_bsp_work

setup_env_git_bsp_work: $(STATE_DIR)/setup_env_git_bsp_work

rm_setup_env_git_bsp_work: 
	if [ -e $(STATE_DIR)/setup_env_git_bsp_work ]; then rm $(STATE_DIR)/setup_env_git_bsp_work; fi

CLEAN_STATE_LIST += rm_setup_env_git_bsp_work

info_target_setup_env_git_bsp_work : 
	@echo "setup_env_git_bsp_work:	 Create environment setup file for bsp_work"

INFO_TARGET_LIST += info_target_setup_env_git_bsp_work


##############################
# Show examples for applying patches to bsp_work
##############################

apply_patches_git_bsp_work: 
	@echo "# Apply existing patches, with series file"
	@echo "export MY_PATCH=/tmp/patches"
	@echo "nano $$""{MY_PATCH}/series"
	@echo "git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ quiltimport --patches $$""{MY_PATCH} -n"
	@echo "git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ branch -av"
	@echo "git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ log"
	@echo "git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ quiltimport --patches $$""{MY_PATCH} "
	@echo ""
	@echo "# Apply patches from other git-repositories"
	@echo "git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ remote add test-git-01 /tmp/test.git"
	@echo "git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ fetch test-git-01 master "
	@echo "git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ cherry-pick 56816e7e19cb6a64bf996272d6ff1"
	@echo ""
	@echo "# Apply existing patches, WITHOUT series files"
	@echo "git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ am my_patch_files"

.PHONY : apply_patches_git_bsp_work

info_target_apply_patches_git_bsp_work : 
	@echo "apply_patches_git_bsp_work:	 Show examples for applying patches to bsp_work"

INFO_TARGET_LIST += info_target_apply_patches_git_bsp_work


##############################
# show branches in bsp_work
##############################

show_branch_git_bsp_work: 
	@if [  -e  $(GIT_REPO_DIR_bsp_work) ] ; then \
		echo "Repository: bsp_work $(GIT_REPO_DIR_bsp_work)" && \
		echo "HEAD rev: $$(git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ rev-parse HEAD) name: $$(git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ name-rev --name-only HEAD)" && \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ branch -v --no-abbrev ; \
	else \
		echo "Repository: bsp_work $(GIT_REPO_DIR_bsp_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_bsp_work

info_target_show_branch_git_bsp_work : 
	@echo "show_branch_git_bsp_work:	 show branches in bsp_work"

INFO_TARGET_LIST += info_target_show_branch_git_bsp_work


##############################
# start git gui or gitk  for bsp_work
##############################

gui_git_bsp_work: 
	@if [  -e  $(GIT_REPO_DIR_bsp_work) ] ; then \
		cd  $(GIT_REPO_DIR_bsp_work) && gitk --all & \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ gui & \
	fi

.PHONY : gui_git_bsp_work

info_target_gui_git_bsp_work : 
	@echo "gui_git_bsp_work:	 start git gui or gitk  for bsp_work"

INFO_TARGET_LIST += info_target_gui_git_bsp_work


##############################
# check rev name and commit id in bsp_work
##############################

check_branch_git_bsp_work: 
	@if [  -e  $(GIT_REPO_DIR_bsp_work) ] ; then \
		echo "Repository: bsp_work $(GIT_REPO_DIR_bsp_work)" && \
		if [[ "$(GIT_REV_ID_bsp)" == `git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ rev-parse $(GIT_REV_NAME_bsp)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_bsp) in project 'bsp_work'"; \
		else echo "rev is wrong, use for project 'bsp_work' rev $(GIT_REV_NAME_bsp) in makefile GIT_REV_ID_bsp:=" `git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ rev-parse $(GIT_REV_NAME_bsp)`  "(old value: $(GIT_REV_ID_bsp))"; \
		fi ; \
		if [[ "$(GIT_REV_ID_bsp)" == $$(git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ rev-parse HEAD) ]] ;\
		then echo "HEAD is correct for rev $(GIT_REV_NAME_bsp) in project 'bsp_work'"; \
		else echo "HEAD is wrong, check if in the project 'bsp_work' the branch $(GIT_REV_NAME_bsp) is uptodate "; \
		fi ; \
	else \
		echo "Repository: bsp_work $(GIT_REPO_DIR_bsp_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_bsp_work

info_target_check_branch_git_bsp_work : 
	@echo "check_branch_git_bsp_work:	 check rev name and commit id in bsp_work"

INFO_TARGET_LIST += info_target_check_branch_git_bsp_work


##############################
# Create new repository of local repository of ptxdist and add source code to it
##############################

$(STATE_DIR)/create_new_git_ptxdist_local: 
	@if [ ! -e  $(GIT_REPO_DIR_ptxdist_local) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_ptxdist_local)) && \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_local) init --bare; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_ptxdist_local)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_ptxdist_local

create_new_git_ptxdist_local: $(STATE_DIR)/create_new_git_ptxdist_local

rm_create_new_git_ptxdist_local: 
	if [ -e $(STATE_DIR)/create_new_git_ptxdist_local ]; then rm $(STATE_DIR)/create_new_git_ptxdist_local; fi

CLEAN_STATE_LIST += rm_create_new_git_ptxdist_local

info_target_create_new_git_ptxdist_local : 
	@echo "create_new_git_ptxdist_local:	 Create new repository of local repository of ptxdist and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_ptxdist_local


##############################
# show branches in ptxdist_local
##############################

show_branch_git_ptxdist_local: 
	@if [  -e  $(GIT_REPO_DIR_ptxdist_local) ] ; then \
		echo "Repository: ptxdist_local $(GIT_REPO_DIR_ptxdist_local)" && \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_local) branch -v --no-abbrev ; \
	else \
		echo "Repository: ptxdist_local $(GIT_REPO_DIR_ptxdist_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_ptxdist_local

info_target_show_branch_git_ptxdist_local : 
	@echo "show_branch_git_ptxdist_local:	 show branches in ptxdist_local"

INFO_TARGET_LIST += info_target_show_branch_git_ptxdist_local


##############################
# start git gui or gitk  for ptxdist_local
##############################

gui_git_ptxdist_local: 
	@if [  -e  $(GIT_REPO_DIR_ptxdist_local) ] ; then \
		cd  $(GIT_REPO_DIR_ptxdist_local) && gitk --all & \
	fi

.PHONY : gui_git_ptxdist_local

info_target_gui_git_ptxdist_local : 
	@echo "gui_git_ptxdist_local:	 start git gui or gitk  for ptxdist_local"

INFO_TARGET_LIST += info_target_gui_git_ptxdist_local


##############################
# check rev name and commit id in ptxdist_local
##############################

check_branch_git_ptxdist_local: 
	@if [  -e  $(GIT_REPO_DIR_ptxdist_local) ] ; then \
		echo "Repository: ptxdist_local $(GIT_REPO_DIR_ptxdist_local)" && \
		if [[ "$(GIT_REV_ID_ptxdist)" == `git --git-dir=$(GIT_REPO_DIR_ptxdist_local) rev-parse $(GIT_REV_NAME_ptxdist)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_ptxdist) in project 'ptxdist_local'"; \
		else echo "rev is wrong, use for project 'ptxdist_local' rev $(GIT_REV_NAME_ptxdist) in makefile GIT_REV_ID_ptxdist:=" `git --git-dir=$(GIT_REPO_DIR_ptxdist_local) rev-parse $(GIT_REV_NAME_ptxdist)`  "(old value: $(GIT_REV_ID_ptxdist))"; \
		fi ; \
	else \
		echo "Repository: ptxdist_local $(GIT_REPO_DIR_ptxdist_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_ptxdist_local

info_target_check_branch_git_ptxdist_local : 
	@echo "check_branch_git_ptxdist_local:	 check rev name and commit id in ptxdist_local"

INFO_TARGET_LIST += info_target_check_branch_git_ptxdist_local


##############################
# Create new repository of current ptxdist and add source code to it
##############################

$(STATE_DIR)/create_new_git_ptxdist_work: 
	@if [ ! -e  $(GIT_REPO_DIR_ptxdist_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_ptxdist_work)) && \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ add .; \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ commit -s; \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ remote add origin $(GIT_REPO_DIR_ptxdist_local); \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ push origin --tags $(GIT_REV_NAME_ptxdist) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_ptxdist_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_ptxdist_work

create_new_git_ptxdist_work: $(STATE_DIR)/create_new_git_ptxdist_work

rm_create_new_git_ptxdist_work: 
	if [ -e $(STATE_DIR)/create_new_git_ptxdist_work ]; then rm $(STATE_DIR)/create_new_git_ptxdist_work; fi

CLEAN_STATE_LIST += rm_create_new_git_ptxdist_work

info_target_create_new_git_ptxdist_work : 
	@echo "create_new_git_ptxdist_work:	 Create new repository of current ptxdist and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_ptxdist_work


##############################
# Push changes in  ptxdist_work to remote repository
##############################

$(STATE_DIR)/push_git_ptxdist_work: 
	@if [ -e  $(GIT_REPO_DIR_ptxdist_work) ] ; then \
		A=$$(git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ config remote.origin.url); \
		B="$(GIT_REPO_DIR_ptxdist_local)"; \
		if [  "x$${A}" != "x$${B}" -a "x$${A}" != "xfile://$${B%.git}" ] ; then \
			git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ remote set-url origin $(GIT_REPO_DIR_ptxdist_local); \
		fi ; \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ push origin --tags $(GIT_REV_NAME_ptxdist) ; \
	else \
		echo "Repository doesn't exists: $(GIT_REPO_DIR_ptxdist_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : push_git_ptxdist_work

push_git_ptxdist_work: $(STATE_DIR)/push_git_ptxdist_work

rm_push_git_ptxdist_work: 
	if [ -e $(STATE_DIR)/push_git_ptxdist_work ]; then rm $(STATE_DIR)/push_git_ptxdist_work; fi

CLEAN_STATE_LIST += rm_push_git_ptxdist_work

info_target_push_git_ptxdist_work : 
	@echo "push_git_ptxdist_work:	 Push changes in  ptxdist_work to remote repository"

INFO_TARGET_LIST += info_target_push_git_ptxdist_work


##############################
# Create new git repositories of current ptxdist and checkout files in new source folder for existing remote repositories 
##############################

$(STATE_DIR)/create_co_git_ptxdist_work: 
	@if [ ! -e  $(GIT_REPO_DIR_ptxdist_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_ptxdist_work)) && \
		echo "Create source code folder, checkout files ." ; \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ remote add origin $(GIT_REPO_DIR_ptxdist_local); \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ fetch origin ; \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ checkout $(GIT_REV_NAME_ptxdist) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_ptxdist_work)" ; \
		exit 1; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_co_git_ptxdist_work

create_co_git_ptxdist_work: $(STATE_DIR)/create_co_git_ptxdist_work

rm_create_co_git_ptxdist_work: 
	if [ -e $(STATE_DIR)/create_co_git_ptxdist_work ]; then rm $(STATE_DIR)/create_co_git_ptxdist_work; fi

CLEAN_STATE_LIST += rm_create_co_git_ptxdist_work

info_target_create_co_git_ptxdist_work : 
	@echo "create_co_git_ptxdist_work:	 Create new git repositories of current ptxdist and checkout files in new source folder for existing remote repositories "

INFO_TARGET_LIST += info_target_create_co_git_ptxdist_work


##############################
# Show examples for applying patches to ptxdist_work
##############################

apply_patches_git_ptxdist_work: 
	@echo "# Apply existing patches, with series file"
	@echo "export MY_PATCH=/tmp/patches"
	@echo "nano $$""{MY_PATCH}/series"
	@echo "git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ quiltimport --patches $$""{MY_PATCH} -n"
	@echo "git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ branch -av"
	@echo "git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ log"
	@echo "git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ quiltimport --patches $$""{MY_PATCH} "
	@echo ""
	@echo "# Apply patches from other git-repositories"
	@echo "git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ remote add test-git-01 /tmp/test.git"
	@echo "git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ fetch test-git-01 master "
	@echo "git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ cherry-pick 56816e7e19cb6a64bf996272d6ff1"
	@echo ""
	@echo "# Apply existing patches, WITHOUT series files"
	@echo "git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ am my_patch_files"

.PHONY : apply_patches_git_ptxdist_work

info_target_apply_patches_git_ptxdist_work : 
	@echo "apply_patches_git_ptxdist_work:	 Show examples for applying patches to ptxdist_work"

INFO_TARGET_LIST += info_target_apply_patches_git_ptxdist_work


##############################
# show branches in ptxdist_work
##############################

show_branch_git_ptxdist_work: 
	@if [  -e  $(GIT_REPO_DIR_ptxdist_work) ] ; then \
		echo "Repository: ptxdist_work $(GIT_REPO_DIR_ptxdist_work)" && \
		echo "HEAD rev: $$(git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ rev-parse HEAD) name: $$(git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ name-rev --name-only HEAD)" && \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ branch -v --no-abbrev ; \
	else \
		echo "Repository: ptxdist_work $(GIT_REPO_DIR_ptxdist_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_ptxdist_work

info_target_show_branch_git_ptxdist_work : 
	@echo "show_branch_git_ptxdist_work:	 show branches in ptxdist_work"

INFO_TARGET_LIST += info_target_show_branch_git_ptxdist_work


##############################
# start git gui or gitk  for ptxdist_work
##############################

gui_git_ptxdist_work: 
	@if [  -e  $(GIT_REPO_DIR_ptxdist_work) ] ; then \
		cd  $(GIT_REPO_DIR_ptxdist_work) && gitk --all & \
		git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ gui & \
	fi

.PHONY : gui_git_ptxdist_work

info_target_gui_git_ptxdist_work : 
	@echo "gui_git_ptxdist_work:	 start git gui or gitk  for ptxdist_work"

INFO_TARGET_LIST += info_target_gui_git_ptxdist_work


##############################
# check rev name and commit id in ptxdist_work
##############################

check_branch_git_ptxdist_work: 
	@if [  -e  $(GIT_REPO_DIR_ptxdist_work) ] ; then \
		echo "Repository: ptxdist_work $(GIT_REPO_DIR_ptxdist_work)" && \
		if [[ "$(GIT_REV_ID_ptxdist)" == `git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ rev-parse $(GIT_REV_NAME_ptxdist)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_ptxdist) in project 'ptxdist_work'"; \
		else echo "rev is wrong, use for project 'ptxdist_work' rev $(GIT_REV_NAME_ptxdist) in makefile GIT_REV_ID_ptxdist:=" `git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ rev-parse $(GIT_REV_NAME_ptxdist)`  "(old value: $(GIT_REV_ID_ptxdist))"; \
		fi ; \
		if [[ "$(GIT_REV_ID_ptxdist)" == $$(git --git-dir=$(GIT_REPO_DIR_ptxdist_work) --work-tree=$(GIT_WORK_DIR_ptxdist_work)/ rev-parse HEAD) ]] ;\
		then echo "HEAD is correct for rev $(GIT_REV_NAME_ptxdist) in project 'ptxdist_work'"; \
		else echo "HEAD is wrong, check if in the project 'ptxdist_work' the branch $(GIT_REV_NAME_ptxdist) is uptodate "; \
		fi ; \
	else \
		echo "Repository: ptxdist_work $(GIT_REPO_DIR_ptxdist_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_ptxdist_work

info_target_check_branch_git_ptxdist_work : 
	@echo "check_branch_git_ptxdist_work:	 check rev name and commit id in ptxdist_work"

INFO_TARGET_LIST += info_target_check_branch_git_ptxdist_work


##############################
# Create new repository of local repository of barebox and add source code to it
##############################

$(STATE_DIR)/create_new_git_barebox_local: 
	@if [ ! -e  $(GIT_REPO_DIR_barebox_local) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_barebox_local)) && \
		git --git-dir=$(GIT_REPO_DIR_barebox_local) init --bare; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_barebox_local)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_barebox_local

create_new_git_barebox_local: $(STATE_DIR)/create_new_git_barebox_local

rm_create_new_git_barebox_local: 
	if [ -e $(STATE_DIR)/create_new_git_barebox_local ]; then rm $(STATE_DIR)/create_new_git_barebox_local; fi

CLEAN_STATE_LIST += rm_create_new_git_barebox_local

info_target_create_new_git_barebox_local : 
	@echo "create_new_git_barebox_local:	 Create new repository of local repository of barebox and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_barebox_local


##############################
# show branches in barebox_local
##############################

show_branch_git_barebox_local: 
	@if [  -e  $(GIT_REPO_DIR_barebox_local) ] ; then \
		echo "Repository: barebox_local $(GIT_REPO_DIR_barebox_local)" && \
		git --git-dir=$(GIT_REPO_DIR_barebox_local) branch -v --no-abbrev ; \
	else \
		echo "Repository: barebox_local $(GIT_REPO_DIR_barebox_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_barebox_local

info_target_show_branch_git_barebox_local : 
	@echo "show_branch_git_barebox_local:	 show branches in barebox_local"

INFO_TARGET_LIST += info_target_show_branch_git_barebox_local


##############################
# start git gui or gitk  for barebox_local
##############################

gui_git_barebox_local: 
	@if [  -e  $(GIT_REPO_DIR_barebox_local) ] ; then \
		cd  $(GIT_REPO_DIR_barebox_local) && gitk --all & \
	fi

.PHONY : gui_git_barebox_local

info_target_gui_git_barebox_local : 
	@echo "gui_git_barebox_local:	 start git gui or gitk  for barebox_local"

INFO_TARGET_LIST += info_target_gui_git_barebox_local


##############################
# check rev name and commit id in barebox_local
##############################

check_branch_git_barebox_local: 
	@if [  -e  $(GIT_REPO_DIR_barebox_local) ] ; then \
		echo "Repository: barebox_local $(GIT_REPO_DIR_barebox_local)" && \
		if [[ "$(GIT_REV_ID_barebox)" == `git --git-dir=$(GIT_REPO_DIR_barebox_local) rev-parse $(GIT_REV_NAME_barebox)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_barebox) in project 'barebox_local'"; \
		else echo "rev is wrong, use for project 'barebox_local' rev $(GIT_REV_NAME_barebox) in makefile GIT_REV_ID_barebox:=" `git --git-dir=$(GIT_REPO_DIR_barebox_local) rev-parse $(GIT_REV_NAME_barebox)`  "(old value: $(GIT_REV_ID_barebox))"; \
		fi ; \
	else \
		echo "Repository: barebox_local $(GIT_REPO_DIR_barebox_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_barebox_local

info_target_check_branch_git_barebox_local : 
	@echo "check_branch_git_barebox_local:	 check rev name and commit id in barebox_local"

INFO_TARGET_LIST += info_target_check_branch_git_barebox_local


##############################
# Create new repository of current barebox and add source code to it
##############################

$(STATE_DIR)/create_new_git_barebox_work: 
	@if [ ! -e  $(GIT_REPO_DIR_barebox_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_barebox_work)) && \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ add .; \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ commit -s; \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ remote add origin $(GIT_REPO_DIR_barebox_local); \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ push origin --tags $(GIT_REV_NAME_barebox) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_barebox_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_barebox_work

create_new_git_barebox_work: $(STATE_DIR)/create_new_git_barebox_work

rm_create_new_git_barebox_work: 
	if [ -e $(STATE_DIR)/create_new_git_barebox_work ]; then rm $(STATE_DIR)/create_new_git_barebox_work; fi

CLEAN_STATE_LIST += rm_create_new_git_barebox_work

info_target_create_new_git_barebox_work : 
	@echo "create_new_git_barebox_work:	 Create new repository of current barebox and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_barebox_work


##############################
# Push changes in  barebox_work to remote repository
##############################

$(STATE_DIR)/push_git_barebox_work: 
	@if [ -e  $(GIT_REPO_DIR_barebox_work) ] ; then \
		A=$$(git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ config remote.origin.url); \
		B="$(GIT_REPO_DIR_barebox_local)"; \
		if [  "x$${A}" != "x$${B}" -a "x$${A}" != "xfile://$${B%.git}" ] ; then \
			git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ remote set-url origin $(GIT_REPO_DIR_barebox_local); \
		fi ; \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ push origin --tags $(GIT_REV_NAME_barebox) ; \
	else \
		echo "Repository doesn't exists: $(GIT_REPO_DIR_barebox_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : push_git_barebox_work

push_git_barebox_work: $(STATE_DIR)/push_git_barebox_work

rm_push_git_barebox_work: 
	if [ -e $(STATE_DIR)/push_git_barebox_work ]; then rm $(STATE_DIR)/push_git_barebox_work; fi

CLEAN_STATE_LIST += rm_push_git_barebox_work

info_target_push_git_barebox_work : 
	@echo "push_git_barebox_work:	 Push changes in  barebox_work to remote repository"

INFO_TARGET_LIST += info_target_push_git_barebox_work


##############################
# Create new repository of current barebox with ptxdist --git extract barebox
##############################

$(STATE_DIR)/create_new_git_ptxdist_barebox_work: 
	@if [ ! -e  $(GIT_REPO_DIR_barebox_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_barebox_work)) && \
		echo -e "\nA temporary git repository is created by ptxdist --git extract\n" && \
		cd $(BSP_DIR) && \
		$(PTXDIST) clean barebox && \
		$(PTXDIST) --git extract barebox && \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ init&& \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ remote add ptxdist $(GIT_WORK_DIR_barebox_work)/.git&& \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ fetch ptxdist && \
		echo -e "\nThe temporary git repository is removed\n" && \
		cd $(BSP_DIR) && \
		$(PTXDIST) clean barebox && \
		$(PTXDIST) extract barebox && \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ reset --hard ptxdist/master && \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ remote remove ptxdist&& \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ branch $(GIT_REV_NAME_barebox) && \
		echo -e "\n$(GIT_REPO_DIR_barebox_work) has been created which contains all the patches of barebox\n" && \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ remote add origin $(GIT_REPO_DIR_barebox_local)&&  \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ push origin --tags $(GIT_REV_NAME_barebox) &&  \
		 true ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_barebox_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_ptxdist_barebox_work

create_new_git_ptxdist_barebox_work: $(STATE_DIR)/create_new_git_ptxdist_barebox_work

rm_create_new_git_ptxdist_barebox_work: 
	if [ -e $(STATE_DIR)/create_new_git_ptxdist_barebox_work ]; then rm $(STATE_DIR)/create_new_git_ptxdist_barebox_work; fi

CLEAN_STATE_LIST += rm_create_new_git_ptxdist_barebox_work

info_target_create_new_git_ptxdist_barebox_work : 
	@echo "create_new_git_ptxdist_barebox_work:	 Create new repository of current barebox with ptxdist --git extract barebox"

INFO_TARGET_LIST += info_target_create_new_git_ptxdist_barebox_work


##############################
# Create new git repositories of current barebox in existing source code folder for existing remote repositories. No files are overwritten in the source code folder. 
##############################

$(STATE_DIR)/create_src_git_barebox_work: 
	@if [ ! -e  $(GIT_REPO_DIR_barebox_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_barebox_work)) && \
		echo "Folder with files, without .git folder, git reset is used to sync to the current state, without overwriting files."; \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ remote add origin $(GIT_REPO_DIR_barebox_local); \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ fetch origin ; \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ branch $(GIT_REV_NAME_barebox) origin/$(GIT_REV_NAME_barebox) ; \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ reset $(GIT_REV_NAME_barebox) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_barebox_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_src_git_barebox_work

create_src_git_barebox_work: $(STATE_DIR)/create_src_git_barebox_work

rm_create_src_git_barebox_work: 
	if [ -e $(STATE_DIR)/create_src_git_barebox_work ]; then rm $(STATE_DIR)/create_src_git_barebox_work; fi

CLEAN_STATE_LIST += rm_create_src_git_barebox_work

info_target_create_src_git_barebox_work : 
	@echo "create_src_git_barebox_work:	 Create new git repositories of current barebox in existing source code folder for existing remote repositories. No files are overwritten in the source code folder. "

INFO_TARGET_LIST += info_target_create_src_git_barebox_work


##############################
# Create environment setup file for barebox_work
##############################

$(STATE_DIR)/setup_env_git_barebox_work: 
	@# Create environment setup file for repository barebox
	@mkdir -p $$(dirname $(BSP_DIR)/setup-env-git-barebox)
	@{ \
	echo "# git dir and work_tree "; \
	echo "export GIT_WORK_TREE=\"$(GIT_WORK_DIR_barebox_work)/\""; \
	echo "export GIT_DIR=\"$(GIT_REPO_DIR_barebox_work)\""; \
	echo "export WORK_DIR=\"$(GIT_WORK_DIR_barebox_work)/\""; \
	echo "export PS1=\"(barebox-git) \$${PS1}\""; \
	} > $(BSP_DIR)/setup-env-git-barebox
	@echo ""
	@echo "# Environment setup file $(BSP_DIR)/setup-env-git-barebox for barebox has been created"
	@echo "# Look at the contents of the file"
	@echo "cat $(BSP_DIR)/setup-env-git-barebox"
	@echo ""
	@echo "# Open a NEW terminal window and use the setup-env script to define the environment for barebox. "
	@echo "# The macros GIT_WORK_TREE and GIT_DIR will be defined. You can just call 'git' and the right repository will be used. "
	@echo "# usage:"
	@echo ""
	@echo "source $(BSP_DIR)/setup-env-git-barebox"
	@echo ""
	@echo "# usage of git"
	@echo ""
	@echo "git status"
	@echo "git add"
	@echo "git commit -s"
	@echo ""
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : setup_env_git_barebox_work

setup_env_git_barebox_work: $(STATE_DIR)/setup_env_git_barebox_work

rm_setup_env_git_barebox_work: 
	if [ -e $(STATE_DIR)/setup_env_git_barebox_work ]; then rm $(STATE_DIR)/setup_env_git_barebox_work; fi

CLEAN_STATE_LIST += rm_setup_env_git_barebox_work

info_target_setup_env_git_barebox_work : 
	@echo "setup_env_git_barebox_work:	 Create environment setup file for barebox_work"

INFO_TARGET_LIST += info_target_setup_env_git_barebox_work


##############################
# Show examples for applying patches to barebox_work
##############################

apply_patches_git_barebox_work: 
	@echo "# Apply existing patches, with series file"
	@echo "export MY_PATCH=/tmp/patches"
	@echo "nano $$""{MY_PATCH}/series"
	@echo "git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ quiltimport --patches $$""{MY_PATCH} -n"
	@echo "git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ branch -av"
	@echo "git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ log"
	@echo "git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ quiltimport --patches $$""{MY_PATCH} "
	@echo ""
	@echo "# Apply patches from other git-repositories"
	@echo "git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ remote add test-git-01 /tmp/test.git"
	@echo "git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ fetch test-git-01 master "
	@echo "git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ cherry-pick 56816e7e19cb6a64bf996272d6ff1"
	@echo ""
	@echo "# Apply existing patches, WITHOUT series files"
	@echo "git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ am my_patch_files"

.PHONY : apply_patches_git_barebox_work

info_target_apply_patches_git_barebox_work : 
	@echo "apply_patches_git_barebox_work:	 Show examples for applying patches to barebox_work"

INFO_TARGET_LIST += info_target_apply_patches_git_barebox_work


##############################
# Create patches in ptxdist patches folder for barebox_work
##############################

$(STATE_DIR)/create_ptx_patches_git_barebox_work: 
	# Create patch
	mkdir -p $$(dirname $(MY_DEVELOP)/tmp/patch.XXXXX)  && \
	export MY_PATCH=$$(mktemp -d $(MY_DEVELOP)/tmp/patch.XXXXX)  && \
	mkdir -p $${MY_PATCH} && \
	git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ format-patch --subject-prefix="barebox" -o $${MY_PATCH} --start-number $(GIT_START_NUMBER_barebox) $(GIT_REV_ID_barebox_start)..$(GIT_REV_NAME_barebox) && \
	 \
	if [ ! -e $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/barebox-2013.07.0/series ] ; then \
		echo "When the patch dir doesn't exist, create an empty series file and check it in. Later you can checkout an empty series file" &&\
		mkdir -p $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/barebox-2013.07.0 && \
		touch $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/barebox-2013.07.0/series && \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ add $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/barebox-2013.07.0/series && \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ commit -s -m "empty series file" && \
		true ; \
	fi && \
	if [[ "$(GIT_REV_ID_bsp)" != $$(git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ rev-parse HEAD) ]] ; then \
		echo "rev is wrong, use for project in makefile GIT_REV_ID_bsp:=$$(git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ rev-parse HEAD)"; \
		exit 1; \
	fi && \
	echo "rev series is correct for project "; \
	ls -1 $${MY_PATCH} >> $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/barebox-2013.07.0/series && \
	cp $${MY_PATCH}/*.patch $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/barebox-2013.07.0 && \
	nano $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/barebox-2013.07.0/series && \
	cd $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/barebox-2013.07.0 && \
	git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ add series $$(ls -1 $${MY_PATCH}) && \
	git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ commit -s && \
	cat $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/barebox-2013.07.0/series ; 
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_ptx_patches_git_barebox_work

create_ptx_patches_git_barebox_work: $(STATE_DIR)/create_ptx_patches_git_barebox_work

rm_create_ptx_patches_git_barebox_work: 
	if [ -e $(STATE_DIR)/create_ptx_patches_git_barebox_work ]; then rm $(STATE_DIR)/create_ptx_patches_git_barebox_work; fi

CLEAN_STATE_LIST += rm_create_ptx_patches_git_barebox_work

info_target_create_ptx_patches_git_barebox_work : 
	@echo "create_ptx_patches_git_barebox_work:	 Create patches in ptxdist patches folder for barebox_work"

INFO_TARGET_LIST += info_target_create_ptx_patches_git_barebox_work


##############################
# show branches in barebox_work
##############################

show_branch_git_barebox_work: 
	@if [  -e  $(GIT_REPO_DIR_barebox_work) ] ; then \
		echo "Repository: barebox_work $(GIT_REPO_DIR_barebox_work)" && \
		echo "HEAD rev: $$(git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ rev-parse HEAD) name: $$(git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ name-rev --name-only HEAD)" && \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ branch -v --no-abbrev ; \
	else \
		echo "Repository: barebox_work $(GIT_REPO_DIR_barebox_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_barebox_work

info_target_show_branch_git_barebox_work : 
	@echo "show_branch_git_barebox_work:	 show branches in barebox_work"

INFO_TARGET_LIST += info_target_show_branch_git_barebox_work


##############################
# start git gui or gitk  for barebox_work
##############################

gui_git_barebox_work: 
	@if [  -e  $(GIT_REPO_DIR_barebox_work) ] ; then \
		cd  $(GIT_REPO_DIR_barebox_work) && gitk --all & \
		git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ gui & \
	fi

.PHONY : gui_git_barebox_work

info_target_gui_git_barebox_work : 
	@echo "gui_git_barebox_work:	 start git gui or gitk  for barebox_work"

INFO_TARGET_LIST += info_target_gui_git_barebox_work


##############################
# check rev name and commit id in barebox_work
##############################

check_branch_git_barebox_work: 
	@if [  -e  $(GIT_REPO_DIR_barebox_work) ] ; then \
		echo "Repository: barebox_work $(GIT_REPO_DIR_barebox_work)" && \
		if [[ "$(GIT_REV_ID_barebox)" == `git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ rev-parse $(GIT_REV_NAME_barebox)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_barebox) in project 'barebox_work'"; \
		else echo "rev is wrong, use for project 'barebox_work' rev $(GIT_REV_NAME_barebox) in makefile GIT_REV_ID_barebox:=" `git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ rev-parse $(GIT_REV_NAME_barebox)`  "(old value: $(GIT_REV_ID_barebox))"; \
		fi ; \
		if [[ "$(GIT_REV_ID_barebox)" == $$(git --git-dir=$(GIT_REPO_DIR_barebox_work) --work-tree=$(GIT_WORK_DIR_barebox_work)/ rev-parse HEAD) ]] ;\
		then echo "HEAD is correct for rev $(GIT_REV_NAME_barebox) in project 'barebox_work'"; \
		else echo "HEAD is wrong, check if in the project 'barebox_work' the branch $(GIT_REV_NAME_barebox) is uptodate "; \
		fi ; \
	else \
		echo "Repository: barebox_work $(GIT_REPO_DIR_barebox_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_barebox_work

info_target_check_branch_git_barebox_work : 
	@echo "check_branch_git_barebox_work:	 check rev name and commit id in barebox_work"

INFO_TARGET_LIST += info_target_check_branch_git_barebox_work


##############################
# Create new repository of local repository of linux and add source code to it
##############################

$(STATE_DIR)/create_new_git_linux_local: 
	@if [ ! -e  $(GIT_REPO_DIR_linux_local) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_linux_local)) && \
		git --git-dir=$(GIT_REPO_DIR_linux_local) init --bare; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_linux_local)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_linux_local

create_new_git_linux_local: $(STATE_DIR)/create_new_git_linux_local

rm_create_new_git_linux_local: 
	if [ -e $(STATE_DIR)/create_new_git_linux_local ]; then rm $(STATE_DIR)/create_new_git_linux_local; fi

CLEAN_STATE_LIST += rm_create_new_git_linux_local

info_target_create_new_git_linux_local : 
	@echo "create_new_git_linux_local:	 Create new repository of local repository of linux and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_linux_local


##############################
# show branches in linux_local
##############################

show_branch_git_linux_local: 
	@if [  -e  $(GIT_REPO_DIR_linux_local) ] ; then \
		echo "Repository: linux_local $(GIT_REPO_DIR_linux_local)" && \
		git --git-dir=$(GIT_REPO_DIR_linux_local) branch -v --no-abbrev ; \
	else \
		echo "Repository: linux_local $(GIT_REPO_DIR_linux_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_linux_local

info_target_show_branch_git_linux_local : 
	@echo "show_branch_git_linux_local:	 show branches in linux_local"

INFO_TARGET_LIST += info_target_show_branch_git_linux_local


##############################
# start git gui or gitk  for linux_local
##############################

gui_git_linux_local: 
	@if [  -e  $(GIT_REPO_DIR_linux_local) ] ; then \
		cd  $(GIT_REPO_DIR_linux_local) && gitk --all & \
	fi

.PHONY : gui_git_linux_local

info_target_gui_git_linux_local : 
	@echo "gui_git_linux_local:	 start git gui or gitk  for linux_local"

INFO_TARGET_LIST += info_target_gui_git_linux_local


##############################
# check rev name and commit id in linux_local
##############################

check_branch_git_linux_local: 
	@if [  -e  $(GIT_REPO_DIR_linux_local) ] ; then \
		echo "Repository: linux_local $(GIT_REPO_DIR_linux_local)" && \
		if [[ "$(GIT_REV_ID_linux)" == `git --git-dir=$(GIT_REPO_DIR_linux_local) rev-parse $(GIT_REV_NAME_linux)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_linux) in project 'linux_local'"; \
		else echo "rev is wrong, use for project 'linux_local' rev $(GIT_REV_NAME_linux) in makefile GIT_REV_ID_linux:=" `git --git-dir=$(GIT_REPO_DIR_linux_local) rev-parse $(GIT_REV_NAME_linux)`  "(old value: $(GIT_REV_ID_linux))"; \
		fi ; \
	else \
		echo "Repository: linux_local $(GIT_REPO_DIR_linux_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_linux_local

info_target_check_branch_git_linux_local : 
	@echo "check_branch_git_linux_local:	 check rev name and commit id in linux_local"

INFO_TARGET_LIST += info_target_check_branch_git_linux_local


##############################
# Create new repository of current linux and add source code to it
##############################

$(STATE_DIR)/create_new_git_linux_work: 
	@if [ ! -e  $(GIT_REPO_DIR_linux_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_linux_work)) && \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ add .; \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ commit -s; \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ remote add origin $(GIT_REPO_DIR_linux_local); \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ push origin --tags $(GIT_REV_NAME_linux) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_linux_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_linux_work

create_new_git_linux_work: $(STATE_DIR)/create_new_git_linux_work

rm_create_new_git_linux_work: 
	if [ -e $(STATE_DIR)/create_new_git_linux_work ]; then rm $(STATE_DIR)/create_new_git_linux_work; fi

CLEAN_STATE_LIST += rm_create_new_git_linux_work

info_target_create_new_git_linux_work : 
	@echo "create_new_git_linux_work:	 Create new repository of current linux and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_linux_work


##############################
# Push changes in  linux_work to remote repository
##############################

$(STATE_DIR)/push_git_linux_work: 
	@if [ -e  $(GIT_REPO_DIR_linux_work) ] ; then \
		A=$$(git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ config remote.origin.url); \
		B="$(GIT_REPO_DIR_linux_local)"; \
		if [  "x$${A}" != "x$${B}" -a "x$${A}" != "xfile://$${B%.git}" ] ; then \
			git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ remote set-url origin $(GIT_REPO_DIR_linux_local); \
		fi ; \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ push origin --tags $(GIT_REV_NAME_linux) ; \
	else \
		echo "Repository doesn't exists: $(GIT_REPO_DIR_linux_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : push_git_linux_work

push_git_linux_work: $(STATE_DIR)/push_git_linux_work

rm_push_git_linux_work: 
	if [ -e $(STATE_DIR)/push_git_linux_work ]; then rm $(STATE_DIR)/push_git_linux_work; fi

CLEAN_STATE_LIST += rm_push_git_linux_work

info_target_push_git_linux_work : 
	@echo "push_git_linux_work:	 Push changes in  linux_work to remote repository"

INFO_TARGET_LIST += info_target_push_git_linux_work


##############################
# Create new repository of current linux with ptxdist --git extract kernel
##############################

$(STATE_DIR)/create_new_git_ptxdist_linux_work: 
	@if [ ! -e  $(GIT_REPO_DIR_linux_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_linux_work)) && \
		echo -e "\nA temporary git repository is created by ptxdist --git extract\n" && \
		cd $(BSP_DIR) && \
		$(PTXDIST) clean kernel && \
		$(PTXDIST) --git extract kernel && \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ init&& \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ remote add ptxdist $(GIT_WORK_DIR_linux_work)/.git&& \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ fetch ptxdist && \
		echo -e "\nThe temporary git repository is removed\n" && \
		cd $(BSP_DIR) && \
		$(PTXDIST) clean kernel && \
		$(PTXDIST) extract kernel && \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ reset --hard ptxdist/master && \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ remote remove ptxdist&& \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ branch $(GIT_REV_NAME_linux) && \
		echo -e "\n$(GIT_REPO_DIR_linux_work) has been created which contains all the patches of linux\n" && \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ remote add origin $(GIT_REPO_DIR_linux_local)&&  \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ push origin --tags $(GIT_REV_NAME_linux) &&  \
		 true ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_linux_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_ptxdist_linux_work

create_new_git_ptxdist_linux_work: $(STATE_DIR)/create_new_git_ptxdist_linux_work

rm_create_new_git_ptxdist_linux_work: 
	if [ -e $(STATE_DIR)/create_new_git_ptxdist_linux_work ]; then rm $(STATE_DIR)/create_new_git_ptxdist_linux_work; fi

CLEAN_STATE_LIST += rm_create_new_git_ptxdist_linux_work

info_target_create_new_git_ptxdist_linux_work : 
	@echo "create_new_git_ptxdist_linux_work:	 Create new repository of current linux with ptxdist --git extract kernel"

INFO_TARGET_LIST += info_target_create_new_git_ptxdist_linux_work


##############################
# Create new git repositories of current linux in existing source code folder for existing remote repositories. No files are overwritten in the source code folder. 
##############################

$(STATE_DIR)/create_src_git_linux_work: 
	@if [ ! -e  $(GIT_REPO_DIR_linux_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_linux_work)) && \
		echo "Folder with files, without .git folder, git reset is used to sync to the current state, without overwriting files."; \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ remote add origin $(GIT_REPO_DIR_linux_local); \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ fetch origin ; \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ branch $(GIT_REV_NAME_linux) origin/$(GIT_REV_NAME_linux) ; \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ reset $(GIT_REV_NAME_linux) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_linux_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_src_git_linux_work

create_src_git_linux_work: $(STATE_DIR)/create_src_git_linux_work

rm_create_src_git_linux_work: 
	if [ -e $(STATE_DIR)/create_src_git_linux_work ]; then rm $(STATE_DIR)/create_src_git_linux_work; fi

CLEAN_STATE_LIST += rm_create_src_git_linux_work

info_target_create_src_git_linux_work : 
	@echo "create_src_git_linux_work:	 Create new git repositories of current linux in existing source code folder for existing remote repositories. No files are overwritten in the source code folder. "

INFO_TARGET_LIST += info_target_create_src_git_linux_work


##############################
# Create environment setup file for linux_work
##############################

$(STATE_DIR)/setup_env_git_linux_work: 
	@# Create environment setup file for repository linux
	@mkdir -p $$(dirname $(BSP_DIR)/setup-env-git-linux)
	@{ \
	echo "# git dir and work_tree "; \
	echo "export GIT_WORK_TREE=\"$(GIT_WORK_DIR_linux_work)/\""; \
	echo "export GIT_DIR=\"$(GIT_REPO_DIR_linux_work)\""; \
	echo "export WORK_DIR=\"$(GIT_WORK_DIR_linux_work)/\""; \
	echo "export PS1=\"(linux-git) \$${PS1}\""; \
	} > $(BSP_DIR)/setup-env-git-linux
	@echo ""
	@echo "# Environment setup file $(BSP_DIR)/setup-env-git-linux for linux has been created"
	@echo "# Look at the contents of the file"
	@echo "cat $(BSP_DIR)/setup-env-git-linux"
	@echo ""
	@echo "# Open a NEW terminal window and use the setup-env script to define the environment for linux. "
	@echo "# The macros GIT_WORK_TREE and GIT_DIR will be defined. You can just call 'git' and the right repository will be used. "
	@echo "# usage:"
	@echo ""
	@echo "source $(BSP_DIR)/setup-env-git-linux"
	@echo ""
	@echo "# usage of git"
	@echo ""
	@echo "git status"
	@echo "git add"
	@echo "git commit -s"
	@echo ""
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : setup_env_git_linux_work

setup_env_git_linux_work: $(STATE_DIR)/setup_env_git_linux_work

rm_setup_env_git_linux_work: 
	if [ -e $(STATE_DIR)/setup_env_git_linux_work ]; then rm $(STATE_DIR)/setup_env_git_linux_work; fi

CLEAN_STATE_LIST += rm_setup_env_git_linux_work

info_target_setup_env_git_linux_work : 
	@echo "setup_env_git_linux_work:	 Create environment setup file for linux_work"

INFO_TARGET_LIST += info_target_setup_env_git_linux_work


##############################
# Show examples for applying patches to linux_work
##############################

apply_patches_git_linux_work: 
	@echo "# Apply existing patches, with series file"
	@echo "export MY_PATCH=/tmp/patches"
	@echo "nano $$""{MY_PATCH}/series"
	@echo "git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ quiltimport --patches $$""{MY_PATCH} -n"
	@echo "git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ branch -av"
	@echo "git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ log"
	@echo "git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ quiltimport --patches $$""{MY_PATCH} "
	@echo ""
	@echo "# Apply patches from other git-repositories"
	@echo "git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ remote add test-git-01 /tmp/test.git"
	@echo "git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ fetch test-git-01 master "
	@echo "git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ cherry-pick 56816e7e19cb6a64bf996272d6ff1"
	@echo ""
	@echo "# Apply existing patches, WITHOUT series files"
	@echo "git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ am my_patch_files"

.PHONY : apply_patches_git_linux_work

info_target_apply_patches_git_linux_work : 
	@echo "apply_patches_git_linux_work:	 Show examples for applying patches to linux_work"

INFO_TARGET_LIST += info_target_apply_patches_git_linux_work


##############################
# Create patches in ptxdist patches folder for linux_work
##############################

$(STATE_DIR)/create_ptx_patches_git_linux_work: 
	# Create patch
	mkdir -p $$(dirname $(MY_DEVELOP)/tmp/patch.XXXXX)  && \
	export MY_PATCH=$$(mktemp -d $(MY_DEVELOP)/tmp/patch.XXXXX)  && \
	mkdir -p $${MY_PATCH} && \
	git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ format-patch --subject-prefix="linux" -o $${MY_PATCH} --start-number $(GIT_START_NUMBER_linux) $(GIT_REV_ID_linux_start)..$(GIT_REV_NAME_linux) && \
	 \
	if [ ! -e $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/linux-3.2/series ] ; then \
		echo "When the patch dir doesn't exist, create an empty series file and check it in. Later you can checkout an empty series file" &&\
		mkdir -p $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/linux-3.2 && \
		touch $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/linux-3.2/series && \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ add $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/linux-3.2/series && \
		git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ commit -s -m "empty series file" && \
		true ; \
	fi && \
	if [[ "$(GIT_REV_ID_bsp)" != $$(git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ rev-parse HEAD) ]] ; then \
		echo "rev is wrong, use for project in makefile GIT_REV_ID_bsp:=$$(git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ rev-parse HEAD)"; \
		exit 1; \
	fi && \
	echo "rev series is correct for project "; \
	ls -1 $${MY_PATCH} >> $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/linux-3.2/series && \
	cp $${MY_PATCH}/*.patch $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/linux-3.2 && \
	nano $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/linux-3.2/series && \
	cd $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/linux-3.2 && \
	git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ add series $$(ls -1 $${MY_PATCH}) && \
	git --git-dir=$(GIT_REPO_DIR_bsp_work) --work-tree=$(GIT_WORK_DIR_bsp_work)/ commit -s && \
	cat $(BSP_DIR)/configs/phyBOARD-WEGA-AM335x/patches/linux-3.2/series ; 
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_ptx_patches_git_linux_work

create_ptx_patches_git_linux_work: $(STATE_DIR)/create_ptx_patches_git_linux_work

rm_create_ptx_patches_git_linux_work: 
	if [ -e $(STATE_DIR)/create_ptx_patches_git_linux_work ]; then rm $(STATE_DIR)/create_ptx_patches_git_linux_work; fi

CLEAN_STATE_LIST += rm_create_ptx_patches_git_linux_work

info_target_create_ptx_patches_git_linux_work : 
	@echo "create_ptx_patches_git_linux_work:	 Create patches in ptxdist patches folder for linux_work"

INFO_TARGET_LIST += info_target_create_ptx_patches_git_linux_work


##############################
# show branches in linux_work
##############################

show_branch_git_linux_work: 
	@if [  -e  $(GIT_REPO_DIR_linux_work) ] ; then \
		echo "Repository: linux_work $(GIT_REPO_DIR_linux_work)" && \
		echo "HEAD rev: $$(git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ rev-parse HEAD) name: $$(git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ name-rev --name-only HEAD)" && \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ branch -v --no-abbrev ; \
	else \
		echo "Repository: linux_work $(GIT_REPO_DIR_linux_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_linux_work

info_target_show_branch_git_linux_work : 
	@echo "show_branch_git_linux_work:	 show branches in linux_work"

INFO_TARGET_LIST += info_target_show_branch_git_linux_work


##############################
# start git gui or gitk  for linux_work
##############################

gui_git_linux_work: 
	@if [  -e  $(GIT_REPO_DIR_linux_work) ] ; then \
		cd  $(GIT_REPO_DIR_linux_work) && gitk --all & \
		git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ gui & \
	fi

.PHONY : gui_git_linux_work

info_target_gui_git_linux_work : 
	@echo "gui_git_linux_work:	 start git gui or gitk  for linux_work"

INFO_TARGET_LIST += info_target_gui_git_linux_work


##############################
# check rev name and commit id in linux_work
##############################

check_branch_git_linux_work: 
	@if [  -e  $(GIT_REPO_DIR_linux_work) ] ; then \
		echo "Repository: linux_work $(GIT_REPO_DIR_linux_work)" && \
		if [[ "$(GIT_REV_ID_linux)" == `git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ rev-parse $(GIT_REV_NAME_linux)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_linux) in project 'linux_work'"; \
		else echo "rev is wrong, use for project 'linux_work' rev $(GIT_REV_NAME_linux) in makefile GIT_REV_ID_linux:=" `git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ rev-parse $(GIT_REV_NAME_linux)`  "(old value: $(GIT_REV_ID_linux))"; \
		fi ; \
		if [[ "$(GIT_REV_ID_linux)" == $$(git --git-dir=$(GIT_REPO_DIR_linux_work) --work-tree=$(GIT_WORK_DIR_linux_work)/ rev-parse HEAD) ]] ;\
		then echo "HEAD is correct for rev $(GIT_REV_NAME_linux) in project 'linux_work'"; \
		else echo "HEAD is wrong, check if in the project 'linux_work' the branch $(GIT_REV_NAME_linux) is uptodate "; \
		fi ; \
	else \
		echo "Repository: linux_work $(GIT_REPO_DIR_linux_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_linux_work

info_target_check_branch_git_linux_work : 
	@echo "check_branch_git_linux_work:	 check rev name and commit id in linux_work"

INFO_TARGET_LIST += info_target_check_branch_git_linux_work


##############################
# Create new repository of local repository of toolchain and add source code to it
##############################

$(STATE_DIR)/create_new_git_toolchain_local: 
	@if [ ! -e  $(GIT_REPO_DIR_toolchain_local) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_toolchain_local)) && \
		git --git-dir=$(GIT_REPO_DIR_toolchain_local) init --bare; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_toolchain_local)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_toolchain_local

create_new_git_toolchain_local: $(STATE_DIR)/create_new_git_toolchain_local

rm_create_new_git_toolchain_local: 
	if [ -e $(STATE_DIR)/create_new_git_toolchain_local ]; then rm $(STATE_DIR)/create_new_git_toolchain_local; fi

CLEAN_STATE_LIST += rm_create_new_git_toolchain_local

info_target_create_new_git_toolchain_local : 
	@echo "create_new_git_toolchain_local:	 Create new repository of local repository of toolchain and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_toolchain_local


##############################
# show branches in toolchain_local
##############################

show_branch_git_toolchain_local: 
	@if [  -e  $(GIT_REPO_DIR_toolchain_local) ] ; then \
		echo "Repository: toolchain_local $(GIT_REPO_DIR_toolchain_local)" && \
		git --git-dir=$(GIT_REPO_DIR_toolchain_local) branch -v --no-abbrev ; \
	else \
		echo "Repository: toolchain_local $(GIT_REPO_DIR_toolchain_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_toolchain_local

info_target_show_branch_git_toolchain_local : 
	@echo "show_branch_git_toolchain_local:	 show branches in toolchain_local"

INFO_TARGET_LIST += info_target_show_branch_git_toolchain_local


##############################
# start git gui or gitk  for toolchain_local
##############################

gui_git_toolchain_local: 
	@if [  -e  $(GIT_REPO_DIR_toolchain_local) ] ; then \
		cd  $(GIT_REPO_DIR_toolchain_local) && gitk --all & \
	fi

.PHONY : gui_git_toolchain_local

info_target_gui_git_toolchain_local : 
	@echo "gui_git_toolchain_local:	 start git gui or gitk  for toolchain_local"

INFO_TARGET_LIST += info_target_gui_git_toolchain_local


##############################
# check rev name and commit id in toolchain_local
##############################

check_branch_git_toolchain_local: 
	@if [  -e  $(GIT_REPO_DIR_toolchain_local) ] ; then \
		echo "Repository: toolchain_local $(GIT_REPO_DIR_toolchain_local)" && \
		if [[ "$(GIT_REV_ID_toolchain)" == `git --git-dir=$(GIT_REPO_DIR_toolchain_local) rev-parse $(GIT_REV_NAME_toolchain)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_toolchain) in project 'toolchain_local'"; \
		else echo "rev is wrong, use for project 'toolchain_local' rev $(GIT_REV_NAME_toolchain) in makefile GIT_REV_ID_toolchain:=" `git --git-dir=$(GIT_REPO_DIR_toolchain_local) rev-parse $(GIT_REV_NAME_toolchain)`  "(old value: $(GIT_REV_ID_toolchain))"; \
		fi ; \
	else \
		echo "Repository: toolchain_local $(GIT_REPO_DIR_toolchain_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_toolchain_local

info_target_check_branch_git_toolchain_local : 
	@echo "check_branch_git_toolchain_local:	 check rev name and commit id in toolchain_local"

INFO_TARGET_LIST += info_target_check_branch_git_toolchain_local


##############################
# Create new repository of current toolchain and add source code to it
##############################

$(STATE_DIR)/create_new_git_toolchain_work: 
	@if [ ! -e  $(GIT_REPO_DIR_toolchain_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_toolchain_work)) && \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ add .; \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ commit -s; \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ remote add origin $(GIT_REPO_DIR_toolchain_local); \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ push origin --tags $(GIT_REV_NAME_toolchain) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_toolchain_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_toolchain_work

create_new_git_toolchain_work: $(STATE_DIR)/create_new_git_toolchain_work

rm_create_new_git_toolchain_work: 
	if [ -e $(STATE_DIR)/create_new_git_toolchain_work ]; then rm $(STATE_DIR)/create_new_git_toolchain_work; fi

CLEAN_STATE_LIST += rm_create_new_git_toolchain_work

info_target_create_new_git_toolchain_work : 
	@echo "create_new_git_toolchain_work:	 Create new repository of current toolchain and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_toolchain_work


##############################
# Push changes in  toolchain_work to remote repository
##############################

$(STATE_DIR)/push_git_toolchain_work: 
	@if [ -e  $(GIT_REPO_DIR_toolchain_work) ] ; then \
		A=$$(git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ config remote.origin.url); \
		B="$(GIT_REPO_DIR_toolchain_local)"; \
		if [  "x$${A}" != "x$${B}" -a "x$${A}" != "xfile://$${B%.git}" ] ; then \
			git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ remote set-url origin $(GIT_REPO_DIR_toolchain_local); \
		fi ; \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ push origin --tags $(GIT_REV_NAME_toolchain) ; \
	else \
		echo "Repository doesn't exists: $(GIT_REPO_DIR_toolchain_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : push_git_toolchain_work

push_git_toolchain_work: $(STATE_DIR)/push_git_toolchain_work

rm_push_git_toolchain_work: 
	if [ -e $(STATE_DIR)/push_git_toolchain_work ]; then rm $(STATE_DIR)/push_git_toolchain_work; fi

CLEAN_STATE_LIST += rm_push_git_toolchain_work

info_target_push_git_toolchain_work : 
	@echo "push_git_toolchain_work:	 Push changes in  toolchain_work to remote repository"

INFO_TARGET_LIST += info_target_push_git_toolchain_work


##############################
# Create new git repositories of current toolchain and checkout files in new source folder for existing remote repositories 
##############################

$(STATE_DIR)/create_co_git_toolchain_work: 
	@if [ ! -e  $(GIT_REPO_DIR_toolchain_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_toolchain_work)) && \
		echo "Create source code folder, checkout files ." ; \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ remote add origin $(GIT_REPO_DIR_toolchain_local); \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ fetch origin ; \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ checkout $(GIT_REV_NAME_toolchain) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_toolchain_work)" ; \
		exit 1; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_co_git_toolchain_work

create_co_git_toolchain_work: $(STATE_DIR)/create_co_git_toolchain_work

rm_create_co_git_toolchain_work: 
	if [ -e $(STATE_DIR)/create_co_git_toolchain_work ]; then rm $(STATE_DIR)/create_co_git_toolchain_work; fi

CLEAN_STATE_LIST += rm_create_co_git_toolchain_work

info_target_create_co_git_toolchain_work : 
	@echo "create_co_git_toolchain_work:	 Create new git repositories of current toolchain and checkout files in new source folder for existing remote repositories "

INFO_TARGET_LIST += info_target_create_co_git_toolchain_work


##############################
# Show examples for applying patches to toolchain_work
##############################

apply_patches_git_toolchain_work: 
	@echo "# Apply existing patches, with series file"
	@echo "export MY_PATCH=/tmp/patches"
	@echo "nano $$""{MY_PATCH}/series"
	@echo "git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ quiltimport --patches $$""{MY_PATCH} -n"
	@echo "git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ branch -av"
	@echo "git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ log"
	@echo "git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ quiltimport --patches $$""{MY_PATCH} "
	@echo ""
	@echo "# Apply patches from other git-repositories"
	@echo "git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ remote add test-git-01 /tmp/test.git"
	@echo "git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ fetch test-git-01 master "
	@echo "git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ cherry-pick 56816e7e19cb6a64bf996272d6ff1"
	@echo ""
	@echo "# Apply existing patches, WITHOUT series files"
	@echo "git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ am my_patch_files"

.PHONY : apply_patches_git_toolchain_work

info_target_apply_patches_git_toolchain_work : 
	@echo "apply_patches_git_toolchain_work:	 Show examples for applying patches to toolchain_work"

INFO_TARGET_LIST += info_target_apply_patches_git_toolchain_work


##############################
# show branches in toolchain_work
##############################

show_branch_git_toolchain_work: 
	@if [  -e  $(GIT_REPO_DIR_toolchain_work) ] ; then \
		echo "Repository: toolchain_work $(GIT_REPO_DIR_toolchain_work)" && \
		echo "HEAD rev: $$(git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ rev-parse HEAD) name: $$(git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ name-rev --name-only HEAD)" && \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ branch -v --no-abbrev ; \
	else \
		echo "Repository: toolchain_work $(GIT_REPO_DIR_toolchain_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_toolchain_work

info_target_show_branch_git_toolchain_work : 
	@echo "show_branch_git_toolchain_work:	 show branches in toolchain_work"

INFO_TARGET_LIST += info_target_show_branch_git_toolchain_work


##############################
# start git gui or gitk  for toolchain_work
##############################

gui_git_toolchain_work: 
	@if [  -e  $(GIT_REPO_DIR_toolchain_work) ] ; then \
		cd  $(GIT_REPO_DIR_toolchain_work) && gitk --all & \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ gui & \
	fi

.PHONY : gui_git_toolchain_work

info_target_gui_git_toolchain_work : 
	@echo "gui_git_toolchain_work:	 start git gui or gitk  for toolchain_work"

INFO_TARGET_LIST += info_target_gui_git_toolchain_work


##############################
# check rev name and commit id in toolchain_work
##############################

check_branch_git_toolchain_work: 
	@if [  -e  $(GIT_REPO_DIR_toolchain_work) ] ; then \
		echo "Repository: toolchain_work $(GIT_REPO_DIR_toolchain_work)" && \
		if [[ "$(GIT_REV_ID_toolchain)" == `git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ rev-parse $(GIT_REV_NAME_toolchain)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_toolchain) in project 'toolchain_work'"; \
		else echo "rev is wrong, use for project 'toolchain_work' rev $(GIT_REV_NAME_toolchain) in makefile GIT_REV_ID_toolchain:=" `git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ rev-parse $(GIT_REV_NAME_toolchain)`  "(old value: $(GIT_REV_ID_toolchain))"; \
		fi ; \
		if [[ "$(GIT_REV_ID_toolchain)" == $$(git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ rev-parse HEAD) ]] ;\
		then echo "HEAD is correct for rev $(GIT_REV_NAME_toolchain) in project 'toolchain_work'"; \
		else echo "HEAD is wrong, check if in the project 'toolchain_work' the branch $(GIT_REV_NAME_toolchain) is uptodate "; \
		fi ; \
	else \
		echo "Repository: toolchain_work $(GIT_REPO_DIR_toolchain_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_toolchain_work

info_target_check_branch_git_toolchain_work : 
	@echo "check_branch_git_toolchain_work:	 check rev name and commit id in toolchain_work"

INFO_TARGET_LIST += info_target_check_branch_git_toolchain_work


##############################
# Create new repository of local repository of gcc-linaro and add source code to it
##############################

$(STATE_DIR)/create_new_git_gcc-linaro_local: 
	@if [ ! -e  $(GIT_REPO_DIR_gcc-linaro_local) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_gcc-linaro_local)) && \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_local) init --bare; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_gcc-linaro_local)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_gcc-linaro_local

create_new_git_gcc-linaro_local: $(STATE_DIR)/create_new_git_gcc-linaro_local

rm_create_new_git_gcc-linaro_local: 
	if [ -e $(STATE_DIR)/create_new_git_gcc-linaro_local ]; then rm $(STATE_DIR)/create_new_git_gcc-linaro_local; fi

CLEAN_STATE_LIST += rm_create_new_git_gcc-linaro_local

info_target_create_new_git_gcc-linaro_local : 
	@echo "create_new_git_gcc-linaro_local:	 Create new repository of local repository of gcc-linaro and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_gcc-linaro_local


##############################
# show branches in gcc-linaro_local
##############################

show_branch_git_gcc-linaro_local: 
	@if [  -e  $(GIT_REPO_DIR_gcc-linaro_local) ] ; then \
		echo "Repository: gcc-linaro_local $(GIT_REPO_DIR_gcc-linaro_local)" && \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_local) branch -v --no-abbrev ; \
	else \
		echo "Repository: gcc-linaro_local $(GIT_REPO_DIR_gcc-linaro_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_gcc-linaro_local

info_target_show_branch_git_gcc-linaro_local : 
	@echo "show_branch_git_gcc-linaro_local:	 show branches in gcc-linaro_local"

INFO_TARGET_LIST += info_target_show_branch_git_gcc-linaro_local


##############################
# start git gui or gitk  for gcc-linaro_local
##############################

gui_git_gcc-linaro_local: 
	@if [  -e  $(GIT_REPO_DIR_gcc-linaro_local) ] ; then \
		cd  $(GIT_REPO_DIR_gcc-linaro_local) && gitk --all & \
	fi

.PHONY : gui_git_gcc-linaro_local

info_target_gui_git_gcc-linaro_local : 
	@echo "gui_git_gcc-linaro_local:	 start git gui or gitk  for gcc-linaro_local"

INFO_TARGET_LIST += info_target_gui_git_gcc-linaro_local


##############################
# check rev name and commit id in gcc-linaro_local
##############################

check_branch_git_gcc-linaro_local: 
	@if [  -e  $(GIT_REPO_DIR_gcc-linaro_local) ] ; then \
		echo "Repository: gcc-linaro_local $(GIT_REPO_DIR_gcc-linaro_local)" && \
		if [[ "$(GIT_REV_ID_gcc-linaro)" == `git --git-dir=$(GIT_REPO_DIR_gcc-linaro_local) rev-parse $(GIT_REV_NAME_gcc-linaro)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_gcc-linaro) in project 'gcc-linaro_local'"; \
		else echo "rev is wrong, use for project 'gcc-linaro_local' rev $(GIT_REV_NAME_gcc-linaro) in makefile GIT_REV_ID_gcc-linaro:=" `git --git-dir=$(GIT_REPO_DIR_gcc-linaro_local) rev-parse $(GIT_REV_NAME_gcc-linaro)`  "(old value: $(GIT_REV_ID_gcc-linaro))"; \
		fi ; \
	else \
		echo "Repository: gcc-linaro_local $(GIT_REPO_DIR_gcc-linaro_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_gcc-linaro_local

info_target_check_branch_git_gcc-linaro_local : 
	@echo "check_branch_git_gcc-linaro_local:	 check rev name and commit id in gcc-linaro_local"

INFO_TARGET_LIST += info_target_check_branch_git_gcc-linaro_local


##############################
# Create new repository of current gcc-linaro and add source code to it
##############################

$(STATE_DIR)/create_new_git_gcc-linaro_work: 
	@if [ ! -e  $(GIT_REPO_DIR_gcc-linaro_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_gcc-linaro_work)) && \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ add .; \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ commit -s; \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ remote add origin $(GIT_REPO_DIR_gcc-linaro_local); \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ push origin --tags $(GIT_REV_NAME_gcc-linaro) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_gcc-linaro_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_gcc-linaro_work

create_new_git_gcc-linaro_work: $(STATE_DIR)/create_new_git_gcc-linaro_work

rm_create_new_git_gcc-linaro_work: 
	if [ -e $(STATE_DIR)/create_new_git_gcc-linaro_work ]; then rm $(STATE_DIR)/create_new_git_gcc-linaro_work; fi

CLEAN_STATE_LIST += rm_create_new_git_gcc-linaro_work

info_target_create_new_git_gcc-linaro_work : 
	@echo "create_new_git_gcc-linaro_work:	 Create new repository of current gcc-linaro and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_gcc-linaro_work


##############################
# Push changes in  gcc-linaro_work to remote repository
##############################

$(STATE_DIR)/push_git_gcc-linaro_work: 
	@if [ -e  $(GIT_REPO_DIR_gcc-linaro_work) ] ; then \
		A=$$(git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ config remote.origin.url); \
		B="$(GIT_REPO_DIR_gcc-linaro_local)"; \
		if [  "x$${A}" != "x$${B}" -a "x$${A}" != "xfile://$${B%.git}" ] ; then \
			git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ remote set-url origin $(GIT_REPO_DIR_gcc-linaro_local); \
		fi ; \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ push origin --tags $(GIT_REV_NAME_gcc-linaro) ; \
	else \
		echo "Repository doesn't exists: $(GIT_REPO_DIR_gcc-linaro_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : push_git_gcc-linaro_work

push_git_gcc-linaro_work: $(STATE_DIR)/push_git_gcc-linaro_work

rm_push_git_gcc-linaro_work: 
	if [ -e $(STATE_DIR)/push_git_gcc-linaro_work ]; then rm $(STATE_DIR)/push_git_gcc-linaro_work; fi

CLEAN_STATE_LIST += rm_push_git_gcc-linaro_work

info_target_push_git_gcc-linaro_work : 
	@echo "push_git_gcc-linaro_work:	 Push changes in  gcc-linaro_work to remote repository"

INFO_TARGET_LIST += info_target_push_git_gcc-linaro_work


##############################
# Create new repository of current gcc-linaro with ptxdist --git extract cross-gcc
##############################

$(STATE_DIR)/create_new_git_ptxdist_gcc-linaro_work: 
	@if [ ! -e  $(GIT_REPO_DIR_gcc-linaro_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_gcc-linaro_work)) && \
		echo -e "\nA temporary git repository is created by ptxdist --git extract\n" && \
		cd $(MY_PD)/OSELAS.Toolchain-2012.12.1 && \
		$(PTXDIST) clean cross-gcc && \
		$(PTXDIST) --git extract cross-gcc && \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ init&& \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ remote add ptxdist $(GIT_WORK_DIR_gcc-linaro_work)/.git&& \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ fetch ptxdist && \
		echo -e "\nThe temporary git repository is removed\n" && \
		cd $(MY_PD)/OSELAS.Toolchain-2012.12.1 && \
		$(PTXDIST) clean cross-gcc && \
		$(PTXDIST) extract cross-gcc && \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ reset --hard ptxdist/master && \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ remote remove ptxdist&& \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ branch $(GIT_REV_NAME_gcc-linaro) && \
		echo -e "\n$(GIT_REPO_DIR_gcc-linaro_work) has been created which contains all the patches of gcc-linaro\n" && \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ remote add origin $(GIT_REPO_DIR_gcc-linaro_local)&&  \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ push origin --tags $(GIT_REV_NAME_gcc-linaro) &&  \
		 true ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_gcc-linaro_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_ptxdist_gcc-linaro_work

create_new_git_ptxdist_gcc-linaro_work: $(STATE_DIR)/create_new_git_ptxdist_gcc-linaro_work

rm_create_new_git_ptxdist_gcc-linaro_work: 
	if [ -e $(STATE_DIR)/create_new_git_ptxdist_gcc-linaro_work ]; then rm $(STATE_DIR)/create_new_git_ptxdist_gcc-linaro_work; fi

CLEAN_STATE_LIST += rm_create_new_git_ptxdist_gcc-linaro_work

info_target_create_new_git_ptxdist_gcc-linaro_work : 
	@echo "create_new_git_ptxdist_gcc-linaro_work:	 Create new repository of current gcc-linaro with ptxdist --git extract cross-gcc"

INFO_TARGET_LIST += info_target_create_new_git_ptxdist_gcc-linaro_work


##############################
# Create new git repositories of current gcc-linaro in existing source code folder for existing remote repositories. No files are overwritten in the source code folder. 
##############################

$(STATE_DIR)/create_src_git_gcc-linaro_work: 
	@if [ ! -e  $(GIT_REPO_DIR_gcc-linaro_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_gcc-linaro_work)) && \
		echo "Folder with files, without .git folder, git reset is used to sync to the current state, without overwriting files."; \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ remote add origin $(GIT_REPO_DIR_gcc-linaro_local); \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ fetch origin ; \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ branch $(GIT_REV_NAME_gcc-linaro) origin/$(GIT_REV_NAME_gcc-linaro) ; \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ reset $(GIT_REV_NAME_gcc-linaro) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_gcc-linaro_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_src_git_gcc-linaro_work

create_src_git_gcc-linaro_work: $(STATE_DIR)/create_src_git_gcc-linaro_work

rm_create_src_git_gcc-linaro_work: 
	if [ -e $(STATE_DIR)/create_src_git_gcc-linaro_work ]; then rm $(STATE_DIR)/create_src_git_gcc-linaro_work; fi

CLEAN_STATE_LIST += rm_create_src_git_gcc-linaro_work

info_target_create_src_git_gcc-linaro_work : 
	@echo "create_src_git_gcc-linaro_work:	 Create new git repositories of current gcc-linaro in existing source code folder for existing remote repositories. No files are overwritten in the source code folder. "

INFO_TARGET_LIST += info_target_create_src_git_gcc-linaro_work


##############################
# Create environment setup file for gcc-linaro_work
##############################

$(STATE_DIR)/setup_env_git_gcc-linaro_work: 
	@# Create environment setup file for repository gcc-linaro
	@mkdir -p $$(dirname $(MY_PD)/OSELAS.Toolchain-2012.12.1/setup-env-git-gcc-linaro)
	@{ \
	echo "# git dir and work_tree "; \
	echo "export GIT_WORK_TREE=\"$(GIT_WORK_DIR_gcc-linaro_work)/\""; \
	echo "export GIT_DIR=\"$(GIT_REPO_DIR_gcc-linaro_work)\""; \
	echo "export WORK_DIR=\"$(GIT_WORK_DIR_gcc-linaro_work)/\""; \
	echo "export PS1=\"(gcc-linaro-git) \$${PS1}\""; \
	} > $(MY_PD)/OSELAS.Toolchain-2012.12.1/setup-env-git-gcc-linaro
	@echo ""
	@echo "# Environment setup file $(MY_PD)/OSELAS.Toolchain-2012.12.1/setup-env-git-gcc-linaro for gcc-linaro has been created"
	@echo "# Look at the contents of the file"
	@echo "cat $(MY_PD)/OSELAS.Toolchain-2012.12.1/setup-env-git-gcc-linaro"
	@echo ""
	@echo "# Open a NEW terminal window and use the setup-env script to define the environment for gcc-linaro. "
	@echo "# The macros GIT_WORK_TREE and GIT_DIR will be defined. You can just call 'git' and the right repository will be used. "
	@echo "# usage:"
	@echo ""
	@echo "source $(MY_PD)/OSELAS.Toolchain-2012.12.1/setup-env-git-gcc-linaro"
	@echo ""
	@echo "# usage of git"
	@echo ""
	@echo "git status"
	@echo "git add"
	@echo "git commit -s"
	@echo ""
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : setup_env_git_gcc-linaro_work

setup_env_git_gcc-linaro_work: $(STATE_DIR)/setup_env_git_gcc-linaro_work

rm_setup_env_git_gcc-linaro_work: 
	if [ -e $(STATE_DIR)/setup_env_git_gcc-linaro_work ]; then rm $(STATE_DIR)/setup_env_git_gcc-linaro_work; fi

CLEAN_STATE_LIST += rm_setup_env_git_gcc-linaro_work

info_target_setup_env_git_gcc-linaro_work : 
	@echo "setup_env_git_gcc-linaro_work:	 Create environment setup file for gcc-linaro_work"

INFO_TARGET_LIST += info_target_setup_env_git_gcc-linaro_work


##############################
# Show examples for applying patches to gcc-linaro_work
##############################

apply_patches_git_gcc-linaro_work: 
	@echo "# Apply existing patches, with series file"
	@echo "export MY_PATCH=/tmp/patches"
	@echo "nano $$""{MY_PATCH}/series"
	@echo "git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ quiltimport --patches $$""{MY_PATCH} -n"
	@echo "git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ branch -av"
	@echo "git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ log"
	@echo "git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ quiltimport --patches $$""{MY_PATCH} "
	@echo ""
	@echo "# Apply patches from other git-repositories"
	@echo "git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ remote add test-git-01 /tmp/test.git"
	@echo "git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ fetch test-git-01 master "
	@echo "git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ cherry-pick 56816e7e19cb6a64bf996272d6ff1"
	@echo ""
	@echo "# Apply existing patches, WITHOUT series files"
	@echo "git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ am my_patch_files"

.PHONY : apply_patches_git_gcc-linaro_work

info_target_apply_patches_git_gcc-linaro_work : 
	@echo "apply_patches_git_gcc-linaro_work:	 Show examples for applying patches to gcc-linaro_work"

INFO_TARGET_LIST += info_target_apply_patches_git_gcc-linaro_work


##############################
# Create patches in ptxdist patches folder for gcc-linaro_work
##############################

$(STATE_DIR)/create_ptx_patches_git_gcc-linaro_work: 
	# Create patch
	mkdir -p $$(dirname $(MY_DEVELOP)/tmp/patch.XXXXX)  && \
	export MY_PATCH=$$(mktemp -d $(MY_DEVELOP)/tmp/patch.XXXXX)  && \
	mkdir -p $${MY_PATCH} && \
	git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ format-patch --subject-prefix="gcc-linaro" -o $${MY_PATCH} --start-number $(GIT_START_NUMBER_gcc-linaro) $(GIT_REV_ID_gcc-linaro_start)..$(GIT_REV_NAME_gcc-linaro) && \
	 \
	if [ ! -e $(MY_PD)/OSELAS.Toolchain-2012.12.1/patches/gcc-linaro-4.6-2011.11/series ] ; then \
		echo "When the patch dir doesn't exist, create an empty series file and check it in. Later you can checkout an empty series file" &&\
		mkdir -p $(MY_PD)/OSELAS.Toolchain-2012.12.1/patches/gcc-linaro-4.6-2011.11 && \
		touch $(MY_PD)/OSELAS.Toolchain-2012.12.1/patches/gcc-linaro-4.6-2011.11/series && \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ add $(MY_PD)/OSELAS.Toolchain-2012.12.1/patches/gcc-linaro-4.6-2011.11/series && \
		git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ commit -s -m "empty series file" && \
		true ; \
	fi && \
	echo "rev is unknown, use for project $$(git --git-dir=$(GIT_REPO_DIR_toolchain_work) --work-tree=$(GIT_WORK_DIR_toolchain_work)/ rev-parse HEAD)";
	exit 1;
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_ptx_patches_git_gcc-linaro_work

create_ptx_patches_git_gcc-linaro_work: $(STATE_DIR)/create_ptx_patches_git_gcc-linaro_work

rm_create_ptx_patches_git_gcc-linaro_work: 
	if [ -e $(STATE_DIR)/create_ptx_patches_git_gcc-linaro_work ]; then rm $(STATE_DIR)/create_ptx_patches_git_gcc-linaro_work; fi

CLEAN_STATE_LIST += rm_create_ptx_patches_git_gcc-linaro_work

info_target_create_ptx_patches_git_gcc-linaro_work : 
	@echo "create_ptx_patches_git_gcc-linaro_work:	 Create patches in ptxdist patches folder for gcc-linaro_work"

INFO_TARGET_LIST += info_target_create_ptx_patches_git_gcc-linaro_work


##############################
# show branches in gcc-linaro_work
##############################

show_branch_git_gcc-linaro_work: 
	@if [  -e  $(GIT_REPO_DIR_gcc-linaro_work) ] ; then \
		echo "Repository: gcc-linaro_work $(GIT_REPO_DIR_gcc-linaro_work)" && \
		echo "HEAD rev: $$(git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ rev-parse HEAD) name: $$(git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ name-rev --name-only HEAD)" && \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ branch -v --no-abbrev ; \
	else \
		echo "Repository: gcc-linaro_work $(GIT_REPO_DIR_gcc-linaro_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_gcc-linaro_work

info_target_show_branch_git_gcc-linaro_work : 
	@echo "show_branch_git_gcc-linaro_work:	 show branches in gcc-linaro_work"

INFO_TARGET_LIST += info_target_show_branch_git_gcc-linaro_work


##############################
# start git gui or gitk  for gcc-linaro_work
##############################

gui_git_gcc-linaro_work: 
	@if [  -e  $(GIT_REPO_DIR_gcc-linaro_work) ] ; then \
		cd  $(GIT_REPO_DIR_gcc-linaro_work) && gitk --all & \
		git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ gui & \
	fi

.PHONY : gui_git_gcc-linaro_work

info_target_gui_git_gcc-linaro_work : 
	@echo "gui_git_gcc-linaro_work:	 start git gui or gitk  for gcc-linaro_work"

INFO_TARGET_LIST += info_target_gui_git_gcc-linaro_work


##############################
# check rev name and commit id in gcc-linaro_work
##############################

check_branch_git_gcc-linaro_work: 
	@if [  -e  $(GIT_REPO_DIR_gcc-linaro_work) ] ; then \
		echo "Repository: gcc-linaro_work $(GIT_REPO_DIR_gcc-linaro_work)" && \
		if [[ "$(GIT_REV_ID_gcc-linaro)" == `git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ rev-parse $(GIT_REV_NAME_gcc-linaro)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_gcc-linaro) in project 'gcc-linaro_work'"; \
		else echo "rev is wrong, use for project 'gcc-linaro_work' rev $(GIT_REV_NAME_gcc-linaro) in makefile GIT_REV_ID_gcc-linaro:=" `git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ rev-parse $(GIT_REV_NAME_gcc-linaro)`  "(old value: $(GIT_REV_ID_gcc-linaro))"; \
		fi ; \
		if [[ "$(GIT_REV_ID_gcc-linaro)" == $$(git --git-dir=$(GIT_REPO_DIR_gcc-linaro_work) --work-tree=$(GIT_WORK_DIR_gcc-linaro_work)/ rev-parse HEAD) ]] ;\
		then echo "HEAD is correct for rev $(GIT_REV_NAME_gcc-linaro) in project 'gcc-linaro_work'"; \
		else echo "HEAD is wrong, check if in the project 'gcc-linaro_work' the branch $(GIT_REV_NAME_gcc-linaro) is uptodate "; \
		fi ; \
	else \
		echo "Repository: gcc-linaro_work $(GIT_REPO_DIR_gcc-linaro_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_gcc-linaro_work

info_target_check_branch_git_gcc-linaro_work : 
	@echo "check_branch_git_gcc-linaro_work:	 check rev name and commit id in gcc-linaro_work"

INFO_TARGET_LIST += info_target_check_branch_git_gcc-linaro_work


##############################
# Create Repository of local repository of tftpboot
##############################

$(STATE_DIR)/create_git_tftpboot_local: 
	@if [ ! -e  $(GIT_REPO_DIR_tftpboot_local) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_tftpboot_local)) && \
		git clone --bare $(GIT_REPO_DIR_tftpboot_remote) $(GIT_REPO_DIR_tftpboot_local); \
	else \
		A=$$(git --git-dir=$(GIT_REPO_DIR_tftpboot_local) config remote.origin.url); \
		B="$(GIT_REPO_DIR_tftpboot_remote)"; \
		if [  "x$${A}" != "x$${B}" -a "x$${A}" != "xfile://$${B%.git}" ] ; then \
			git --git-dir=$(GIT_REPO_DIR_tftpboot_local) remote set-url origin $(GIT_REPO_DIR_tftpboot_remote); \
		fi ; \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_local) fetch  origin ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_git_tftpboot_local

create_git_tftpboot_local: $(STATE_DIR)/create_git_tftpboot_local

rm_create_git_tftpboot_local: 
	if [ -e $(STATE_DIR)/create_git_tftpboot_local ]; then rm $(STATE_DIR)/create_git_tftpboot_local; fi

CLEAN_STATE_LIST += rm_create_git_tftpboot_local

info_target_create_git_tftpboot_local : 
	@echo "create_git_tftpboot_local:	 Create Repository of local repository of tftpboot"

INFO_TARGET_LIST += info_target_create_git_tftpboot_local


##############################
# Create new repository of local repository of tftpboot and add source code to it
##############################

$(STATE_DIR)/create_new_git_tftpboot_local: 
	@if [ ! -e  $(GIT_REPO_DIR_tftpboot_local) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_tftpboot_local)) && \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_local) init --bare; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_tftpboot_local)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_tftpboot_local

create_new_git_tftpboot_local: $(STATE_DIR)/create_new_git_tftpboot_local

rm_create_new_git_tftpboot_local: 
	if [ -e $(STATE_DIR)/create_new_git_tftpboot_local ]; then rm $(STATE_DIR)/create_new_git_tftpboot_local; fi

CLEAN_STATE_LIST += rm_create_new_git_tftpboot_local

info_target_create_new_git_tftpboot_local : 
	@echo "create_new_git_tftpboot_local:	 Create new repository of local repository of tftpboot and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_tftpboot_local


##############################
# Create git bundle for tftpboot_local
##############################

$(STATE_DIR)/create_bundle_git_tftpboot_local: 
	mkdir -p $$(dirname $(DISTRIB_OUT)/bundles/tftpboot-phyBOARD-WEGA.bundle)
	git --git-dir=$(GIT_REPO_DIR_tftpboot_local) bundle create $(DISTRIB_OUT)/bundles/tftpboot-phyBOARD-WEGA.bundle $(GIT_REV_NAME_tftpboot)
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_bundle_git_tftpboot_local

create_bundle_git_tftpboot_local: $(STATE_DIR)/create_bundle_git_tftpboot_local

rm_create_bundle_git_tftpboot_local: 
	if [ -e $(STATE_DIR)/create_bundle_git_tftpboot_local ]; then rm $(STATE_DIR)/create_bundle_git_tftpboot_local; fi

CLEAN_STATE_LIST += rm_create_bundle_git_tftpboot_local

info_target_create_bundle_git_tftpboot_local : 
	@echo "create_bundle_git_tftpboot_local:	 Create git bundle for tftpboot_local"

INFO_TARGET_LIST += info_target_create_bundle_git_tftpboot_local


##############################
# Add or overwrite tag in tftpboot_local
##############################

$(STATE_DIR)/set_tag_git_tftpboot_local: 
	git --git-dir=$(GIT_REPO_DIR_tftpboot_local) tag -f -a -m "Distribution $(MY_VERSION)" distrib-$(MY_VERSION) $(GIT_REV_NAME_tftpboot)
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : set_tag_git_tftpboot_local

set_tag_git_tftpboot_local: $(STATE_DIR)/set_tag_git_tftpboot_local

rm_set_tag_git_tftpboot_local: 
	if [ -e $(STATE_DIR)/set_tag_git_tftpboot_local ]; then rm $(STATE_DIR)/set_tag_git_tftpboot_local; fi

CLEAN_STATE_LIST += rm_set_tag_git_tftpboot_local

info_target_set_tag_git_tftpboot_local : 
	@echo "set_tag_git_tftpboot_local:	 Add or overwrite tag in tftpboot_local"

INFO_TARGET_LIST += info_target_set_tag_git_tftpboot_local


##############################
# show branches in tftpboot_local
##############################

show_branch_git_tftpboot_local: 
	@if [  -e  $(GIT_REPO_DIR_tftpboot_local) ] ; then \
		echo "Repository: tftpboot_local $(GIT_REPO_DIR_tftpboot_local)" && \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_local) branch -v --no-abbrev ; \
	else \
		echo "Repository: tftpboot_local $(GIT_REPO_DIR_tftpboot_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_tftpboot_local

info_target_show_branch_git_tftpboot_local : 
	@echo "show_branch_git_tftpboot_local:	 show branches in tftpboot_local"

INFO_TARGET_LIST += info_target_show_branch_git_tftpboot_local


##############################
# start git gui or gitk  for tftpboot_local
##############################

gui_git_tftpboot_local: 
	@if [  -e  $(GIT_REPO_DIR_tftpboot_local) ] ; then \
		cd  $(GIT_REPO_DIR_tftpboot_local) && gitk --all & \
	fi

.PHONY : gui_git_tftpboot_local

info_target_gui_git_tftpboot_local : 
	@echo "gui_git_tftpboot_local:	 start git gui or gitk  for tftpboot_local"

INFO_TARGET_LIST += info_target_gui_git_tftpboot_local


##############################
# check rev name and commit id in tftpboot_local
##############################

check_branch_git_tftpboot_local: 
	@if [  -e  $(GIT_REPO_DIR_tftpboot_local) ] ; then \
		echo "Repository: tftpboot_local $(GIT_REPO_DIR_tftpboot_local)" && \
		if [[ "$(GIT_REV_ID_tftpboot)" == `git --git-dir=$(GIT_REPO_DIR_tftpboot_local) rev-parse $(GIT_REV_NAME_tftpboot)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_tftpboot) in project 'tftpboot_local'"; \
		else echo "rev is wrong, use for project 'tftpboot_local' rev $(GIT_REV_NAME_tftpboot) in makefile GIT_REV_ID_tftpboot:=" `git --git-dir=$(GIT_REPO_DIR_tftpboot_local) rev-parse $(GIT_REV_NAME_tftpboot)`  "(old value: $(GIT_REV_ID_tftpboot))"; \
		fi ; \
	else \
		echo "Repository: tftpboot_local $(GIT_REPO_DIR_tftpboot_local) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_tftpboot_local

info_target_check_branch_git_tftpboot_local : 
	@echo "check_branch_git_tftpboot_local:	 check rev name and commit id in tftpboot_local"

INFO_TARGET_LIST += info_target_check_branch_git_tftpboot_local


##############################
# show commit id of release branch in tftpboot_local
##############################

show_release_git_tftpboot_local: 
	@if [  -e  $(GIT_REPO_DIR_tftpboot_local) ] ; then \
		if [[ "$(GIT_REV_ID_tftpboot)" == `git --git-dir=$(GIT_REPO_DIR_tftpboot_local) rev-parse $(GIT_REV_NAME_tftpboot)` ]] ;\
		then echo -e "tftpboot_local \t$(GIT_REV_NAME_tftpboot) \t$(GIT_REV_ID_tftpboot)"; \
		else echo "rev is wrong, use for project 'tftpboot_local' rev $(GIT_REV_NAME_tftpboot) in makefile GIT_REV_ID_tftpboot:=" `git --git-dir=$(GIT_REPO_DIR_tftpboot_local) rev-parse $(GIT_REV_NAME_tftpboot)` " (old value: $(GIT_REV_ID_tftpboot))"; exit 1; \
		fi ; \
	else \
		echo "Repository: tftpboot_local $(GIT_REPO_DIR_tftpboot_local) doesn't exist !!"; exit 1; \
	fi
	@echo

.PHONY : show_release_git_tftpboot_local

info_target_show_release_git_tftpboot_local : 
	@echo "show_release_git_tftpboot_local:	 show commit id of release branch in tftpboot_local"

INFO_TARGET_LIST += info_target_show_release_git_tftpboot_local


##############################
# Download bundle of tftpboot_local
##############################

$(STATE_DIR)/download_bundle_git_tftpboot_local: 
	# Download bundles from remote server
	@if [ -e $(GIT_REPO_DIR_tftpboot_remote) ] ; then  \
		echo "File $(GIT_REPO_DIR_tftpboot_remote) already exists!! "; \
		echo "If you want to download  $(GIT_REPO_DIR_tftpboot_remote_url) again, remove at first $(GIT_REPO_DIR_tftpboot_remote)."; \
		exit 0;  \
	fi 
	mkdir -p $$(dirname $(GIT_REPO_DIR_tftpboot_remote)) ;
	if [ -e $(GIT_REPO_DIR_tftpboot_remote_url) ] ; then  \
		cp $(GIT_REPO_DIR_tftpboot_remote_url) $(GIT_REPO_DIR_tftpboot_remote); \
	else 
		wget -O $(GIT_REPO_DIR_tftpboot_remote) $(GIT_REPO_DIR_tftpboot_remote_url); \
	fi ;
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : download_bundle_git_tftpboot_local

download_bundle_git_tftpboot_local: $(STATE_DIR)/download_bundle_git_tftpboot_local

rm_download_bundle_git_tftpboot_local: 
	if [ -e $(STATE_DIR)/download_bundle_git_tftpboot_local ]; then rm $(STATE_DIR)/download_bundle_git_tftpboot_local; fi

CLEAN_STATE_LIST += rm_download_bundle_git_tftpboot_local

info_target_download_bundle_git_tftpboot_local : 
	@echo "download_bundle_git_tftpboot_local:	 Download bundle of tftpboot_local"

INFO_TARGET_LIST += info_target_download_bundle_git_tftpboot_local


##############################
# Create new repository of current tftpboot and add source code to it
##############################

$(STATE_DIR)/create_new_git_tftpboot_work: 
	@if [ ! -e  $(GIT_REPO_DIR_tftpboot_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_tftpboot_work)) && \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ add .; \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ commit -s; \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ remote add origin $(GIT_REPO_DIR_tftpboot_local); \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ push origin --tags $(GIT_REV_NAME_tftpboot) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_tftpboot_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_new_git_tftpboot_work

create_new_git_tftpboot_work: $(STATE_DIR)/create_new_git_tftpboot_work

rm_create_new_git_tftpboot_work: 
	if [ -e $(STATE_DIR)/create_new_git_tftpboot_work ]; then rm $(STATE_DIR)/create_new_git_tftpboot_work; fi

CLEAN_STATE_LIST += rm_create_new_git_tftpboot_work

info_target_create_new_git_tftpboot_work : 
	@echo "create_new_git_tftpboot_work:	 Create new repository of current tftpboot and add source code to it"

INFO_TARGET_LIST += info_target_create_new_git_tftpboot_work


##############################
# Push changes in  tftpboot_work to remote repository
##############################

$(STATE_DIR)/push_git_tftpboot_work: 
	@if [ -e  $(GIT_REPO_DIR_tftpboot_work) ] ; then \
		A=$$(git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ config remote.origin.url); \
		B="$(GIT_REPO_DIR_tftpboot_local)"; \
		if [  "x$${A}" != "x$${B}" -a "x$${A}" != "xfile://$${B%.git}" ] ; then \
			git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ remote set-url origin $(GIT_REPO_DIR_tftpboot_local); \
		fi ; \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ push origin --tags $(GIT_REV_NAME_tftpboot) ; \
	else \
		echo "Repository doesn't exists: $(GIT_REPO_DIR_tftpboot_work)" ; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : push_git_tftpboot_work

push_git_tftpboot_work: $(STATE_DIR)/push_git_tftpboot_work

rm_push_git_tftpboot_work: 
	if [ -e $(STATE_DIR)/push_git_tftpboot_work ]; then rm $(STATE_DIR)/push_git_tftpboot_work; fi

CLEAN_STATE_LIST += rm_push_git_tftpboot_work

info_target_push_git_tftpboot_work : 
	@echo "push_git_tftpboot_work:	 Push changes in  tftpboot_work to remote repository"

INFO_TARGET_LIST += info_target_push_git_tftpboot_work


##############################
# Create new git repositories of current tftpboot and checkout files in new source folder for existing remote repositories 
##############################

$(STATE_DIR)/create_co_git_tftpboot_work: 
	@if [ ! -e  $(GIT_REPO_DIR_tftpboot_work) ] ; then \
		mkdir -p $$(dirname $(GIT_REPO_DIR_tftpboot_work)) && \
		echo "Create source code folder, checkout files ." ; \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ init; \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ remote add origin $(GIT_REPO_DIR_tftpboot_local); \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ fetch origin ; \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ checkout $(GIT_REV_NAME_tftpboot) ; \
	else \
		echo "Repository already exists: $(GIT_REPO_DIR_tftpboot_work)" ; \
		exit 1; \
	fi
	@mkdir -p $(STATE_DIR); touch $@

.PHONY : create_co_git_tftpboot_work

create_co_git_tftpboot_work: $(STATE_DIR)/create_co_git_tftpboot_work

rm_create_co_git_tftpboot_work: 
	if [ -e $(STATE_DIR)/create_co_git_tftpboot_work ]; then rm $(STATE_DIR)/create_co_git_tftpboot_work; fi

CLEAN_STATE_LIST += rm_create_co_git_tftpboot_work

info_target_create_co_git_tftpboot_work : 
	@echo "create_co_git_tftpboot_work:	 Create new git repositories of current tftpboot and checkout files in new source folder for existing remote repositories "

INFO_TARGET_LIST += info_target_create_co_git_tftpboot_work


##############################
# Show examples for applying patches to tftpboot_work
##############################

apply_patches_git_tftpboot_work: 
	@echo "# Apply existing patches, with series file"
	@echo "export MY_PATCH=/tmp/patches"
	@echo "nano $$""{MY_PATCH}/series"
	@echo "git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ quiltimport --patches $$""{MY_PATCH} -n"
	@echo "git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ branch -av"
	@echo "git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ log"
	@echo "git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ quiltimport --patches $$""{MY_PATCH} "
	@echo ""
	@echo "# Apply patches from other git-repositories"
	@echo "git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ remote add test-git-01 /tmp/test.git"
	@echo "git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ fetch test-git-01 master "
	@echo "git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ cherry-pick 56816e7e19cb6a64bf996272d6ff1"
	@echo ""
	@echo "# Apply existing patches, WITHOUT series files"
	@echo "git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ am my_patch_files"

.PHONY : apply_patches_git_tftpboot_work

info_target_apply_patches_git_tftpboot_work : 
	@echo "apply_patches_git_tftpboot_work:	 Show examples for applying patches to tftpboot_work"

INFO_TARGET_LIST += info_target_apply_patches_git_tftpboot_work


##############################
# show branches in tftpboot_work
##############################

show_branch_git_tftpboot_work: 
	@if [  -e  $(GIT_REPO_DIR_tftpboot_work) ] ; then \
		echo "Repository: tftpboot_work $(GIT_REPO_DIR_tftpboot_work)" && \
		echo "HEAD rev: $$(git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ rev-parse HEAD) name: $$(git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ name-rev --name-only HEAD)" && \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ branch -v --no-abbrev ; \
	else \
		echo "Repository: tftpboot_work $(GIT_REPO_DIR_tftpboot_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : show_branch_git_tftpboot_work

info_target_show_branch_git_tftpboot_work : 
	@echo "show_branch_git_tftpboot_work:	 show branches in tftpboot_work"

INFO_TARGET_LIST += info_target_show_branch_git_tftpboot_work


##############################
# start git gui or gitk  for tftpboot_work
##############################

gui_git_tftpboot_work: 
	@if [  -e  $(GIT_REPO_DIR_tftpboot_work) ] ; then \
		cd  $(GIT_REPO_DIR_tftpboot_work) && gitk --all & \
		git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ gui & \
	fi

.PHONY : gui_git_tftpboot_work

info_target_gui_git_tftpboot_work : 
	@echo "gui_git_tftpboot_work:	 start git gui or gitk  for tftpboot_work"

INFO_TARGET_LIST += info_target_gui_git_tftpboot_work


##############################
# check rev name and commit id in tftpboot_work
##############################

check_branch_git_tftpboot_work: 
	@if [  -e  $(GIT_REPO_DIR_tftpboot_work) ] ; then \
		echo "Repository: tftpboot_work $(GIT_REPO_DIR_tftpboot_work)" && \
		if [[ "$(GIT_REV_ID_tftpboot)" == `git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ rev-parse $(GIT_REV_NAME_tftpboot)` ]] ;\
		then echo "rev end is correct for rev $(GIT_REV_NAME_tftpboot) in project 'tftpboot_work'"; \
		else echo "rev is wrong, use for project 'tftpboot_work' rev $(GIT_REV_NAME_tftpboot) in makefile GIT_REV_ID_tftpboot:=" `git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ rev-parse $(GIT_REV_NAME_tftpboot)`  "(old value: $(GIT_REV_ID_tftpboot))"; \
		fi ; \
		if [[ "$(GIT_REV_ID_tftpboot)" == $$(git --git-dir=$(GIT_REPO_DIR_tftpboot_work) --work-tree=$(GIT_WORK_DIR_tftpboot_work)/ rev-parse HEAD) ]] ;\
		then echo "HEAD is correct for rev $(GIT_REV_NAME_tftpboot) in project 'tftpboot_work'"; \
		else echo "HEAD is wrong, check if in the project 'tftpboot_work' the branch $(GIT_REV_NAME_tftpboot) is uptodate "; \
		fi ; \
	else \
		echo "Repository: tftpboot_work $(GIT_REPO_DIR_tftpboot_work) doesn't exist !!"; \
	fi
	@echo

.PHONY : check_branch_git_tftpboot_work

info_target_check_branch_git_tftpboot_work : 
	@echo "check_branch_git_tftpboot_work:	 check rev name and commit id in tftpboot_work"

INFO_TARGET_LIST += info_target_check_branch_git_tftpboot_work


##############################
# create bundles for all local repositories
##############################

create_bundle_git: create_bundle_git_tftpboot_local \
    set_tag_git_tftpboot_local

.PHONY : create_bundle_git

info_target_create_bundle_git : 
	@echo "create_bundle_git:	 create bundles for all local repositories"

INFO_TARGET_LIST += info_target_create_bundle_git


##############################
# show branch and HEAD of all repositories
##############################

show_branch_git: show_branch_git_bsp_local \
    show_branch_git_bsp_work \
    show_branch_git_ptxdist_local \
    show_branch_git_ptxdist_work \
    show_branch_git_barebox_local \
    show_branch_git_barebox_work \
    show_branch_git_linux_local \
    show_branch_git_linux_work \
    show_branch_git_toolchain_local \
    show_branch_git_toolchain_work \
    show_branch_git_gcc-linaro_local \
    show_branch_git_gcc-linaro_work \
    show_branch_git_tftpboot_local \
    show_branch_git_tftpboot_work

.PHONY : show_branch_git

info_target_show_branch_git : 
	@echo "show_branch_git:	 show branch and HEAD of all repositories"

INFO_TARGET_LIST += info_target_show_branch_git


##############################
# check branch and HEAD of all repositories
##############################

check_branch_git: check_branch_git_bsp_local \
    check_branch_git_bsp_work \
    check_branch_git_ptxdist_local \
    check_branch_git_ptxdist_work \
    check_branch_git_barebox_local \
    check_branch_git_barebox_work \
    check_branch_git_linux_local \
    check_branch_git_linux_work \
    check_branch_git_toolchain_local \
    check_branch_git_toolchain_work \
    check_branch_git_gcc-linaro_local \
    check_branch_git_gcc-linaro_work \
    check_branch_git_tftpboot_local \
    check_branch_git_tftpboot_work

.PHONY : check_branch_git

info_target_check_branch_git : 
	@echo "check_branch_git:	 check branch and HEAD of all repositories"

INFO_TARGET_LIST += info_target_check_branch_git


##############################
# show commit id of release branch
##############################

show_release_git: show_release_git_tftpboot_local

.PHONY : show_release_git

info_target_show_release_git : 
	@echo "show_release_git:	 show commit id of release branch"

INFO_TARGET_LIST += info_target_show_release_git

