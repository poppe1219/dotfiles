#!/bin/bash

# Check script requirements
# =========================

# Check if running as root.
if test $UID != "0" ; then
    echo "Root access: Fail"
    echo "This script requires root access. Use sudo and enter password."
    exit 1
fi
echo "Root access: Ok"

# check Internet access.
if ! [ "`ping -c 1 google.com`" ]; then
    echo "Internet access: Fail"
    echo "This script requres internet access."
    exit 1
fi
echo "Internet access: Ok"

HOME_PATH='/home/'
HOME_PATH+=$USER
cd $HOME_PATH

mkdir .config
mkdir .config/i3

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm dmenu lxappearance feh

# Add custom repository for installation of Yaourt.
echo "" >> /etc/pacman.conf
echo "# Add custom repository for installation of Yaourt." >> /etc/pacman.conf
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
echo "" >> /etc/pacman.conf

pacman -Sy --noconfirm yaourt

