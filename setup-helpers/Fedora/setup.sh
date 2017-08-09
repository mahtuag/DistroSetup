#!/bin/sh

printf "Begin system setup - as a development + music production rig\n"
printf "None of the dnf commands use dnf -y\n"
printf "I may have missed a lot of things out so fix them later\n"

printf "dnf update --refresh\n"
dnf update --refresh

printf "install dnf plugins\n"
sudo dnf install dnf-plugins-core

printf "Enable RPM Fusion\n"
dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

printf "Enable Docker Repo\n"
dnf config-manager \
  --add-repo \
  https://download.docker.com/linux/fedora/docker-ce.repo

printf "dnf update --refresh\n"
dnf update --refresh

printf "Remove software we're going to replace"
dnf remove \
  midori \
  abiword \
  gnumetric \
  xfce4-clipman-plugin \
  docker \
  docker-common \
  docker-selinux \
  docker-engine-selinux \
  docker-engine

printf "Install software we need\n"
dnf install \
  firefox \
  chromium \
  zsh \
  levien-inconsolata-fonts \
  byobu \
  parallel \
  leafpad \
  libreoffice \
  gparted \
  git-all \
  mercurial \
  bzr \
  subversion \
  cvs \
  vlc \
  smplayer \
  ffmpeg \
  jack-audio-connection-kit \
  qjackctl \
  a2jmidid \
  jack-audio-connection-kit-dbus \
  keepassx \
  parcellite \
  guake \
  VirtualBox \
  rtirq \
  rosegarden \
  ardour5 \
  hydrogen \
  audacity \
  rakarrack \
  jack-rack \
  fluidsynth \
  qsynth \
  fluid-soundfont-gs \
  fluid-soundfont-gm \
  bristol \
  guitarix \
  ladspa-fil-plugins \
  ladspa-amb-plugins \
  ladspa-calf-plugins \
  ladspa-cmt-plugins \
  ladspa-swh-plugins \
  ladspa-mcp-plugins \
  ladspa-rev-plugins \
  ladspa-blop-plugins \
  ladspa-tap-plugins \
  ladspa-vco-plugins \
  ladspa-caps-plugins \
  ladspa-wasp-plugins \
  vmpk \
  zynaddsubfx \
  iotop \
  htop \
  atop \
  mediawriter \
  hexchat \
  calibre \
  ImageMagick \
  docker-ce

printf "Remove unwanted software"
dnf remove \
  midori \
  abiword \
  gnumetric \
  xfce4-clipman-plugin

