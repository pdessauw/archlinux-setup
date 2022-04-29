#!/usr/bin/env bash
# Script to setup SSH daemon and keys
# =========================
SSH_DIR="/root/.ssh"
SSH_KEY="${SSH_DIR}/id_rsa"

pacman -S --noconfirm \
  openssh

ssh-keygen -f ${SSH_KEY} -q -N ''
cat ${SSH_KEY}.pub >> ${SSH_DIR}/authorized_keys

systemctl enable sshd
