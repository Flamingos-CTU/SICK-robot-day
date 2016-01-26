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
	cp images/barebox-overo-mlo.img /srv/tftp/overo/MLO

install-sd:
	cp images/barebox-overo-mlo.img /media/$(USER)/boot/MLO

Makefile:;

$(filter-out all Makefile install-tftp install-sd,$(MAKECMDGOALS)) %/:
	$(MAKE) $(MAKEFLAGS) -C $(KERNELSRC) O=$(KERNELOUTPUT) $@
