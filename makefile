#!make

UNAME := $(shell uname)

local-setup:
	@echo "+\n++ Make: Installing system dependencies...\n+"
ifeq ($(UNAME), Linux)
	@.config/linux.sh
endif
ifeq ($(UNAME), Darwin)
	@.config/darwin.sh
endif
