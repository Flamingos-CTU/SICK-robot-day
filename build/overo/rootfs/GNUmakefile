# These variables are used in the buildroot .config file
# They are defined and assigned here so it is more clear that you need a specific toolchain
export TOOLCHAIN_PATH= /opt/OSELAS.Toolchain-2014.12.1/arm-v7a-linux-gnueabihf/gcc-4.9.2-glibc-2.20-binutils-2.24-kernel-3.16-sanitized/
export CROSS_COMPILE=arm-v7a-linux-gnueabihf

lastword = $(word $(words $(1)),$(1))
makedir := $(dir $(call lastword,$(MAKEFILE_LIST)))

MAKEARGS := -C ../../../src/buildroot-stable
MAKEARGS += O=$(if $(patsubst /%,,$(makedir)),$(CURDIR)/)$(patsubst %/,%,$(makedir))

MAKEFLAGS += --no-print-directory

SD_PATH=/media/$(USER)/rootfs

include /etc/default/tftpd-hpa
NFS_PATH=$(TFTP_DIRECTORY)/overo/rootfs

.PHONY: all install-sd install-nfs $(MAKECMDGOALS)

all	:= $(filter-out all Makefile install-sd install-nfs,$(MAKECMDGOALS))

all:
	$(MAKE) $(MAKEARGS) $(all)

install-sd:
	sudo tar -C $(SD_PATH) -xf images/rootfs.tar

install-nfs: $(NFS_PATH)
	sudo tar -C $(NFS_PATH) -xf images/rootfs.tar
	@echo "Do not forget to export the NFS root filesystem directory in /etc/exports !"

$(NFS_PATH):
	install --directory $@

Makefile:;

$(all): all
	@:

%/: all
	@:
