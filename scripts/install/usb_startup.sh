#!/bin/bash

# Check for parameters
if [ $# != 2 ]; then
	echo "Usage: ./usb_startup.sh <username.github@email.com> <username-github>"
	echo ""
	exit 1
fi

# Check for root.
if test $UID != "0" ; then
	echo "Root access required."
	exit 1
fi

SCRIPT_PATH=$(dirname `which $0`)
SSH_PATH="$SCRIPT_PATH/.ssh"
HOME_PATH="/home/$SUDO_USER"

echo "$SUDO_USER ALL=(ALL) NOPASSWD: /usr/bin/pacman, /usr/bin/systemctl" | sudo tee --append /etc/sudoers.d/10-installer > /dev/null

# Get the ssh keys and config in place.
echo "Copying ssh settings from $SSH_PATH to $HOME_PATH"
cp -r $SSH_PATH $HOME_PATH
ls -la "$HOME_PATH/.ssh/"
chown -R $SUDO_USER:users "$HOME_PATH/.ssh"
# Refresh the ssh config.
eval `ssh-agent -s`
ssh-add -l

# Setup Git
# =========
sudo pacman -S --noconfirm git
sudo -u $SUDO_USER git config --global user.email $1
sudo -u $SUDO_USER git config --global user.name $2

# Get the dotfiles repo, if not already cloned.
mkdir -p "$HOME_PATH/git"
chown -R $2:users "$HOME_PATH/git"
cd "$HOME_PATH/git"
if [ ! -d dotfiles ]; then
    sudo -u $SUDO_USER git clone git@github.com:poppe1219/dotfiles.git
fi
cd "$HOME_PATH/git/dotfiles"
sudo -u $SUDO_USER git pull

cd $HOME_PATH
sudo -u $SUDO_USER git/dotfiles/scripts/install/install.sh
