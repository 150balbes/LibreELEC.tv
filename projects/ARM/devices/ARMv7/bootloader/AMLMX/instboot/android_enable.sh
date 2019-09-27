#!/bin/sh

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

echo "Start enable reboot from Android"

mount -o rw,remount /flash

touch /flash/boot_android

sync
exit 0

