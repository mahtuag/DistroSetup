#!/bin/sh

echo "Preparing system for user $USER"
echo "Run this command for all users (including root)!"

echo "Setup Byobu\n"
byobu-ctrl-a emacs
echo "Install ~/.irbirc"
cp ../dotfiles/irbrc ~/.irbrc
echo "Install ~/.zshrc"
cp ../dotfiles/zshrc ~/.zshrc
echo "Install ~/.vimrc"
cp ../dotfiles/vimrc ~/.vimrc
echo "Install ~/.gitconfig"
cp ../dotfiles/gitconfig ~/.gitconfig

echo "Create essential directories"
mkdir -p $HOME/ext/bin $HOME/ext/workspace $HOME/ext/vault $HOME/ext/appdata $HOME/bin $HOME/go

echo "Change shell from $SHELL to /usr/bin/zsh"
chsh -s /usr/bin/zsh
