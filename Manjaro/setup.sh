#!/bin/sh

# Thanks to this awesome trick for this script:
# https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Install_packages_from_a_list

echo "We'd like to install the following list of server packages:"
sort server.list | tee server.tmplist
echo "We'd like to install the following list of workstation packages:"
sort workstation.list | tee workstation.tmplist
echo "We'd like to install these packages overall:"
cat server.list workstation.list | sort | uniq | tee merged.tmplist
pacman -Slq | sort > pacman-packages.tmplist
pacman -Sg | sort > pacman-groups.tmplist
cat pacman-packages.tmplist pacman-groups.tmplist | sort > pacman-available.tmplist
echo "The following packages will be installed (after excluding unavaiable ones):"
comm -12 pacman-available.tmplist merged.tmplist | tee final-install.tmplist
echo "These packages were skipped because no installation candidates were available for `uname -m` architecture"
comm -23 merged.tmplist final-install.tmplist | tee skipped.tmplist
echo "Running pacman -Syu and installing packages now..."
sudo pacman -Syu --needed < final-install.tmplist
echo "Cleaning up temporary files..."
rm *.tmplist

echo "Stop Grub From Auto-Hiding"
sudo grub-editenv - unset menu_auto_hide
echo "BTW now you can install a mainline kernel and a mainline-realtime kernel!"

printf "\n\nSetup Byobu and make it use Screen in Screen Mode\n"
byobu-ctrl-a screen
byobu-select-backend screen

printf "\n\nAdd user to docker, jackuser and audio groups\n"
sudo usermod -aG docker $USER
sudo usermod -aG jackuser $USER
sudo usermod -aG audio $USER

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

