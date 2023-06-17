#!/bin/bash

# Easy installation setup

cp -R .config/* ~/.config/
cp -R bin/* ~/bin/
cp .profile ~/.profile
cp .gtkrc-2.0 ~/.gtkrc-2.0
chmod -R +x ~/.config/sway/scripts
chmod -R +x ~/.config/waybar/scripts
chmod -R +x ~/.config/wofi
chmod -R +x ~/bin
sudo pacman -Syu --needed --noconfirm - < packages-repository.txt
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp .oh-my-zsh/arboy.zsh-theme ~/.oh-my-zsh/arboy.zsh-theme
cp .zshrc ~/.zshrc
dbus-launch dconf load / < xed.dconf
