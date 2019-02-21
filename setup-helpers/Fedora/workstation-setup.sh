#!/bin/sh

printf "Begin Fedora 29 common graphical environment setup\n"
printf "\n\nEnsure you have already run dev-server-setup.sh\n"

printf "\n\nInstall Slack\n"
wget -c https://downloads.slack-edge.com/linux_releases/slack-3.3.7-0.1.fc21.x86_64.rpm
dnf install -y slack-3.3.7-0.1.fc21.x86_64.rpm

printf "\n\nEnable VSCode Repo\n"
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

printf "\n\nRefresh newly added repos via dnf update --refresh\n"
dnf update --refresh -y

printf "\n\nRemove software we're going to replace\n"
dnf remove \
  dnfdragora \
  abiword \
  gnumetric \
  xfce4-clipman-plugin \
  transmission \
  geany \
  pragha \
  parole \
  claws-mail* \
  rhythmbox \
  evolution \
  -y

printf "\n\nInstall Misc CLI Tools\n"
dnf install \
  gvfs-mtp \
  simple-mtpfs \
  fuse-exfat \
  gvfs-fuse \
  -y

printf "\n\nInstall Misc Graphical Tools\n"
dnf install \
  calibre \
  gimp \
  pinta \
  inkscape \
  darktable \
  libreoffice \
  vlc \
  deluge \
  chromium \
  levien-inconsolata-fonts \
  google-roboto-fonts \
  google-roboto-mono-fonts \
  google-roboto-slab-fonts \
  smplayer \
  keepassx \
  VirtualBox \
  mediawriter \
  hexchat \
  code \
  pcmanfm-qt \
  telegram-desktop \
  dssi-vst \
  comic-neue-fonts \
  comic-neue-angular-fonts \
  -y

printf "\n\nFinished setup of Fedora 29 common graphical environment!\n"

