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
sud apt full-upgrade -y

sudo apt install \
  ubuntustudio-installer \
  xscreensaver \
  deluge \
  cubic \
  fonts-comic-neue \
  yakuake \
  cpufrequtils \
  pcmanfm-qt \
  xfce4-goodies \
  parcellite \
  arandr \
  usb-creator-gtk \
  chromium-browser \
  pgadmin4 \
  mysql-workbench \
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

# This is needed for being able to read disk temp as a non-root sudo user
chmod u+s /usr/sbin/hddtemp

echo "Fix the stupid defaults on logind.conf"
cp ./logind.conf /etc/systemd/logind.conf
systemctl restart systemd-logind

echo "Run ubuntu-drivers autoinstall and HOPE for the best"
ubuntu-drivers autoinstall

echo "Finall Apt Autoremove"
apt autoremove -y

echo "Finished setup of Kubuntu 20.04 Workstation x86_64!"

echo "Now run Ubuntu Studio Installer from your Start Menu for setting up Studio Tools"
