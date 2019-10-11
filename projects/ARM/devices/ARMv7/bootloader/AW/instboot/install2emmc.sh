#!/bin/sh

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

emmc=$1


if [ "$emmc" = "" ]
then
	hasdrives=$(ls -l /dev/ | grep -oE '(mmcblk[0-9])' | sort | uniq)
	if [ "$hasdrives" = "" ]
	then
		echo "UNABLE TO FIND ANY EMMC OR SD DRIVES ON THIS SYSTEM!!! "
		exit 1
	fi
	avail=$(ls -l /dev/ | grep -oE '(mmcblk[0-9]|sda[0-9])' | sort | uniq)
	if [ "$avail" = "" ]
	then
		echo "UNABLE TO FIND ANY DRIVES ON THIS SYSTEM!!!"
		exit 1
	fi
	runfrom=$(mount | grep /flash | grep -oE '(mmcblk[0-9]|sda[0-9])')
	if [ "$runfrom" = "" ]
	then
		echo " UNABLE TO FIND ROOT OF THE RUNNING SYSTEM!!! "
		exit 1
	fi
	emmc=$(echo $avail | sed "s/$runfrom//" | sed "s/sd[a-z][0-9]//g" | sed "s/ //g")
	if [ "$emmc" = "" ]
	then
		echo " UNABLE TO FIND YOUR EMMC DRIVE OR YOU ALREADY RUN FROM EMMC!!!"
		exit 1
	fi
	if [ "$runfrom" = "$avail" ]
	then
		echo " YOU ARE RUNNING ALREADY FROM EMMC!!! "
		exit 1
	fi
	if [ $runfrom = $emmc ]
	then
		echo " YOU ARE RUNNING ALREADY FROM EMMC!!! "
		exit 1
	fi
	if [ "$(echo $emmc | grep mmcblk)" = "" ]
	then
		echo " YOU DO NOT APPEAR TO HAVE AN EMMC DRIVE!!! "
		exit 1
	fi
else
    if [ ! -e "$emmc" ] ; then
	echo "Not found EMMC !!!!"
	exit 1
    fi
fi

DEV_EMMC="/dev/$emmc"

mount -o rw,remount /flash

dd if="${DEV_EMMC}" of=/flash/u-boot-default.img bs=1M count=16

dd if=/dev/zero of="${DEV_EMMC}" bs=512 count=1

dd if=/flash/u-boot-default.img of="${DEV_EMMC}" bs=1 count=442
dd if=/flash/u-boot-default.img of="${DEV_EMMC}" bs=512 skip=1 seek=1

if grep -q "${DEV_EMMC}p1" /proc/mounts ; then
    umount -f "${DEV_EMMC}p1"
fi

if grep -q "${DEV_EMMC}p2" /proc/mounts ; then
    umount -f "${DEV_EMMC}p2"
fi

parted -s "${DEV_EMMC}" mklabel msdos
parted -s "${DEV_EMMC}" mkpart primary fat32 16M 532M
parted -s "${DEV_EMMC}" mkpart primary ext4 533M 565M

if [ -f /flash/u-boot/u-boot-sunxi-with-spl.bin ] ; then
    dd if=/flash/u-boot/u-boot-sunxi-with-spl.bin of="${DEV_EMMC}" conv=fsync bs=1k seek=8
fi

sync

IMAGE_KERNEL="/flash/KERNEL"
IMAGE_SYSTEM="/flash/SYSTEM"
SCRIPT_ENV="/flash/uEnv.txt"
IMAGE_DTB="/flash/dtb"
SCRIPT_EMMC="/flash/boot-emmc.scr"

if [ -f $IMAGE_KERNEL -a -f $IMAGE_SYSTEM -a -f $SCRIPT_ENV -a -f $SCRIPT_EMMC ] ; then

    mount -o rw,remount /flash

    if grep -q "${DEV_EMMC}p1" /proc/mounts ; then
      umount -f "${DEV_EMMC}p1"
    fi
    mkfs.vfat -n "LE_EMMC" "${DEV_EMMC}p1"

    mkdir -p /tmp/system
    mount "${DEV_EMMC}p1" /tmp/system

    if grep -q "${DEV_EMMC}p1" /proc/mounts ; then

        cp $IMAGE_KERNEL /tmp/system && sync
        cp $IMAGE_SYSTEM /tmp/system && sync
        cp $SCRIPT_ENV /tmp/system && sync
	cp $SCRIPT_EMMC /tmp/system/boot.scr && sync
        sed -e "s/LIBREELEC/LE_EMMC/g" \
          -e "s/STORAGE/DATA_EMMC/g" \
          -i "/tmp/system/uEnv.txt"

        cp -r $IMAGE_DTB /tmp/system && sync
        umount /tmp/system

	if grep -q "${DEV_EMMC}p2" /proc/mounts ; then
	    umount -f "${DEV_EMMC}p2"
	fi
	
        mkfs.ext4 -F -L DATA_EMMC "${DEV_EMMC}p2"
        e2fsck -n "${DEV_EMMC}p2"
	
        mkdir -p /tmp/data
        mount -o rw "${DEV_EMMC}p2" /tmp/data
	echo "" > /tmp/data/.please_resize_me
        umount /tmp/data

	sync
        poweroff
        exit 0
    else
	echo "No $DEV_EMMC partiton."
	exit 1
    fi
else
    echo "No LE image found on /flash! Exiting..."
    exit 1
fi
