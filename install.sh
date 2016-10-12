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
mkdir -p "$HOME_PATH/Downloads"
mkdir -p "$HOME_PATH/.fonts"
mkdir -p "$HOME_PATH/.wallpapers"

chown -R "$SUDO_USER:users" $HOME_PATH

cd "$HOME_PATH"
ln -s "$HOME_PATH/git/dotfiles/.gtkrc-2.0" .gtkrc-2.0
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
pacman -S --noconfirm lxappearance feh sddm xterm rofi rxvt-unicode xorg-xrdb firefox tig
sudo systemctl enable sddm.service
sudo -u $SUDO_USER yaourt -S --noconfirm i3-gaps-git i3lock ttf-iosevka zsh
touch "$HOME_PATH/.xinitrc"
echo "exec i3 > ~/.i3.log 2>&1" >> "$HOME_PATH/.xinitrc"

chown -R $SUDO_USER:users "$HOME_PATH/.xinitrc"
pacman -S --noconfirm vim tmux
sudo -u $SUDO_USER yaourt -S --noconfirm gtk-theme-arc-grey-git

cd Downloads
wget -q https://github.com/supermarin/YosemiteSanFranciscoFont/archive/master.zip
unzip master.zip
cd YosemiteSanFranciscoFont-master
mv *.ttf "$HOME_PATH/.fonts/"
cd $HOME_PATH
rm -rf YosemiteSanFranciscoFont-master
rm -f master.zip

sudo -u $SUDO_USER sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /usr/bin/zsh $SUDO_USER
cd .wallpapers
wget https://wallpaperscraft.com/image/frog_reflection_vector_24442_3840x2400.jpg
cd $HOME_PATH
feh  --bg-scale '~/.wallpapers/frog_reflection_vector_24442_3840x2400.jpg' 

chown -R "$SUDO_USER:users" $HOME_PATH




