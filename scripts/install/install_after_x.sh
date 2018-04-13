#!/bin/bash

HOME_PATH='/home/'
HOME_PATH+=$USER
VIMRC_PATH="$HOME_PATH/.vimrc"

if [ ! -f $VIMRC_PATH ]; then 
	
	cd $HOME_PATH
	
	setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll us,se
	mkdir -p "$HOME_PATH/.vim/backups"
	mkdir -p "$HOME_PATH/.vim/swaps"
	
	xrandr --output `xrandr --listmonitors | grep "0:" | cut -d " " -f 6` --auto
	
	i3-msg split h
	i3-msg exec "urxvt -hold -e ./test1.sh"
	
	sudo pacman -S --noconfirm sddm
	sudo systemctl enable sddm.service
	
	git clone git@github.com:robbyrussell/oh-my-zsh.git "$HOME_PATH/.oh-my-zsh"
	rm -f "$HOME_PATH/.zshrc"
	ln -s "$HOME_PATH/git/dotfiles/.zshrc" "$HOME_PATH/.zshrc"
	
	cd "$HOME_PATH/.wallpapers"
	wget http://www.vactualpapers.com/web/wallpapers/material-design-hd-wallpaper-no-1337/2560x2560.png -O hexagonal_pattern_2560x2560.png
	cd $HOME_PATH
	ln -s "$HOME_PATH/git/dotfiles/.config/nitrogen/bg-saved.cfg" "$HOME_PATH/.config/nitrogen/bg-saved.cfg"
	ln -s "$HOME_PATH/git/dotfiles/.config/nitrogen/nitrogen.cfg" "$HOME_PATH/.config/nitrogen/nitrogen.cfg"
	nitrogen --restore 
	mv "$HOME_PATH/.gtkrc-2.0" "$HOME_PATH/.gtkrc-2.0.backup"
	ln -s "$HOME_PATH/git/dotfiles/.gtkrc-2.0" "$HOME_PATH/.gtkrc-2.0"
	mv "$HOME_PATH/.config/gtk-3.0/settings.ini" "$HOME_PATH/.config/gtk-3.0/settings.ini.backup"
	ln -s "$HOME_PATH/git/dotfiles/.config/gtk-3.0/settings.ini" "$HOME_PATH/.config/gtk-3.0/settings.ini"
	
	cd "$HOME_PATH/.fonts"
	wget https://github.com/zavoloklom/material-design-iconic-font/blob/2.2.0/dist/fonts/Material-Design-Iconic-Font.ttf
	cd $HOME_PATH
    ln -s "$HOME_PATH/git/dotfiles/.vimrc" "$VIMRC_PATH"

else
    yaourt -Syy
fi

packages=(
    "pacman:lxappearance:"
    "pacman:rofi:"
    "pacman:urxvt-perls:"
    "pacman:vim:"
    "pacman:neovim:"
    "pacman:chromium:"
    "pacman:dropbox:"
    "pacman:tomboy:"
    "pacman:dmidecode:"
    "pacman:htop:"
    "pacman:xorg-xprop:"
    "pacman:xorg-xfd:"
    "pacman:tmux:"
    "pacman:tig:"
    "pacman:python-pip:"
    "pacman:cups:"
    "pacman:evince:# Pdf viewer."
    "pacman:firefox:"
    "pacman:openssh:"
    "yaourt:zsh-autosuggestions:"
    "yaourt:visual-studio-code-bin:"
    "yaourt:googler:"
    "yaourt:svtplay-dl:"
    "yaourt:youtube-dl:"
    "yaourt:mopidy:# Music server."
    "yaourt:mopidy-spotify:# Addon to use Spotify."
    "yaourt:ncmpcpp:# Music client to Mopidy."
    "yaourt:iftop:# Network monitor."
    "yaourt:urxvt-resize-font-git:"
    "yaourt:libxlsxwriter:"
    "yaourt:sc-im:"
    "yaourt:ttf-hack:"
    "yaourt:gimp:"
    "yaourt:inkscape:"
    "yaourt:spotify:"
    "yaourt:pavucontrol:"
    "yaourt:rdesktop:"
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
    #extra=${parts[2]}
    echo "Checking for package ${package}.";
    if [ -z "$(yaourt -Q ${package})" ] ; then
        echo "Installing with $manager: ${parts[1]}"
        info=$(${manager} -S --noconfirm --needed ${parts[1]})
        exit_code=$?
        echo "Exit code: $exit_code"
        echo "Install return value: $info"
    fi

    ## Run extra command.
    #if [ "${parts[2]}" != "" ]; then
    #    echo "Running extra command: ${parts[2]}"
    #    ${parts[2]}
    #fi
done

sudo systemctl enable sshd.socket
sudo systemctl enable sshd.service

echo ""
echo "Dotfiles Todo"
echo "============="
echo ""
echo "Testing add ssh server capability"
echo "---------------------------------"
echo "Configure non standard port?"
echo ""
echo "Link specific configs per hostname"
echo "----------------------------------"
echo "Get hostname, contat into config filename."
echo "Ex, link from "
echo "~/.config/polybar/config"
echo "To the correct config in the repo:"
echo "~/git/dotfiles/.config/polybar/work_desktop1_config"
echo ""

#/usr/bin/zsh # Start a shell, otherwize the terminal is left "empty".

