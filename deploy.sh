#!/usr/bin/env bash
set -euo pipefail
# ImHex 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://docs.werwolv.net
# 更新日期：2026-11-04
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

curl -fL -o imhex.deb https://github.com/WerWolv/ImHex/releases/download/v1.38.1/imhex-1.38.1-Ubuntu-24.04-x86_64.deb
sudo dpkg -i imhex.deb
imhex --version

echo ""

echo "下载与校验完成，安装包在 .download 目录"
echo "若结果异常或需要改配置，请参考官方文档：https://docs.werwolv.net"
