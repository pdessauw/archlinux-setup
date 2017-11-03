#!/bin/bash
#
# ===== Edit the following values =====
MAIN_USER="pnd"


# ==== DO NOT EDIT  PAST THIS LINE ====
# -------------------------------------
# Configure swap
FSTAB="/etc/fstab"
SWAP_UUID=`lsblk -no UUID /dev/sda2`
echo "# Swap partition" >> ${FSTAB}
echo -e "UUID=${SWAP_UUID} none swap defaults 0 0\n" >> ${FSTAB}

