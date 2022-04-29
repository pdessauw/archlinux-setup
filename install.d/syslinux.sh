#!/usr/bin/env bash
# Scripts to install and configure the bootloader
# =========================
BOOTLOADER="/boot/syslinux/syslinux.cfg"

# Download and install syslinux
pacman -S --noconfirm \
  syslinux

syslinux-install_update -i -a -m

# Save original bootloader config and change default timeout
cp ${BOOTLOADER} ${BOOTLOADER}.orig
sed -i "s;^\(TIMEOUT\) \+[0-9]\+;\1 15;g" ${BOOTLOADER}
