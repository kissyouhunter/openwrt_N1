#!/bin/bash
# https://github.com/gd0772/AutoBuild-OpenWrt
# common Module by gd0772
# matrix.target=${Modelfile}


################################################################################################################
# LEDE源码通用diy2.sh文件
Diy_lede2() {
DIY_GET_COMMON_SH
cp -Rf "${Home}"/diy/* "${Home}"
}
