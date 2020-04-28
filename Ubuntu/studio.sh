#!/bin/sh

echo "Begin Ubuntu 20.04 Studio Setup"
echo "Ensure you've already run server.sh and workstation.sh"

echo "Setting up OBS Studio PPA"
sudo add-apt-repository ppa:obsproject/obs-studio -y

apt install \
  ubuntustudio-installer \
  fonts-comic-neue \
  v4l-utils \
  v4l2loopback-dkms \
  v4l2loopback-utils \
  obs-studio \
  -y

echo "Finall Apt Autoremove"
sudo apt autoremove -y

echo "Finished Ubuntu 20.04 Studio Setup!"

