#!/bin/bash
# update kernel for N1

TIME() {
[[ -z "$1" ]] && {
	echo -ne " "
} || {
     case $1 in
	r) export Color="\e[31;1m";;
	g) export Color="\e[32;1m";;
	b) export Color="\e[34;1m";;
	y) export Color="\e[33;1m";;
	z) export Color="\e[35;1m";;
	l) export Color="\e[36;1m";;
	w) export Color="\e[29;1m";;
      esac
	[[ $# -lt 2 ]] && echo -e "\e[36m\e[0m ${1}" || {
		echo -e "\e[36m\e[0m ${Color}${2}\e[0m"
	 }
      }
}

download_path=/tmp/upload
u_boot_url=https://tt.kisssik.ga/d/aliyun/kernel/files/u-boot.ext
url=https://tt.kisssik.ga/d/aliyun/kernel
kernel_number=5.4.198
kernel_name=5.4.198-kissyouhunter
boot_file=boot-5.4.198-kissyouhunter.tar.gz
modules_file=modules-5.4.198-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-5.4.198-kissyouhunter.tar.gz

download_n1_kernel() {
    TIME w "开始下载内核文件。"
    mkdir -p ${download_path}
    cd ${download_path}
    curl -LO ${url}/${kernel_number}/${boot_file}
    curl -LO ${url}/${kernel_number}/${modules_file}
    curl -LO ${url}/${kernel_number}/${dtb_file}
    sync
    TIME g "内核文件下载完毕。"
}

update_boot() {
    TIME w "开始更新boot。"
    rm -f /boot/config-* /boot/initrd.img-* /boot/System.map-* /boot/uInitrd-* /boot/vmlinuz-* && sync
    rm -f /boot/uInitrd /boot/zImage && sync
    tar -xf ${download_path}/${boot_file} -C /boot && sync
    cd /boot && cp -f uInitrd-${kernel_name} uInitrd && cp -f vmlinuz-${kernel_name} zImage && sync
    TIME g "boot更新成功。"
}

update_dtb() {
    TIME w "开始更新dtb。"
    cd /boot/dtb/amlogic/ && rm -f * && sync
    tar -xf ${download_path}/${dtb_file} -C /boot/dtb/amlogic/ && sync
    TIME w "dtb更新成功。"
}

update_modules() {
    TIME w "开始更新modules。"
    rm -rf /lib/modules/* && sync
    tar -xf ${download_path}/${modules_file} -C /lib/modules/ && sync
    cd /lib/modules/${kernel_name}
    rm -f *.ko
    find ./ -type f -name '*.ko' -exec ln -s {} ./ \;
    sync && sleep 3
    x=$(ls *.ko -l | grep "^l" | wc -l)
    if [ "${x}" -eq "0" ]; then
        TIME r "*.ko 文件错误。"
        exit 0
    fi
    TIME g "modules更新成功。"
}

# 5.4内核
update_uboot() {
    TIME w "开始更新uboot。"
    rm -f /boot/u-boot.ext
    if [ -f "/boot/u-boot.ext" ]; then
        TIME r "uboot更新失败。"
    else
        TIME g "uboot更新成功。"
    fi
}

# 5.10以上内核
#update_uboot() {
#    TIME w "开始更新uboot"
#    cd ${download_path}
#    curl -LO ${u_boot_url}
#    rm -f /boot/u-boot.ext
#    cp -f ${download_path}/u-boot.ext /boot/u-boot.ext && sync
#    if [ -f "/boot/u-boot.ext" ]; then
#        TIME r "uboot更新成功。"
#    else
#        TIME g "uboot更新失败。"
#    fi
#}

# 5.4内核
update_release_file() {
    TIME w "开始更新内核显示内容。"
    sed -i '/KERNEL_VERSION/d' /etc/flippy-openwrt-release
    echo "KERNEL_VERSION='${kernel_name}'" >>/etc/flippy-openwrt-release
    sed -i '/K510/d' /etc/flippy-openwrt-release
    echo "K510='0'" >>/etc/flippy-openwrt-release
    sed -i "s/ Kernel.*/ Kernel: ${kernel_name}/g" /etc/banner
    sync
    TIME g "内核显示内容更新完毕。"
}

# 5.10以上内核
#update_release_file() {
#    TIME w "开始更新内核显示内容。"
#    sed -i '/KERNEL_VERSION/d' /etc/flippy-openwrt-release
#    echo "KERNEL_VERSION='${kernel_name}'" >>/etc/flippy-openwrt-release
#    sed -i '/K510/d' /etc/flippy-openwrt-release
#    echo "K510='1'" >>/etc/flippy-openwrt-release
#    sed -i "s/ Kernel.*/ Kernel: ${kernel_name}/g" /etc/banner
#    sync
#    TIME g "内核显示内容更新完毕。"
#}



TIME y "开始更新内核。"
download_n1_kernel
update_boot
update_dtb
update_modules
update_uboot
update_release_file
TIME g "内核更新完毕，备重启中。"
sleep 3
reboot
exit 0