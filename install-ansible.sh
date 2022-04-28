#!/usr/bin/env bash
# Script performing the system installation using Ansible.
# =========================
# Install ansible + necessary collections.
pacman -S ansible
ansible-galaxy collection install \
  community.general

# Setup ansible and config to auto_silent interpreter discovery.
ansible-config init --disable > /etc/ansible/ansible.cfg
sed -i 's/^;\(interpreter_python=\).\+/\1auto_silent/g' \
  /etc/ansible/ansible.cfg

# Run the installation playbook using the provided hosts file.
ansible-playbook ./ansible/setup.yml \
  -i ./ansible/hosts