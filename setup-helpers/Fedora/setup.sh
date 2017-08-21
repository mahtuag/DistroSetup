#!/bin/sh

printf "Begin system setup\n"

printf "\n\nInitial run of dnf update --refresh\n"
dnf update --refresh

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
  transmission \
  geany \
  pragha \
  parole

printf "\n\nInstall Misc CLI Tools\n"
dnf install \
  vim \
  zsh \
  byobu \
  parallel \
  iotop \
  htop \
  atop \
  nethogs \
  git-all \
  docker-ce \
  ffmpeg \
  gvfs-mtp \
  fuse-exfat \
  gvfs-fuse \
  ImageMagick

printf "\n\nInstall Misc Graphical Tools\n"
dnf install \
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
  google-roboto-fonts \
  google-roboto-mono-fonts \
  google-roboto-slab-fonts \
  smplayer \
  keepassx \
  parcellite \
  guake \
  VirtualBox \
  mediawriter \
  hexchat \
  cheese \
  xfce4-sensors-plugin \
  pcmanfm-qt


printf "\n\nInstall Group: Development Tools (with optional packages)\n"
dnf group install --with-optional "Development Tools"

printf "\n\n Install Group: Audio Production (Fedora Jam Packages)\n"
dnf group install "Audio Production"

printf "\n\nFinished setup of Fedora 26 Xfce Spin x86_64!\n\n"
