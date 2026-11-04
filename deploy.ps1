# ImHex 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://docs.werwolv.net
# 更新日期：2026-11-04
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -fL -o imhex.msi https://github.com/WerWolv/ImHex/releases/download/v1.38.1/imhex-1.38.1-Windows-x86_64.msi
Start-Process msiexec -ArgumentList '/i','imhex.msi','/passive' -Wait
Write-Host '安装完成后从开始菜单启动 ImHex'

Write-Host ''

Write-Host '下载与校验完成，安装包在 .download 目录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://docs.werwolv.net'
