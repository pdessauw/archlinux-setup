#!/bin/bash
# Script preparing the machine for the Ansible install.
# ===== Edit the following values =====
BOOT_SIZE="250MiB"
SWAP_SIZE="4GiB"
HDD_PATH="/dev/sda"
ROOT_PASSWORD="*****"

# ==== DO NOT EDIT  PAST THIS LINE ====
# -------------------------------------
timedatectl set-ntp true

parted -s ${HDD_PATH} mklabel msdos mkpart primary ext4 1MiB ${BOOT_SIZE} \
  set 1 boot on \
  mkpart primary linux-swap ${BOOT_SIZE} ${SWAP_SIZE} \
  mkpart primary ext4 ${SWAP_SIZE} 100%
  
mkfs.ext4 ${HDD_PATH}1
mkswap ${HDD_PATH}2
mkfs.ext4 ${HDD_PATH}3

mount ${HDD_PATH}3 /mnt
mkdir /mnt/boot
mount ${HDD_PATH}1 /mnt/boot

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

GIT_REPO="/root/archlinux-setup"
arch-chroot /mnt bash -c """
  pacman -S --noconfirm vim git
  git clone https://github.com/pdessauw/archlinux-setup ${GIT_REPO}

  sed -i \
    -E 's;(ROOT_PASSWORD=\")[^\"]+\";\1${ROOT_PASSWORD}\";' \
    ${GIT_REPO}/install.d/root.sh

  ${GIT_REPO}/install-ansible.sh

  sed -i \
    -E 's;(ROOT_PASSWORD=\")[^\"]+\";\1*****\";' \
    ${GIT_REPO}/install.d/root.sh
"""
