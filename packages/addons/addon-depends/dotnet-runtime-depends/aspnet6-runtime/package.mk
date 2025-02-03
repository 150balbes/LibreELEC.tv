# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet6-runtime"
PKG_VERSION="6.0.35"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="dbfbf6748deaaf241433ee0d1ac9f03ea713f18d45860762ba7a5bff49445a74"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/5b5b9407-22c3-4ea4-aefe-c958ea78e7d1/1abb142a2ff944d822d133af369dbe21/aspnetcore-runtime-6.0.35-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="8159f843c669f94b1e3c1bd68806e34926c8d8927be0b232319397406f88b4a9"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/44b0aa96-3ad1-4406-946f-680e9a52897b/8a6b84db7a63924f98b4197ce07313be/aspnetcore-runtime-6.0.35-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="f7f95e7007dbe8e0588c8b2b334c27dd831f64adc4db540f530f2c7cf8bef5b0"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/ccdb3628-8f55-411b-b0f1-669d42604ad8/81283ab8762aaab1be72772711f07f86/aspnetcore-runtime-6.0.35-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
