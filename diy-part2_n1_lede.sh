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

# echo '删除重复插件'
rm -rf ./feeds/luci/applications/luci-app-netdata
rm -rf ./feeds/luci/applications/luci-app-jd-dailybonus
rm -rf ./feeds/luci/collections/luci-lib-docker
rm -rf ./feeds/luci/applications/luci-app-cpufreq
rm -rf ./feeds/luci/applications/luci-app-dockerman

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.2.4/g' package/base-files/files/bin/config_generate

#修改主机名为N1
sed -i 's/OpenWrt/N1/g' package/base-files/files/bin/config_generate

# 添加旁路由防火墙
echo "iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user

#修改build日期
#sed -i "s/R21.6.22/R21.6.22 2021.06.27 powered by kissyouhunter/g" package/lean/default-settings/files/zzz-default-settings
#sed -i "s/Openwrt/N1/g" package/lean/default-settings/files/zzz-default-settings
version=$(grep "DISTRIB_REVISION=" package/lean/default-settings/files/zzz-default-settings  | awk -F "'" '{print $2}')
sed -i '/DISTRIB_REVISION/d' package/lean/default-settings/files/zzz-default-settings
#echo "echo \"DISTRIB_REVISION='${version} $(TZ=UTC-8 date "+%Y.%m.%d") powered by kissyouhunter '\" >> /etc/openwrt_release" >> package/lean/default-settings/files/zzz-default-settings
echo "echo \"DISTRIB_REVISION='${version} $(TZ=UTC-8 date "+%Y.%m.%d") '\" >> /etc/openwrt_release" >> package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/d' package/lean/default-settings/files/zzz-default-settings
echo "exit 0" >> package/lean/default-settings/files/zzz-default-settings

#修改luci-app-adguardhome配置config文件
#sed -i 's'/usr/bin/AdGuardHome'/'usr/bin/AdGuardHome/AdGuardHome'/g' #feeds/kenzok/luci-app-adguardhome/root/etc/config/AdGuardHome

#删除默认密码
#sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

#themes
#git clone https://github.com/Leo-Jo-My/luci-theme-Butterfly package/luci-theme-Butterfly
#git clone https://github.com/Leo-Jo-My/luci-theme-Butterfly-dark package/luci-theme-Butterfly-dark

# 替换adguardhome Makefie
#wget -O ./feeds/kiss/AdGuardHome/adguardhome/Makefile https://raw.githubusercontent.com/kissyouhunter/openwrt/main/diy/n1/adguardhome/Makefile

# 替换luci-app-adguardhome AdGuardHome
#wget -O ./feeds/kiss/luci-app-adguardhome/root/etc/config/AdGuardHome https://raw.githubusercontent.com/kissyouhunter/openwrt/main/diy/n1/luci-app-adguardhome/AdGuardHome

##更改插件位置

#ZeroTier

sed -i 's/vpn/network/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/controller/*.lua

sed -i 's/vpn/network/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/model/cbi/zerotier/*.lua

sed -i 's/vpn/network/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/*.htm

#wrtbwmon 实时流量监测

#sed -i 's/"admin", "nlbw"/"admin", "network", "nlbw"/g' ./package/lean/luci-app-wrtbwmon/luasrc/controller/*.lua

#sed -i 's/nlbw/network/g' ./package/lean/luci-app-wrtbwmon/luasrc/model/cbi/wrtbwmon/*.lua

#sed -i 's/nlbw/network/g' ./package/lean/luci-app-wrtbwmon/luasrc/view/wrtbwmon/*.htm

#cpulimit cpu限制

sed -i 's/\<control\>/services/g' ./feeds/kiss/luci-app-cpulimit/luasrc/controller/*.lua

sed -i 's/control/services/g' ./feeds/kiss/luci-app-cpulimit/luasrc/model/cbi/*.lua

#nlbwmon  网络带宽监视器

#sed -i 's/"admin", "nlbw"/"admin", "network", "nlbw"/g' ./feeds/luci/applications/luci-app-nlbwmon/luasrc/controller/*.lua

#luci-app-amlogic 晶晨宝盒

sed -i 's|https.*/OpenWrt|https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1|g' ./feeds/amlogic/luci-app-amlogic/root/etc/config/amlogic

sed -i 's|ARMv8|openwrt_n1|g' ./feeds/amlogic/luci-app-amlogic/root/etc/config/amlogic

sed -i 's|opt/kernel|https://github.com/kissyouhunter/kernel_N1/tree/main/kernel|g' ./feeds/amlogic/luci-app-amlogic/root/etc/config/amlogic

sed -i 's|500000|1000000|g' ./feeds/amlogic/luci-app-amlogic/root/etc/config/amlogic

#tencentddns 腾讯ddns

sed -i 's/"admin", "tencentcloud"/"admin", "services", "tencentcloud"/g' ./feeds/kiss/luci-app-tencentddns/files/luci/controller/*.lua

#暂时修复python3
sed -i 's/PKG_VERSION:=*.*/PKG_VERSION:=4.8/g' tools/sed/Makefile
sed -i 's/PKG_HASH:=*.*/PKG_HASH:=f79b0cfea71b37a8eeec8490db6c5f7ae7719c35587f21edb0617f370eeff633/g' tools/sed/Makefile
