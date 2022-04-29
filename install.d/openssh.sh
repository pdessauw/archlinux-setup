#!/usr/bin/env bash
# Script performing the system installation using Ansible.
# =========================
# Install ansible + necessary collections.
pacman -S --noconfirm \
  openssh

systemctl enable sshd

