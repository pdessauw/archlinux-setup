#!/usr/bin/env bash
# Script performing the system installation using Ansible.
# =========================
set -e
INSTALL_DIR="install.d"

for sc in $(find ${INSTALL_DIR} -name "*.sh")
do
  bash ${sc}
done

