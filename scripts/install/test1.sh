#!/bin/bash


pacman_packages=(
    # Foo
    nitrogen
    compton
    # Bar
    xorg-xrdb
    xorg-init
)

yaourt_packages=(
    i3status
    ttf-iosevka
    zsh
)

for i in "${pacman_packages[@]}"
do
    echo "Installing package: $i"
    #urxvt -e sudo pacman -S --noconfirm $i
    i3-msg "workspace 2: Terminals; exec sleep 0.3 && urxvt -e sudo pacman -S --noconfirm $i"
done

for i in "${yaourt_packages[@]}"
do
    echo "Installing package: $i"
    #urxvt -e yaourt -S --noconfirm $i
    i3-msg "workspace 2: Terminals; exec sleep 0.3 && urxvt -e yaourt -S --noconfirm $i"
done

