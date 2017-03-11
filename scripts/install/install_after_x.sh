#!/bin/bash

if [ -f /usr/bin/firefox ]; then 
	echo "Initial startup. Installation already completed."
else
	HOME_PATH='/home/'
	HOME_PATH+=$USER
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
	
	sudo pacman -S --noconfirm lxappearance
	sudo pacman -S --noconfirm rofi
	sudo pacman -S --noconfirm urxvt-perls
	sudo pacman -S --noconfirm vim
	sudo pacman -S --noconfirm dmidecode
	sudo pacman -S --noconfirm htop
	sudo pacman -S --noconfirm xorg-xprop
	sudo pacman -S --noconfirm tmux
	sudo pacman -S --noconfirm tig
	sudo pacman -S --noconfirm python-pip
	sudo pacman -S --noconfirm cups
	sudo pacman -S --noconfirm evince  # Pdf viewer.
	sudo pacman -S --noconfirm gtk3-print-backends  # So envince can find printers.
	ln -s "$HOME_PATH/git/dotfiles/.vimrc" "$HOME_PATH/.vimrc"
	sudo pacman -S --noconfirm gtk-theme-arc
	sudo pacman -S --noconfirm firefox
	yaourt -S --noconfirm zsh-autosuggestions
	yaourt -S --noconfirm visual-studio-code
	yaourt -S --noconfirm googler
	yaourt -S --noconfirm svtplay-dl
	yaourt -S --noconfirm youtube-dl
	yaourt -S --noconfirm mopidy
	yaourt -S --noconfirm mopidy-spotify
	yaourt -S --noconfirm ncmpcpp
fi
/usr/bin/zsh # Start a shell, otherwize the terminal is left "empty".

