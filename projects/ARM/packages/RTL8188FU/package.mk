# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8188FU"
PKG_VERSION="master"
PKG_SHA256=""
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kelebek333/rtl8188fu"
PKG_URL="https://github.com/kelebek333/rtl8188fu/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Realtek RTL8188FU Linux driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
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
