export ARCH=arm
export TOOLCHAIN_PATH= /opt/OSELAS.Toolchain-2014.12.1/arm-v7a-linux-gnueabihf/gcc-4.9.2-glibc-2.20-binutils-2.24-kernel-3.16-sanitized/bin
export CROSS_COMPILE=$(TOOLCHAIN_PATH)/arm-v7a-linux-gnueabihf-

KERNELSRC    := ../../../src/barebox-overo/
KERNELOUTPUT += $(PWD)

MAKEFLAGS += --no-print-directory

SD_PATH=/media/$(USER)/boot

include /etc/default/tftpd-hpa
TFTP_PATH=$(TFTP_DIRECTORY)/overo/boot

ENV_PATH=./env
ENV_IMAGE=images/barebox.env
ENV_GEN=$(KERNELSRC)/scripts/genenv

.PHONY: all env clean mrproper install-tftp install-sd $(MAKECMDGOALS)

env: all
	$(ENV_GEN) $(KERNELOUTPUT) $(KERNELOUTPUT) $(ENV_IMAGE) $(ENV_PATH)

all:
	$(MAKE) $(MAKEFLAGS) -C $(KERNELSRC) O=$(KERNELOUTPUT)

install-sd: barebox-flash-image
	install barebox-flash-image $(SD_PATH)/barebox.bin
	install $(ENV_IMAGE) $(SD_PATH)

install-tftp: $(TFTP_PATH) barebox-flash-image
	install barebox-flash-image $(TFTP_PATH)/barebox.bin
	install $(ENV_IMAGE) $(TFTP_PATH)

$(TFTP_PATH):
	install --directory $@

barebox-flash-image: env

clean mrproper:
	@rm -f $(ENV_IMAGE)
	$(MAKE) $(MAKEFLAGS) -C $(KERNELSRC) O=$(KERNELOUTPUT) $@

Makefile:;

$(filter-out all env clean mrproper Makefile install-tftp install-sd,$(MAKECMDGOALS)) %/:
	$(MAKE) $(MAKEFLAGS) -C $(KERNELSRC) O=$(KERNELOUTPUT) $@
