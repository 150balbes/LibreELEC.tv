# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mtools"
PKG_VERSION="4.0.46"
PKG_SHA256="9aad8dd859f88fb7787924ec47590192d3abf7bad6c840509c854290d6bc16c0"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/mtools/"
PKG_URL="http://ftpmirror.gnu.org/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="autotools:host"
PKG_LONGDESC="mtools: A collection of utilities to access MS-DOS disks"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-cfg-libs:host"
