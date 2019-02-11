#!/bin/sh

printf "Begin Ubuntu 18.04 Workstation x86_64 Setup\n"
printf "\n\nEnsure you've already run server.sh\n"

# Note: You'd probably be better off setting up Ubuntu Workstation starting with
# installing Ubuntu Studio, instead of starting with installing Ubuntu Desktop.
# Studio has all the media production tools already setup for you and it runs
# Xfce, which is the better Desktop Environment.

sudo apt install \
  fonts-comic-neue \
  darktable \
  -y

# TODO add more content here

printf "\n\nFinished setup of Ubuntu 18.04 Workstation x86_64!\n\n"
