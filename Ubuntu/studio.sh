#!/bin/sh

printf "Begin Ubuntu 18.04 x86_64 Setup as a Creator Studio\n"
printf "\n\nEnsure you've already run server.sh and workstation.sh\n"

printf"\n\nSetting up OBS Studio PPA\n\n"
add-apt-repository ppa:obsproject/obs-studio -y

printf "\n\nRunning apt update once\n\n"
apt update

printf "\n\nDownload and install KXStudio Meta Repo\n\n"
wget -c https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb
apt install -y ./kxstudio-repos_10.0.3_all.deb
apt update

apt install \
  fonts-comic-neue \
  v4l-utils \
  v4l2loopback-dkms \
  v4l2loopback-utils \
  obs-studio \
  ardour \
  zynaddsubfx \
  calf-plugins \
  x42-plugins \
  setbfree \
  yoshimi \
  guitarix \
  gxtuner \
  -y
printf "\n\nFinall Apt Autoremove\n"
apt autoremove -y

printf "\n\nFinished setup of Ubuntu 18.04 Creator Studio x86_64!\n\n"

