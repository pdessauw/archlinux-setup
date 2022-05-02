#!/usr/bin/env bash
# Script performing the system installation using Ansible.
# =========================
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALL_DIR="${SCRIPT_DIR}/install.d"
find "${INSTALL_DIR}" -name "*.sh" -exec bash {} \;
