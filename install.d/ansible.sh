#!/usr/bin/env bash
# Script installing Ansible and dependencies.
# =========================
# Install ansible + necessary collections.
pacman -S --noconfirm \
  ansible
ansible-galaxy collection install \
  community.general

# Setup ansible and config to auto_silent interpreter discovery.
ansible-config init --disable > /etc/ansible/ansible.cfg
sed -i 's/^;\(interpreter_python=\).\+/\1auto_silent/g' \
  /etc/ansible/ansible.cfg

