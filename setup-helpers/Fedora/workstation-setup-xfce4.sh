#!/bin/sh

printf "Begin Fedora 29 Xfce Spin Setup\n"
printf "\n\nEnsure you have already run dev-server-setup.sh and workstation-setup.sh\n"

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

printf "\n\nInstall Misc Graphical Tools\n"
dnf install \
  parcellite \
  guake \
  cheese \
  xfce4-sensors-plugin \
  redshift-gtk \
  -y

printf "\n\nInstall Group: Audio Production (Fedora Jam Packages)\n"
dnf group install "Audio Production" -y

printf "\n\nFinished setup of Fedora 29 Xfce Spin!\n"
