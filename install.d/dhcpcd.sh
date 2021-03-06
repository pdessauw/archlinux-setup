#!/usr/bin/env bash
# Script configuring DHCP on the main interface.
# =========================
pacman -S --noconfirm \
  dhcpcd

ETH=$(ip link | grep -v lo | sed -r 's; ;;g' | cut -d':' -f2 | head -n1)
systemctl enable "dhcpcd@${ETH}"
systemctl restart "dhcpcd@${ETH}"
