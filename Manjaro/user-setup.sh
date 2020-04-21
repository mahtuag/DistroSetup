#!/bin/sh

printf "\n\nSetup Byobu and make it use Screen in Screen Mode\n"
byobu-ctrl-a screen
byobu-select-backend screen

printf "\n\nAdd user to docker, audio, and realtime groups\n"
sudo usermod -aG docker $USER
sudo usermod -aG audio $USER
sudo usermod -aG realtime $USER

printf "\n\nChange shell from $SHELL to /usr/bin/zsh\n"
chsh -s /usr/bin/zsh

printf "\n\nCreate essential directories\n"
mkdir -p ~/tmp ~/ext/bin ~/ext/workspace ~/ext/vault ~/ext/appdata ~/bin ~/go

printf "\n\nDownload ~/.irbirc\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/irbrc -o ~/.irbrc
printf "\n\nDownload ~/.zshrc\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/zshrc -o ~/.zshrc
printf "\n\nDownload ~/.vimrc\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/vimrc -o ~/.vimrc
printf "\n\nDownload ~/.gitconfig\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/gitconfig -o ~/.gitconfig

echo "Installing pipx"
python -m pip install --user pipx
echo "Run pipx install blah instead of pip install blah for sandboxed packages!"

