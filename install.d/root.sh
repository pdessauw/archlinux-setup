#!/usr/bin/env bash
# Script configuring the root user.
# =========================
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_PASSWORD="*****"  # WARNING: the value will be overwritten.

cat "${SCRIPT_DIR}/../data/bash_profile_add" >> /root/.bash_profile
cat "${SCRIPT_DIR}/../data/rc.sh" >> /root/.bashrc

echo -e "${ROOT_PASSWORD}/n${ROOT_PASSWORD}" | passwd &> /dev/null
