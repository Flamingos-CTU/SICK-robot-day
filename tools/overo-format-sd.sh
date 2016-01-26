#!/bin/sh
# Create a bootable SD card with 3 partitions
#
# boot   - contains bootloader, kernel and device tree images
# rootfs - root filesystem
# home   - to be mounted to home directory in the root
#        - contains competition-specific software

# exit on any error immediately
set -e

DEVICE=$1

if [ "foo$DEVICE" = "foo" ];
then
	echo "Usage: $0 SD_CARD_DEVICE"
	exit 0
fi

if [ ! -b "$DEVICE" ];
then
	echo "$DEVICE is not a block device (probably not an SD card)"
	exit 1
fi

echo -n "All your data on $DEVICE will be lost. Forever. OK? [No/yes]: "
read user

if [ "$user" != "yes" ];
then
	echo "You are loser! (And we did not touch your data on $DEVICE)"
	exit 0
fi

# get size of the card
SIZE=`sudo fdisk -l $DEVICE 2>/dev/null | grep "Disk $DEVICE" | awk '{print $5}'`

# get number of cylinders (cca 7MB per cylinder)
CYLINDERS=`echo $SIZE/255/63/512 | bc`

# TODO test that we have enough cylinders for all partitions
# divide the card dynamicaly somewhat like: boot = 1/20, root 15/20, home 4/20

# erase the device partition table
echo "Erasing $DEVICE device ..."
sudo dd if=/dev/zero of=$DEVICE bs=1024 count=1024

# create new partition table with 3 partitions
# input format: <start>,<size>,<id>,<boot flag>
# boot = start from the beginning, size 11 cylinders, ID 0x0C, bootable flag (*)
# rootfs = start 12, size 179
# home = start 191, size to the end of device
echo "Creating new partitions on $DEVICE ..."
sudo sfdisk -D -H 255 -S 63 -C $CYLINDERS $DEVICE << EOF
,11,0x0C,*
12,179,,-
191,,,-
EOF

# format the new partitions
# TODO make this work with USB disks also (/dev/mmcblk[m]p[n] vs /dev/sd[a-z][n])
echo "Formating boot partition fat32 ..."
sudo mkfs.vfat -F 32 -n "boot" ${DEVICE}p1

echo "Formating rootfs partition ext3 ..."
sudo mkfs.ext3 -L "rootfs" -E root_owner=$(id -u):$(id -g) ${DEVICE}p2

echo "Formating home partition ext3 ..."
sudo mkfs.ext3 -L "home" -E root_owner=$(id -u):$(id -g) ${DEVICE}p3

