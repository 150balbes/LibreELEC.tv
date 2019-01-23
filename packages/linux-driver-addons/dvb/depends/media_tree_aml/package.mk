# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present CoreELEC (https://coreelec.org)

PKG_NAME="media_tree_aml"
PKG_VERSION="11d2689fc042ba2271ae39ff53363b676604c726"
PKG_SHA256="6c61d45790b0ec5ccbab24a8e230ee9bc0e6f8390d1e5a3b10416eb0a3f4f042"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_URL="https://github.com/CoreELEC/media_tree_aml/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="driver"
PKG_LONGDESC="Source of Linux Kernel amlogic drivers to build with media_build."
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p $PKG_BUILD/
  tar -xf $SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz -C $PKG_BUILD/../
}
