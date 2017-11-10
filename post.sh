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

# Configure zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh); exit"

ORIG=`pwd`
cd /tmp
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
cd ${ORIG}

cp ~/.zshrc ./zshrc
cat ./zshrc | perl -pe 's;(ZSH_THEME=).+$;\1"agnoster";g' > ~/.zshrc
rm ./zshrc

cat data/rc.txt >> ~/.zshrc

