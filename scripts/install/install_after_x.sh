#!/bin/bash

if [ -f /usr/bin/firefox ]; then 
	echo Packages already installed
	sleep 2
else
	HOME_PATH='/home/'
	HOME_PATH+=$USER
	cd $HOME_PATH
	
	
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
	
	cd "$HOME_PATH/.fonts"
	wget https://github.com/zavoloklom/material-design-iconic-font/blob/2.2.0/dist/fonts/Material-Design-Iconic-Font.ttf
	cd $HOME_PATH
	
	sudo pacman -S --noconfirm lxappearance rofi urxvt-perls vim dmidecode htop xorg-xprop tmux tig python-pip
	ln -s "$HOME_PATH/git/dotfiles/.vimrc" "$HOME_PATH/.vimrc"
	sudo pacman -S --noconfirm gtk-theme-arc
	sudo pacman -S --noconfirm firefox
	yaourt -S --noconfirm zsh-autosuggestions
	yaourt -S --noconfirm visual-studio-code  # Could this possibly replace eclipse permanently?
fi
/usr/bin/zsh

