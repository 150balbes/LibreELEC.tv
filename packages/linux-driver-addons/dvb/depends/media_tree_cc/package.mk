# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="media_tree_cc"
PKG_VERSION="2019-03-08"
PKG_SHA256="e3394cb051c9bd450e84f6597072fe65ab7d1a45113cfbe5027dd9137129834f"
PKG_LICENSE="GPL"
PKG_SITE="https://bitbucket.org/CrazyCat/media_build/downloads/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="Source of Linux Kernel media_tree subsystem to build with media_build."
PKG_TOOLCHAIN="manual"

configure_package() {
  if [ "$PROJECT" = "Amlogic" ]; then
    PKG_PATCH_DIRS="amlogic"
  fi
}

unpack() {
  mkdir -p $PKG_BUILD/
  tar -xf $SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2 -C $PKG_BUILD/

  # hack/workaround for borked upstream kernel/media_build
  # without removing atomisp there a lot additional includes that 
  # slowdown build process after modpost from 3min to 6min
  # even if atomisp is disabled via kernel.conf
  rm -rf $PKG_BUILD/drivers/staging/media/atomisp
  sed -i 's|^.*drivers/staging/media/atomisp.*$||' \
    $PKG_BUILD/drivers/staging/media/Kconfig

  if [ "$PROJECT" = "Amlogic" ]; then
    cp -rfL $(get_build_dir linux)/drivers/media/platform/meson/vdec $PKG_BUILD/drivers/media/platform/meson/
    echo "obj-y += vdec/" >> "$PKG_BUILD/drivers/media/platform/meson/Makefile"
    sed -e 's/$(CONFIG_VIDEO_MESON_VDEC)/m/g' -i $PKG_BUILD/drivers/media/platform/meson/vdec/Makefile
  fi
}
