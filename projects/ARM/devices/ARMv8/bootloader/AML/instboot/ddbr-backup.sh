#!/bin/sh

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

echo "Start Full backup eMMC"

#BACKUP_DATE=$(date +%Y%m%d%H%M%S)
#image="$(date +%Y%m%d%H%M%S)-EMMC-backup.img"
image="EMMC-backup.img"

OUTDIR=$1

emmc=$2

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

if [ "$OUTDIR" = "" ]
then
    OUTDIR="/storage/backup/ddbr"
    [ ! -d $OUTDIR ] && mkdir -p $OUTDIR
else
    if [ ! -d "$OUTDIR" ] ; then
        echo " PROGRAM EXITED DUE TO ERROR: NO DIR $OUTDIR !!!"
        exit 1
    fi
fi

echo $emmc

dd if="/dev/$emmc" | gzip > $OUTDIR/$image.gz

echo "Done! Full backup completed."
poweroff
exit 0
