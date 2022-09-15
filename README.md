### 斐讯 N1 OpenWrt 固件编译脚本
* 下载跳转[github](https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/tag/openwrt_n1) [网盘](https://drive.kissyouhunter.com)
------------------------------------------------------------------
##### workflows 里主要有三个自动脚本，分别为：
##### 编译 roofts 并利用F大脚本打包 （N1.yml）； 单编译 roofts （n1_roofts.yml）； 利用编译好的 roofts 再用F大脚本打包 （packit_new.yml）
------------------------------------------------------------------
#### 1、编译 roofts 并利用F大脚本打包 （N1.yml） 简单说明：
- KERNEL: 5.4.x  / none    输入5.4 内核打包的内核版本号（例：5.4.176），默认内容为none（不打包5.4 内核）
- KERNEL: 5.10.x / none    输入5.10内核打包的内核版本号（例：5.10.96），默认内容为none（不打包5.10内核）
- KERNEL: 5.10.x / none    输入5.15内核打包的内核版本号（例：5.15.19），默认内容为none（不打包5.15内核）
- KERNEL: 5.10.x / none    输入5.16内核打包的内核版本号（例：5.16.5 ），默认内容为none（不打包5.16内核）
- VER:    22.1.1 / ...     输入大雕 openwrt-roofts 版本号（例：22.1.1），默认内容为22.1.1
- KERNEL_URL：xxxxxxx      定义内核库链接（默认为本人库）
------------------------------------------------------------------
#### 2、利用编译好的 roofts 再用F大脚本打包 （packit_new.yml） 简单说明：
- 和1重复的部分，不再列举
- ROOTFS_URL：xxxxxxx      定义内核roofts下载链接（roofts手动上传到releases里）
------------------------------------------------------------------
#### Actions-OpenWrt-N1 generated from P3TERX/Actions-OpenWrt
