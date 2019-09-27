# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="XR819"
PKG_VERSION="354e8c32e7948d46a63796d0ca266b1f702999b0"
PKG_SHA256=""
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/karabek/xradio"
PKG_URL="https://github.com/karabek/xradio/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="XR819 Linux driver"
PKG_IS_KERNEL_PKG="yes"
#PKG_TOOLCHAIN="make"

pre_make_target() {
  unset LDFLAGS
#  pwd
}

make_target() {
  make V=1 \
       ARCH=$TARGET_KERNEL_ARCH \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp *.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
