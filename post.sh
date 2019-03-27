#!/bin/bash
#
# ===== Edit the following values =====


# ==== DO NOT EDIT  PAST THIS LINE ====
# -------------------------------------
# Configure swap
FSTAB="/etc/fstab"
SWAP_UUID=`lsblk -no UUID /dev/sda2`
echo "# Swap partition" | sudo tee -a ${FSTAB}
echo -e "UUID=${SWAP_UUID} none swap defaults 0 0\n" | sudo tee -a ${FSTAB}
echo "# Shared folder" | sudo tee -a ${FSTAB}
echo -e "data /mnt/data vboxsf gid=users,rw,dmode=775,fmode=664,comment=systemd.automount 0 0\n" | sudo tee -a ${FSTAB}

# Configure shared folder
mkdir -p /mnt/data
ln -s /mnt/data ~/data

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Install guest additions
VBOX_PKG="virtualbox-guest-modules-arch virtualbox-guest-utils"
sudo pacman -S --noconfirm ${VBOX_PKG}
sudo modprobe -a vboxguest vboxsf vboxvideo

# Install extra packages
EXTRA_PKGS="ncdu pydf pygmentize firefox-developer chromium atom jetbrains-toolbox studio-3t"
yaourt -Syua --noconfirm ${EXTRA_PKGS}
sudo cp data/jetbrains-toolbox-icon.png /opt/jetbrains-toolbox/icon.png

# Configure zsh
OH_MY_ZSH="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
sh -c "$(curl -fsSL ${OH_MY_ZSH} | sed -r 's;env zsh;exit;g')"

ORIG=`pwd`
cd /tmp
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
cd ${ORIG}

cp ~/.zshrc ./zshrc
cat ./zshrc | sed -r 's;(ZSH_THEME=).+$;\1"agnoster";g' > ~/.zshrc
cp ~/.zshrc ./zshrc
cat ./zshrc | sed -r 's;^( +git).*$;\1 archlinux colorize;g' > ~/.zshrc
rm ./zshrc

cat data/rc.sh >> ~/.zshrc

# Reboot to take all changes into action
echo "Installation complete. System rebooting in 5 secs..."
sleep 5
sudo reboot

