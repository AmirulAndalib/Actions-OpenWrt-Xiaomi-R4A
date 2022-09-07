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

# 修改主机名字，把Xiaomi-R4A修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='Xiaomi-R4A'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i "s/OpenWrt /ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 修改默认wifi名称ssid为Xiaomi_R4A
sed -i 's/ssid=OpenWrt/ssid=Xiaomi_R4A/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Install Luci Theme Neobird
git clone https://github.com/thinktip/luci-theme-neobird package/luci-theme-neobird

default_theme='Neobird'	
sed -i "s/bootstrap/$default_theme/g" feeds/luci/modules/luci-base/root/etc/config/luci

# change lang from CN to EN
sed -i "s/zh_cn/en/g" package/lean/default-settings/files/zzz-default-settings
sed -i "s/+@LUCI_LANG_zh-cn/+@LUCI_LANG_en/g" package/lean/default-settings/Makefile
sed -i "/po2lmo ./po/zh-cn/default.po/d" package/lean/default-settings/Makefile

# Install AdguardHome
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/feeds/luci/luci-app-adguardhome