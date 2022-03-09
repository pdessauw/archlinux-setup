#!/bin/bash
# Pre-installation steps for an Archlinux machine.
#
# This script is adapted from:
#   https://wiki.archlinux.org/title/Installation_guide#Pre-installation
#
# ===== Edit the following values =====
BOOT_SIZE="250MiB"
SWAP_SIZE="4GiB"
HDD_PATH="/dev/sda"

# ==== DO NOT EDIT  PAST THIS LINE ====
# -------------------------------------
# Update system clock.
timedatectl set-ntp true

# Partition the disk.
parted -s ${HDD_PATH} \
  mklabel msdos \
  mkpart primary ext4 1MiB ${BOOT_SIZE} \
  set 1 boot on \
  mkpart primary linux-swap ${BOOT_SIZE} ${SWAP_SIZE} \
  mkpart primary ext4 ${SWAP_SIZE} 100%

# Format the partitions.
mkfs.ext4 ${HDD_PATH}1
mkswap ${HDD_PATH}2
mkfs.ext4 ${HDD_PATH}3

# Mount the filesystem.
mount ${HDD_PATH}3 /mnt
mkdir /mnt/boot
mount ${HDD_PATH}1 /mnt/boot

# Install the essentials.
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

echo "Configuration finished. Please run 'arch-chroot /mnt' to continue the " \
  "installation."
