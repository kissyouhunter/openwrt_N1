#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git amlogic https://github.com/ophub/luci-app-amlogic' >>feeds.conf.default

# echo '删除重复插件'
rm -rf ./package/lean/luci-app-netdata
rm -rf ./package/lean/luci-app-jd-dailybonus
rm -rf ./package/lean/luci-lib-docker

# 替换index.htm文件 n1
wget -O ./package/lean/autocore/files/arm/index.htm https://raw.githubusercontent.com/kissyouhunter/openwrt/main/diy/n1/index/index_N1.htm

# 替换banner
wget -O ./package/base-files/files/etc/banner https://raw.githubusercontent.com/kissyouhunter/openwrt/main/diy/x86/banner
