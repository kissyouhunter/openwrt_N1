#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.2.3/g' package/base-files/files/bin/config_generate

#修改主机名
#sed -i 's/OpenWrt/N1/g' package/base-files/files/bin/config_generate

# 添加旁路由防火墙
echo "#iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user

#修改build日期
#sed -i "s/R21.6.22/R21.6.22 2021.06.27 powered by kissyouhunter/g" package/lean/default-settings/files/zzz-default-settings
#sed -i "s/Openwrt/N1/g" package/lean/default-settings/files/zzz-default-settings
#version=$(grep "DISTRIB_REVISION=" package/emortal/default-settings/files/zzz-default-settings  | awk -F "'" '{print $2}')
#sed -i '/DISTRIB_REVISION/d' package/emortal/default-settings/files/zzz-default-settings
#echo "echo \"DISTRIB_REVISION='${version} $(TZ=UTC+8 date "+%Y.%m.%d") powered by kissyouhunter '\" >> /etc/openwrt_release" >> package/emortal/default-settings/files/zzz-default-settings
#sed -i '/exit 0/d' package/emortal/default-settings/files/zzz-default-settings
#echo "exit 0" >> package/emortal/default-settings/files/zzz-default-settings
echo "sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release" >> package/emortal/default-settings/files/zzz-default-settings
echo "echo "DISTRIB_REVISION='$(TZ=UTC+8 date "+%Y.%m.%d") powered by kissyouhunter'" >> /etc/openwrt_release" >> package/emortal/default-settings/files/zzz-default-settings
echo "sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release" >> package/emortal/default-settings/files/zzz-default-settings
echo "echo "DISTRIB_DESCRIPTION='ImmortalWrt 18.06-SNAPSHOT '" >> /etc/openwrt_release" >> package/emortal/default-settings/files/zzz-default-settings

#删除默认密码
#sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

#替换coremark ./lede/feeds/packages/utils/coremark/coremark.sh
wget -O ./feeds/packages/utils/coremark/coremark.sh https://raw.githubusercontent.com/kissyouhunter/openwrt/main/diy/x86_lede/coremark.sh

# echo '删除重复插件'
rm -rf ./feeds/luci/applications/luci-app-netdata
rm -rf ./feeds/luci/applications/luci-app-dockerman
rm -rf ./feeds/luci//collections/luci-lib-docker


##更改插件位置

#ZeroTier

sed -i 's/vpn/network/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/controller/*.lua

#sed -i 's/vpn/network/g' ./package/lean/luci-app-zerotier/luasrc/model/cbi/zerotier/*.lua

#sed -i 's/vpn/network/g' ./package/lean/luci-app-zerotier/luasrc/view/zerotier/*.htm

#wrtbwmon 实时流量监测

#sed -i 's/nlbw/network/g' ./package/lean/luci-app-wrtbwmon/luasrc/controller/*.lua

#sed -i 's/nlbw/network/g' ./package/lean/luci-app-wrtbwmon/luasrc/model/cbi/wrtbwmon/*.lua

#sed -i 's/nlbw/network/g' ./package/lean/luci-app-wrtbwmon/luasrc/view/wrtbwmon/*.htm

#cpulimit cpu限制

#sed -i 's/\<control\>/services/g' ./feeds/kiss/luci-app-cpulimit/luasrc/controller/*.lua

#sed -i 's/control/services/g' ./feeds/kiss/luci-app-cpulimit/luasrc/model/cbi/*.lua

#nlbwmon  网络带宽监视器

#sed -i 's/"admin", "nlbw"/"admin", "network", "nlbw"/g' ./feeds/luci/applications/luci-app-nlbwmon/luasrc/controller/*.lua
