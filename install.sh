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

# Check Internet access.
if ! [ "`ping -c 1 github.com`" ]; then
    echo "Internet access: Fail"
    echo "This script requres internet access."
    exit 1
fi
echo "Internet access: Ok"

# Check parameters.
if [ $# -ne 2 ]; then
    echo "Usage: ./install.sh your.git@email.com git_username"
    exit 1
fi

HOME_PATH='/home/'
HOME_PATH+=$SUDO_USER
cd $HOME_PATH

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git

# Setup Git
# =========
git config --global user.email $1
git config --global user.name $2

# Get the dotfiles repo, if not already cloned.
mkdir -p git/
cd git
if [ ! -d dotfiles ]; then
    git clone https://github.com/poppe1219/dotfiles
fi
cd dotfiles
git pull

mkdir -p .config/i3

# Add custom repository for installation of Yaourt.
if ! grep "\[archlinuxfr\]" /etc/pacman.conf ; then
    echo "" >> /etc/pacman.conf
    echo "# Add custom repository for installation of Yaourt." >> /etc/pacman.conf
    echo "[archlinuxfr]" >> /etc/pacman.conf
    echo "SigLevel = Never" >> /etc/pacman.conf
    echo "Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
    echo "" >> /etc/pacman.conf
fi

pacman -Sy --noconfirm yaourt
pacman -S --noconfirm dmenu lxappearance feh
sudo -u $SUDO_USER yaourt -S --noconfirm i3-gaps-git
cp /etc/X11/xinit/xinitrc ~/.xinitrc
echo "exec i3 > ~/.i3.log 2>&1" >> ~/.xinitrc
pacman -S --noconfirm vim tmux

sudo chown -R $2:users git .config .xinitrc
