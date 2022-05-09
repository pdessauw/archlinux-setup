# Archlinux install

Bunch of scripts and instructions to properly setup an Archlinux box.

## Preparing the machine

```bash
# Download the initialization script.
$ cd /tmp
$ curl -O -L \
    https://raw.github.com/pdessauw/archlinux-setup/master/prepare.sh
# Edit the script parameters.
$ vi prepare.sh
# Run the script!
$ chmod +x prepare.sh
$ ./prepare.sh
```

At the end of the script, the machine will reboot. Log in with the root user and the 
configured password.

## Installation

Move to the folder `/root/archlinux-setup` and check proper internet connectivity.

```bash
$ ping -c3 icann.org
$ ping -c3 1.1.1.1
```

Next, check that ansible can connect to the local machine (Ansible will be using SSH).

```bash
$ ansible -m ping localhost -i ./ansible/hosts
```

When everything is successful, edit the Ansible playbook variable and run the playbook.

```bash
$ vi ./ansible/host_vars/localhost
$ ansible-playbook ./ansible/setup.yml -i ./ansbile/hosts 
```

Finally, type `reboot` to restart the machine and log in with the newly created user.
