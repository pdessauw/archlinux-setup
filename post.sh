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
sudo mkdir -p /mnt/data /mnt/cdrom
ln -s /mnt/data ~/data

# Prepare makepkg install
sudo pacman -S --noconfirm binutils make gcc pkg-config fakeroot

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Install extra packages
EXTRA_PKGS="firefox-developer-edition atom jetbrains-toolbox robo3t-bin"
yay -S --noconfirm ${EXTRA_PKGS}
sudo cp data/jetbrains-toolbox-icon.png /opt/jetbrains-toolbox/icon.png

# Install necessary fonts
yay -S noto-fonts noto-fonts-extra

# Configure zsh
OH_MY_ZSH="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
sh -c "$(curl -fsSL ${OH_MY_ZSH} | sed -r 's;env zsh;exit;g')"

cp ~/.zshrc ./zshrc
cat ./zshrc | sed -r 's;(ZSH_THEME=).+$;\1"agnoster";g' > ~/.zshrc
cp ~/.zshrc ./zshrc
cat ./zshrc | sed -r 's;^( +git).*$;\1 archlinux;g' > ~/.zshrc
rm ./zshrc

cat data/rc.sh >> ~/.zshrc

# Reboot to take all changes into action
echo "Installation complete. System rebooting in 5 secs..."
sleep 5
sudo reboot

