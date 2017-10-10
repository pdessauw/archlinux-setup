#!/bin/bash
#

timedatectl set-ntp true
# TODO verify ntp
# FIXME configure partition size
parted -s /dev/sda mklabel msdos mkpart primary ext4 1MiB 250MiB set 1 boot on mkpart primary linux-swap 250MiB 4GiB mkpart primary ext4 4GiB 100%
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

