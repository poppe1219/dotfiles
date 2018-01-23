#!/bin/bash


HOME_PATH='/home/'
HOME_PATH+=$USER
VIMRC_PATH="$HOME_PATH/.vimrc"

if [ ! -f $VIMRC_PATH ]; then 
    echo "Foo"
else
    echo "Bar"
fi

packages=(
    "pacman:nitrogen:"
    "pacman:compton:"
    "pacman:xorg-xrdb:"
    "pacman:xorg-init:"
    "yaourt:i3status:"
    "yaourt:ttf-iosevka:"
    "yaourt:zsh:ls"
    "pacman:gtk3-print-backends:"
)

for line in "${packages[@]}"
do
    IFS=':' read -r -a parts <<< "$line"
    if [ ${parts[0]} = "pacman" ]; then
        manager="sudo pacman"
    elif [ ${parts[0]} = "yaourt" ]; then
        manager="yaourt"
    fi
    package=${parts[1]}
    extra=${parts[2]}
    if [ -z "$(yaourt -Q ${package})" ] ; then
        echo "Installing with $manager: ${parts[1]}"
        foo=$(${manager} -S --noconfirm --needed ${parts[1]})
        exit_code=$?
        echo "BAR $exit_code BAR"
        echo "FOO $foo FOO"
    else
        echo "${package} IS installed";
    fi;

    # Run extra command.
    if [ "${parts[2]}" != "" ]; then
        echo "Running extra command: ${parts[2]}"
        ${parts[2]}
    fi
done

