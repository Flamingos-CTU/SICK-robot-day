export ARCH=arm
export TOOLCHAIN_PATH= /opt/OSELAS.Toolchain-2014.12.1/arm-v7a-linux-gnueabihf/gcc-4.9.2-glibc-2.20-binutils-2.24-kernel-3.16-sanitized/bin
export CROSS_COMPILE=$(TOOLCHAIN_PATH)/arm-v7a-linux-gnueabihf-

lastword = $(word $(words $(1)),$(1))
makedir := $(dir $(call lastword,$(MAKEFILE_LIST)))

ifeq ("$(origin V)", "command line")
VERBOSE := $(V)
endif
ifneq ($(VERBOSE),1)
Q := @
endif

MAKEARGS := -C ../../../src/linux-stable
MAKEARGS += O=$(if $(patsubst /%,,$(makedir)),$(CURDIR)/)$(patsubst %/,%,$(makedir))

MAKEFLAGS += --no-print-directory

LINUX=arch/arm/boot/zImage
DT=arch/arm/boot/dts/omap3-overo-chestnut43.dtb

SD_PATH=/media/$(USER)/boot

include /etc/default/tftpd-hpa
TFTP_PATH=$(TFTP_DIRECTORY)/overo/boot

.PHONY: all install-sd install-tftp $(MAKECMDGOALS)

all:
	$(Q)$(MAKE) $(MAKEARGS) $(MAKECMDGOALS)

install-sd:
	install --target-directory=$(SD_PATH) $(LINUX) $(DT)

install-tftp: $(TFTP_PATH)
	install --target-directory=$(TFTP_PATH) $(LINUX) $(DT)

$(TFTP_PATH):
	install --directory $@


$(filter-out all install-sd install-tftp, $(MAKECMDGOALS)): all
	@:
