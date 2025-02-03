# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fcft"
PKG_VERSION="3.1.9"
PKG_SHA256="4b7e3b2ab7e14f532d8a9cb0f2d3b0cdf9d2919b95e6ab8030f7ac87d059c2b6"
PKG_LICENSE="MIT"
PKG_SITE="https://codeberg.org/dnkl/fcft"
PKG_URL="https://codeberg.org/dnkl/fcft/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain pixman fontconfig freetype tllist"
PKG_LONGDESC="A simple library for font loading and glyph rasterization using FontConfig, FreeType and pixman."

PKG_MESON_OPTS_TARGET="-Ddocs=disabled \
                       -Dgrapheme-shaping=disabled \
                       -Drun-shaping=disabled \
                       -Dtest-text-shaping=false \
                       -Dexamples=false"
