#!/bin/bash

# Check script requirements
# =========================

# Check Internet access.
if ! [ "`ping -c 1 github.com`" ]; then
    echo "Internet access: Fail"
    exit 1
fi
echo "Internet access: Ok"

HOME_PATH='/home/'
HOME_PATH+=$USER
cd $HOME_PATH

sudo pacman -Syyu --noconfirm

mkdir -p "$HOME_PATH/.config/i3"
mkdir -p "$HOME_PATH/.config/gtk-3.0"
mkdir -p "$HOME_PATH/.config/nitrogen"
mkdir -p "$HOME_PATH/.config/polybar"
mkdir -p "$HOME_PATH/.config/mopidy"
mkdir -p "$HOME_PATH/Downloads"
mkdir -p "$HOME_PATH/.fonts"
mkdir -p "$HOME_PATH/.wallpapers"

sudo chown -R "$USER:users" $HOME_PATH
sudo chmod +x "$HOME_PATH/git/dotfiles/install_after_x.sh"

cd "$HOME_PATH"
ln -s "$HOME_PATH/git/dotfiles/.gtkrc-2.0" .gtkrc-2.0
ln -s "$HOME_PATH/git/dotfiles/.Xresources" .Xresources
ln -s "$HOME_PATH/git/dotfiles/.tmux.conf" .tmux.conf
cd "$HOME_PATH/.config/"
ln -s "$HOME_PATH/git/dotfiles/.config/compton.conf" compton.conf
cd "$HOME_PATH/.config/i3"
ln -s "$HOME_PATH/git/dotfiles/.config/i3/config" config
cd "$HOME_PATH/.config/polybar"
ln -s "$HOME_PATH/git/dotfiles/.config/polybar/config" config
ln -s "$HOME_PATH/git/dotfiles/.config/polybar/launch.sh" launch.sh
cd "$HOME_PATH/.config/mopidy"
ln -s "$HOME_PATH/git/dotfiles/.config/mopidy/mopidy.conf" mopidy.conf
cd "$HOME_PATH/.config/gtk-3.0"
ln -s "$HOME_PATH/git/dotfiles/.config/gtk-3.0/settings.ini" settings.ini
sudo chown -R "$USER:users" "$HOME_PATH/.config" "$HOME_PATH/.gtkrc-2.0"
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

sudo pacman -Sy --noconfirm yaourt
sudo pacman -S --noconfirm nitrogen rxvt-unicode xorg xorg-xrdb compton xorg-xinit
yaourt -S --noconfirm i3-gaps-git i3status ttf-iosevka zsh polybar
sudo chsh -s /bin/zsh $USER  # Set default shell to zsh.
touch "$HOME_PATH/.xinitrc"
if ! grep "exec i3 "$HOME_PATH/.xinitrc" ; then
    echo "exec i3 > ~/.i3.log 2>&1" >> "$HOME_PATH/.xinitrc"
fi

SYS_PROD_NAME=`sudo dmidecode -s system-product-name`
if [[ "${SYS_PROD_NAME}" -eq "VirtualBox" ]] ; then
    echo "VirtualBox guest system install detected, installing guest additions."
    yes | sudo pacman -S virtualbox-guest-modules-arch  # Force yes on all answers.
else:
    echo "Installing VirtualBox host system."
    sudo pacman -S --noconfirm virtualbox-host-modules-arch  # Force yes on all answers.
    sudo pacman -S --noconfirm virtualbox-guest-is
    yaourt -S --noconfirm virtualbox-ext-oracle
fi

sudo chown -R "$USER:users" $HOME_PATH

startx
