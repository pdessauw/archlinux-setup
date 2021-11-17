# Archlinux install

Bunch of scripts and instructions to properly setup an Archlinux box.

## VM Configuration

*To be written...*

## Preparing the VM

```bash
$ cd /tmp
$ curl -O -L \
    https://raw.githubusercontent.com/pdessauw/archlinux-setup/master/prepare.sh
```

Edit the script parameters to your liking, using `vi prepare.sh`.

```bash
$ chmod +x prepare.sh
$ ./prepare.sh
```

Once the script has ended, run `arch-chroot /mnt` to login to the newly created 
machine.

## Installation

```bash
$ pacman -S vim git
$ cd /root
$ git clone https://github.com/pdessauw/archlinux-setup
$ cd archlinux-setup
```

Edit the script parameters to your liking, using `vim install.sh`.

```bash
$ ./install.sh
```

> *Note:*   When the visudo window appears, make sure to uncomment the line 
>           allowing the `sudo` group to perform sudo operations. 

Type `exit` to go back to the installation media and `reboot` to start on the 
new machine.

## Post-installation

After restarting the machine, log in with your newly created user.

```bash
$ sudo mv /root/archlinux-setup ~
$ sudo chown -R $USER:users ~/arch-setup
$ cd ~/arch-setup
$ ./post.sh
```
