#!/bin/bash
#
BOOT_SIZE="250MiB"
SWAP_SIZE="4GiB"

timedatectl set-ntp true
# TODO verify ntp
# FIXME configure partition size
parted -s /dev/sda mklabel msdos mkpart primary ext4 1MiB ${BOOT_SIZE} \
  set 1 boot on \
  mkpart primary linux-swap ${BOOT_SIZE} ${SWAP_SIZE} \
  mkpart primary ext4 ${SWAP_SIZE} 100%
  
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
# TODO lsblk -o name,size,fstype to check creation, size and partition

mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap /mnt base
genfstab -U /mnt >> /etc/fstab

# Make it work if you do not switch directory
#cp -r /path/to/git/repo /mnt/root/

echo "Configuration finished. Please run 'arch-chroot /mnt' to continue the installation."

