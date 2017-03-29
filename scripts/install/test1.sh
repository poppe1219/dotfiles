#!/bin/bash

packages=(
    "p:nitrogen:Wallpaper app"
    "p:compton:Composition manager"
    "p:xorg-xrdb:xorg database app"
    "p:xorg-init:xorg initialization"
    "y:i3status:i3 status bar"
    "y:ttf-iosevka:Font"
    "y:zsh:Z shell"
)

for line in "${packages[@]}"
do
    IFS=':' read -r -a parts <<< "$line"
    #parts=(${line//:/ })
    if [ ${parts[0]} = "p" ]; then
        manager="sudo pacman"
    else
        manager="yaourt"
    fi
    echo "Installing with $manager: ${parts[1]}, ${parts[2]}"

    # Check for installed package: pacman -Qe
    # Split result into name and verison?
    # or...
    # just use: sudo pacman -S --needed chromium
    foo=$(${manager} -S --needed --noconfirm ${parts[1]})
    exit_code=$?
    echo "BAR $exit_code BAR"
    echo "FOO $foo FOO"
done

