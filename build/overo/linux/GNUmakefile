export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabi-

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
TFTP_PATH=$(TFTP_DIRECTORY)/overo

.PHONY: all install-sd install-tftp $(MAKECMDGOALS)

all:
	$(Q)$(MAKE) $(MAKEARGS) $(MAKECMDGOALS)

install-sd:
	install -t $(SD_PATH) $(LINUX) $(DT) 

install-tftp:
	install -d $(TFTP_PATH)
	install -t $(TFTP_PATH) $(LINUX) $(DT)

$(filter-out all install-sd install-tftp, $(MAKECMDGOALS)): all
	@:
