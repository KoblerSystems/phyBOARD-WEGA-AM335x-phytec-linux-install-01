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

.PHONY : \
	info_target \
	list_states \
	clean_states \

info_target: info_target_head $(INFO_TARGET_LIST)
info_target_head:
	@echo
	@echo "List of all targets in this make file:"
	@echo
	@echo "info_target:	 Info about targets in this make file"
	@echo "list_states:	 List the created state files for this make file"
	@echo "clean_states:	 Delete all state files. Be careful! Use this target only when you know what you are doing!  "


list_states:
	ls -lt $(STATE_DIR)

clean_states: $(CLEAN_STATE_LIST) 
