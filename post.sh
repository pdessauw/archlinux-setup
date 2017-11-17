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

# Install yaourt
sudo pacman -S --needed --noconfirm base-devel yajl
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si --noconfirm
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si --noconfirm
cd ..
rm -rf package-query yaourt

# Install guest additions
VBOX_PKG="virtualbox-guest-modules-arch virtualbox-guest-utils"
sudo pacman -S --noconfirm ${VBOX_PKG}
sudo modprobe -a vboxguest vboxsf vboxvideo

# Install extra packages
EXTRA_PKGS="pygmentize"
yaourt -Syuai --noconfirm ${EXTRA_PKGS}

# Configure zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed -r 's;env zsh;exit;g')"

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

