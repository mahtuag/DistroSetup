#!/bin/sh

printf "Running commands as user $USER"

printf "\n\nAdd user to docker, jackuser and audio groups\n"
sudo usermod -aG docker $USER
sudo usermod -aG jackuser $USER
sudo usermod -aG audio $USER

printf "\n\nChange shell from $SHELL to /usr/bin/zsh\n"
chsh -s /usr/bin/zsh

printf "\n\nCreate essential directories\n"
mkdir -p $HOME/ext/bin $HOME/ext/workspace $HOME/ext/vault $HOME/ext/appdata $HOME/bin

printf "\n\nDownload ~/.irbirc\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/master/dotfiles/irbrc -o ~/.irbrc
printf "\n\nDownload ~/.zshrc\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/master/dotfiles/zshrc -o ~/.zshrc
printf "\n\nDownload ~/.vimrc\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/master/dotfiles/vimrc -o ~/.vimrc
printf "\n\nDownload ~/.gitconfig\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/master/dotfiles/gitconfig -o ~/.gitconfig

printf "\n\nInstall Anaconda\n"
rm -r $HOME/ext/bin/anaconda
wget -c https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh
chmod a+x ./Anaconda3-5.1.0-Linux-x86_64.sh
bash ./Anaconda3-5.1.0-Linux-x86_64.sh -b -p $HOME/ext/bin/anaconda

