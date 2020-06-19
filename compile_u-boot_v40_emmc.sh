#!/usr/bin/env bash
###compile uboot m2u
echo "\033[36m Compile U-boot emmc for M2U(R40).\033[0m"
echo "\033[36m Installing dependencies.\033[0m"
sudo apt update && sudo apt install -y swig python3-dev git make gcc flex bison
echo "\033[36m changing folder.\033[0m"
cd /tmp
echo "\033[36m cloning u-boot.\033[0m"
git clone -b audio-codec https://github.com/juanesf/u-boot.git && cd u-boot && make bananapi_m2_berry_defconfig && make -j $(nproc)
echo "\033[36m make boot.scr.\033[0m"
mkimage -C none -A arm -T script -d /tmp/u-boot/r40_boot.cmd boot.scr
echo "\033[36m copying binary u-boot emmc.\033[0m"
sudo dd if=/tmp/u-boot/u-boot-sunxi-with-spl.bin of=/dev/mmcblk1 bs=1024 seek=8
echo "\033[36m copying new dtb emmc.\033[0m"
sudo cp /tmp/u-boot/arch/arm/dts/sun8i-v40-bananapi-m2-berry.dtb /boot/dtb
echo "\033[36m Please reboot Now.\033[0m"



###dtc -I dtb -O dts /tmp/u-boot/arch/arm/dts/sun8i-r40-bananapi-m2-ultra.dtb -o /tmp/tmp.dts && less /tmp/tmp.dts



###rm -Rf u-boot
###git clone https://github.com/juanesf/u-boot.git && cd u-boot && make CROSS_COMPILE=arm-linux-gnueabihf- Bananapi_M2_Ultra_defconfig && make -j $(nproc) CROSS_COMPILE=arm-linux-gnueabihf-
###dtc -I dtb -O dts /tmp/u-boot/arch/arm/dts/sun8i-r40-bananapi-m2-ultra.dtb -o /tmp/tmp.dts
###less /tmp/tmp.dts

###sudo cp /lib/firmware/ap6212/nvram.txt /lib/firmware/brcm/brcmfmac43430-sdio.sinovoip,bpi-m2-ultra.txt
###sudo cp /lib/firmware/ap6212/fw_bcm43438a1.bin /lib/firmware/brcm/brcmfmac43430-sdio.bin
###sudo cp /lib/firmware/ap6212/bcm43438a0.hcd /lib/firmware/brcm/bcm43430a1.hcd
