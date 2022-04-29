#!/bin/bash
pacman -S --noconfirm \
  dhcpcd

ETH=$(ip link | grep -v lo | sed -r 's; ;;g' | head -n1)
systemctl enable dhcpcd@${ETH}

