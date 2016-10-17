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

HOME_PATH='/home/'
HOME_PATH+=$SUDO_USER
cd $HOME_PATH

sudo pacman -Syu --noconfirm

mkdir -p "$HOME_PATH/.config/i3"
mkdir -p "$HOME_PATH/.config/gtk-3.0"
mkdir -p "$HOME_PATH/.config/nitrogen"
mkdir -p "$HOME_PATH/Downloads"
mkdir -p "$HOME_PATH/.fonts"
mkdir -p "$HOME_PATH/.wallpapers"

chown -R "$SUDO_USER:users" $HOME_PATH
chmod +x "$HOME_PATH/git/dotfiles/install_after_x.sh"

cd "$HOME_PATH"
ln -s "$HOME_PATH/git/dotfiles/.gtkrc-2.0" .gtkrc-2.0
ln -s "$HOME_PATH/git/dotfiles/.Xresources" .Xresources
cd "$HOME_PATH/.config/"
ln -s "$HOME_PATH/git/dotfiles/.config/compton.conf" compton.conf
cd "$HOME_PATH/.config/i3"
ln -s "$HOME_PATH/git/dotfiles/.config/i3/config" config
cd "$HOME_PATH/.config/gtk-3.0"
ln -s "$HOME_PATH/git/dotfiles/.config/gtk-3.0/settings.ini" settings.ini
chown -R "$SUDO_USER:users" "$HOME_PATH/.config" "$HOME_PATH/.gtkrc-2.0"
cd "$HOME_PATH"

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
pacman -S --noconfirm nitrogen rxvt-unicode xorg-xrdb compton xorg-xinit
systemctl enable sddm.service
sudo -u $SUDO_USER yaourt -S --noconfirm i3-gaps-git i3status ttf-iosevka zsh
chsh -s /bin/zsh $SUDO_USER  # Set default shell to zsh.
touch "$HOME_PATH/.xinitrc"
echo "exec i3 > ~/.i3.log 2>&1" >> "$HOME_PATH/.xinitrc"

SYS_PROD_NAME=`sudo dmidecode -s system-product-name`
if [ $SYS_PROD_NAME = "VirtualBox" ] ; then
    echo "VirtualBox detected, installing guest additions."
    yes | pacman -S virtualbox-guest-modules-arch  # Force yes on all answers.
fi

touch "$HOME_PATH/.Xauthority"

chown -R "$SUDO_USER:users" $HOME_PATH

sudo -u $SUDO_USER startx