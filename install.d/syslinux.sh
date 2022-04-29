#!/bin/bash
pacman -S --noconfirm \
  syslinux

syslinux-install_update -i -a -m

