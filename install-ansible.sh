#!/usr/bin/env bash
# Script performing the system installation using Ansible.
# =========================
set -e
INSTALL_DIR="install.d"
find ${INSTALL_DIR} -name "*.sh" -exec bash {} \;
