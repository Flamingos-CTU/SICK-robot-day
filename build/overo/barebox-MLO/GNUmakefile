export ARCH=arm
export TOOLCHAIN_PATH= /opt/OSELAS.Toolchain-2014.12.1/arm-v7a-linux-gnueabihf/gcc-4.9.2-glibc-2.20-binutils-2.24-kernel-3.16-sanitized/bin
export CROSS_COMPILE=$(TOOLCHAIN_PATH)/arm-v7a-linux-gnueabihf-

KERNELSRC    := ../../../src/barebox-overo/
KERNELOUTPUT += $(PWD)

MAKEFLAGS += --no-print-directory

SD_PATH=/media/$(USER)/boot

include /etc/default/tftpd-hpa
TFTP_PATH=$(TFTP_DIRECTORY)/overo/boot

.PHONY: all install-tftp install-sd $(MAKECMDGOALS)

all:
	$(MAKE) $(MAKEFLAGS) -C $(KERNELSRC) O=$(KERNELOUTPUT)

install-sd: barebox-flash-image
	install barebox-flash-image $(SD_PATH)/MLO

install-tftp: $(TFTP_PATH) barebox-flash-image
	install barebox-flash-image $(TFTP_PATH)/MLO

$(TFTP_PATH):
	install --directory $@

barebox-flash-image: all

Makefile:;

$(filter-out all Makefile install-tftp install-sd,$(MAKECMDGOALS)) %/:
	$(MAKE) $(MAKEFLAGS) -C $(KERNELSRC) O=$(KERNELOUTPUT) $@
