#!/usr/bin/env bash
# Scripts to configure SWAP
# =========================
FSTAB="/etc/fstab"
SWAP_UUID=`lsblk -no UUID /dev/sda2`

echo "# Swap partition" | tee -a ${FSTAB}
echo -e "UUID=${SWAP_UUID} none swap defaults 0 0\n" | tee -a ${FSTAB}
echo "# Shared folder" | tee -a ${FSTAB}
echo -e "data /mnt/data vboxsf gid=users,rw,dmode=775,fmode=664,comment=systemd.automount 0 0\n" | tee -a ${FSTAB}
