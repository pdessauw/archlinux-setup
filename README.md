# Archlinux install

Bunch of scripts and instructions to properly setup an Archlinux box.

## VM Configuration

*To be written...*

## Preparing the VM

```bash
$ cd /tmp
$ curl -L -O https://bitbucket.org/pdessauw/archlinux-install/raw/master/prepare.sh -u pdessauw
$ chmod +x prepare.sh
$ ./prepare.sh
```

Once the script has ended, run `arch-chroot /mnt` to login to the newly created machine.

## Installation

```bash
$ pacman -S git
$ cd /root
$ git clone https://bitbucket.org/pdessauw/archlinux-install
$ ./install.sh
```

