#!/bin/bash
#
# ===== Edit the following values =====
HOSTNAME="linux"
MAIN_USER="user"

# ==== DO NOT EDIT  PAST THIS LINE ====
# -------------------------------------
# Locale generation
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Timezone
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc

# Hostname generation
echo "${HOSTNAME}" > /etc/hostname

# Install bootloader
pacman -S --noconfirm syslinux
syslinux-install_update -i -a -m

# Configure boot
BOOT_FILE="/boot/syslinux/syslinux.cfg"
BOOT_FILE_ORIG="${BOOT_FILE}.orig"
cp ${BOOT_FILE} ${BOOT_FILE_ORIG}
cat ${BOOT_FILE_ORIG} | perl -pe "s;TIMEOUT [0-9]+;TIMEOUT 15;" > ${BOOT_FILE}

# Enable dhcpcd on net interface
ETH="enp0s3"
systemctl enable dhcpcd@${ETH}

# Install additional packages
pacman -S --noconfirm sudo vim zsh curl wget

# Install desktop application
DESKTOP_PKG="xorg-server xfce4"
pacman -S --noconfirm ${DESKTOP_PKG}

# Install guest additions
VBOX_PKG="virtualbox-guest-modules-arch virtualbox-guest-utils"
pacman -S --noconfirm ${VBOX_PKG}
modprobe -a vboxguest vboxsf vboxvideo

# Installing sudo
visudo

# Root user configuration
echo "Please enter a password for the root user"
passwd

# Main user configuration
useradd -m -g users -G wheel -s /bin/zsh ${MAIN_USER}
echo "Please enter a password for ${MAIN_USER}"
passwd ${MAIN_USER}
echo "exec startxfce4" >> /home/${MAIN_USER}/.xinitrc

# Finish installation of user home
CONFIG_DIR="/home/${MAIN_USER}/.config"
mkdir -p ${CONFIG_DIR}
cp -r ./data/xfce4 ${CONFIG_DIR}

cat ./data/zprofile_add >> /home/${MAIN_USER}/.zprofile

chmod -R ${MAIN_USER}:users /home/${MAIN_USER}

# Root installation
cat ./data/bash_profile_add >> /root/.bash_profile
cat ./data/rc.txt >> /root/.bashrc

echo "Configuration done. Please reboot the machine, login with the newly created user and execute the post.sh script."i

