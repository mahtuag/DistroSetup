#!/bin/sh

printf "Begin system setup\n"

printf "\n\nInitial run of dnf update --refresh\n"
dnf update --refresh

printf "\n\nInstall dnf plugins\n"
sudo dnf install dnf-plugins-core

printf "\n\nEnable RPM Fusion\n"
dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

printf "\n\nEnable Docker Repo\n"
dnf config-manager \
  --add-repo \
  https://download.docker.com/linux/fedora/docker-ce.repo

printf "\n\nRefresh newly added repos via dnf update --refresh\n"
dnf update --refresh

printf "\n\nRemove software we're going to replace\n"
dnf remove \
  midori \
  abiword \
  gnumetric \
  xfce4-clipman-plugin \
  docker \
  docker-common \
  docker-selinux \
  docker-engine-selinux \
  docker-engine \
  transmission

printf "\n\nFrom this point onwards, we shall start using the -y flag for dnf commands\n"

printf "\n\nInstall Misc CLI Tools\n"
dnf install -y \
  zsh \
  byobu \
  parallel \
  iotop \
  htop \
  atop \
  git-all \
  docker-ce \
  ffmpeg \
  ImageMagick

printf "\n\nInstall Misc Graphical Tools\n"
dnf install -y \
  calibre \
  gimp \
  pinta \
  inkscape \
  libreoffice \
  thunderbird \
  vlc \
  deluge \
  chromium \
  levien-inconsolata-fonts \
  smplayer \
  keepassx \
  parcellite \
  guake \
  VirtualBox \
  mediawriter \
  hexchat


printf "\n\nInstall Groups: Dev Tools and Audio Production\n"
dnf group install -y --with-optional \
  "Development Tools" \
  "Audio Production"

printf "\n\nFinished setup of Fedora 26 Xfce Spin x86_64!\n\n"
