#!/bin/sh

printf "Begin Fedora 29 Jam Spin Setup\n"
printf "\n\nEnsure you have already run dev-server-setup.sh and workstatio-setup.sh\n"


printf "\n\nInstall Misc Graphical Tools\n"
dnf install \
  yakuake \
  -y

printf "\n\nFinished setup of Fedora 29 Jam Spin x86_64!\n"
