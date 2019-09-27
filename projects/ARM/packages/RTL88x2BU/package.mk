# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL88x2BU"
PKG_VERSION="5.6.1_30362.20181109_COEX20180928-6a6a"
PKG_SHA256=""
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/cilynx/rtl88x2bu"
PKG_URL="https://github.com/cilynx/rtl88x2bu/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Realtek RTL88x2BU Linux 4.x driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="make"

pre_make_target() {
  unset LDFLAGS
  pwd
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
