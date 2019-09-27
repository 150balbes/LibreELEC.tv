# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8821CU"
PKG_VERSION="master"
PKG_SHA256=""
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/brektrou/rtl8821CU"
PKG_URL="https://github.com/brektrou/rtl8821CU/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Realtek RTL88x1CU Linux driver"
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
