#!make

UNAME := $(shell uname)

local-setup:
	@echo "+\n++ Make: Installing system dependencies...\n+"
ifeq ($(UNAME), Linux)
	@sh .config/linux.sh
endif
ifeq ($(UNAME), Darwin)
	@sh .config/darwin.sh
endif
