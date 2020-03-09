#!/usr/bin/zsh

printf "Running commands as user $USER"

printf "\n\nEnable Byobu and make it use Screen in Screen Mode\n"
byobu-ctrl-a screen
byobu-select-backend screen
byobu-enable

printf "\n\nAdd user to docker, jackuser and audio groups\n"
sudo usermod -aG docker $USER

printf "\n\nChange shell from $SHELL to /usr/bin/zsh\n"
chsh -s /usr/bin/zsh

printf "\n\nCreate essential directories\n"
mkdir -p $HOME/ext/bin $HOME/ext/workspace $HOME/ext/vault $HOME/ext/appdata $HOME/bin

printf "\n\nDownload ~/.irbirc\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/irbrc -o ~/.irbrc
printf "\n\nDownload ~/.zshrc\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/zshrc -o ~/.zshrc
printf "\n\nDownload ~/.vimrc\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/vimrc -o ~/.vimrc
printf "\n\nDownload ~/.gitconfig\n"
curl -L https://raw.githubusercontent.com/wingedrhino/DistroSetup/trunk/dotfiles/gitconfig -o ~/.gitconfig

# Locally Installed Pip Packages
pip3 install mypy
pip3 install youtube-dl

# printf "\n\nInstall Anaconda\n"
# rm -r $HOME/ext/bin/anaconda
# wget -c https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
# bash Anaconda3-2019.10-Linux-x86_64.sh -b -p $HOME/ext/bin/anaconda
