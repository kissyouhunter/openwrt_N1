#!/bin/bash

wget -O Makefile_uugamebooster https://github.com/aUsernameWoW/uugamebooster/raw/main/Makefile
# 定义架构
ARCH="aarch64"

# 获取最新版本和MD5
latest_info=$(curl -L -s -k -H "Accept:text/plain" "http://router.uu.163.com/api/plugin?type=openwrt-$UU_ARCH")
PKG_SOURCE_URL=$(echo $latest_info | cut -d, -f1)
PKG_MD5SUM=$(echo $latest_info | cut -d, -f2)
PKG_VERSION=$(echo $PKG_SOURCE_URL | awk -F/ '{print $(NF-1)}')

# 更新Makefile
MAKEFILE_PATH="Makefile_uugamebooster"
sed -i "s|PKG_VERSION:=.*|PKG_VERSION:=$PKG_VERSION|g" $MAKEFILE_PATH
sed -i "s|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=$PKG_SOURCE_URL|g" $MAKEFILE_PATH
sed -i "s|PKG_MD5SUM:=.*|PKG_MD5SUM:=$PKG_MD5SUM|g" $MAKEFILE_PATH
sed -i "s|PKG_RELEASE:=.*|PKG_RELEASE:=$PKG_VERSION|g" $MAKEFILE_PATH
cp -f Makefile_uugamebooster ./feeds/packages/net/uugamebooster/Makefile
cp -f Makefile_uugamebooster ./package/feeds/packages/uugamebooster/Makefile