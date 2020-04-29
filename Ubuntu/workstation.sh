#!/bin/sh

echo "Begin Ubuntu 20.04 Setup as a Workstation"
echo "Ensure you've already run server.sh"
echo "This script was designed to be installed on top of Kubuntu"

echo "Setting up Cubic PPA"
sudo apt-add-repository ppa:cubic-wizard/release -y

echo "Setting up proprietary GPUs PPA"
sudo add-apt-repository ppa:graphics-drivers/ppa -y

echo "Setup MySQL Repo"
wget -c https://repo.mysql.com//mysql-apt-config_0.8.15-1_all.deb
sudo apt install -y ./mysql-apt-config_0.8.15-1_all.deb

echo "Running apt update once"
sudo apt update

echo "Download and install MongoDB Compass Isolated Edition"
wget -c https://downloads.mongodb.com/compass/mongodb-compass-isolated_1.20.5_amd64.deb
sudo apt install -y ./mongodb-compass-isolated_1.20.5_amd64.deb

echo "Install LTS Enablement Stack; Run Full-Upgrade"
# sudo apt install --install-recommends \
# 	linux-lowlatency-hwe-20.04-edge \
# 	xserver-xorg-hwe-20.04 \
# 	xserver-xorg-input-synaptics-hwe-20.04 \
# 	-y
sudo apt full-upgrade -y

sudo apt install \
  xscreensaver \
  deluge \
  cubic \
  fonts-comic-neue \
  yakuake \
  kamaso \
  kdevelop \
  kdevelop-php \
  kdevelop-python \
  kdeedu \
  kio-gdrive \
  zeroconf-ioslave \
  kwave \
  kompare \
  akregator \
  kdiff3 \
  konqueror \
  kde-full \
  cpufrequtils \
  pcmanfm-qt \
  arandr \
  chromium-browser \
  pgadmin4 \
  mysql-workbench-community \
  gparted \
  gnome-disk-utility \
  openjdk-8-jdk \
  adb \
  fastboot \
  mtp-tools \
  libmtp-common \
  libmtp-dev \
  libmtp-runtime \
  libmtp9 \
  -y

echo "Run ubuntu-drivers autoinstall and HOPE for the best"
sudo ubuntu-drivers autoinstall

echo "Finall Apt Autoremove"
sudo apt autoremove -y

echo "Finished setup of Kubuntu 20.04 Workstation x86_64!"

