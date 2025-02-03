# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet8-runtime"
PKG_VERSION="8.0.10"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="b3554e4951f83796c2df1bfc7c5a0b6fa25546db77489c1eef7161b8b997949f"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/f93af34d-cde3-4231-a54f-119c328bd876/663b3c2dbf1ed2a3e08ac8e614060571/aspnetcore-runtime-8.0.10-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="e79bd3c46a32ff0a4a03be045e7eaf7a006c9618bb0aed1dc98dfac634b110ed"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/50a67fd4-a5dd-42f1-a3ac-e008c3115dcc/816972da008ae5cee7612cad9b6808f0/aspnetcore-runtime-8.0.10-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="002f46d626076daee3b6e9fef180300133b9d1f7d856507fa6160fc235d7c009"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/6d143cf6-e215-428e-bcde-9fd50ea0e1be/99652e31b3e0161a3f1f933e0bedf223/aspnetcore-runtime-8.0.10-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
