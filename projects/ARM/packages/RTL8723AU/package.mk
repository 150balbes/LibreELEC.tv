# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="RTL8723AU"
PKG_VERSION="aa672d72f74219ca3cd0d49660542910fd42fb26"
PKG_SHA256="2a6c4aa88dc5553d8fd21926821b38bc1afc6f4fd2a37d1d1279100e0d942a55"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lwfinger/rtl8723au"
PKG_URL="https://github.com/lwfinger/rtl8723au/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Realtek RTL8723AU Linux driver"
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
