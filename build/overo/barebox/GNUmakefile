KERNELSRC    := ../../src/barebox-overo/
KERNELOUTPUT += $(PWD)

MAKEFLAGS += --no-print-directory

.PHONY: all install-tftp install-sd $(MAKECMDGOALS)

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabi-

all:
	$(MAKE) $(MAKEFLAGS) -C $(KERNELSRC) O=$(KERNELOUTPUT)

install-tftp:
	install -d /srv/tftp/overo
	cp images/barebox-overo.img /srv/tftp/overo/barebox.bin

install-sd:
	cp images/barebox-overo.img /media/$(USER)/boot/barebox.bin

Makefile:;

$(filter-out all Makefile install-tftp install-sd,$(MAKECMDGOALS)) %/:
	$(MAKE) $(MAKEFLAGS) -C $(KERNELSRC) O=$(KERNELOUTPUT) $@
