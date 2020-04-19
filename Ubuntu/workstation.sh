#!/bin/sh

printf "Begin Ubuntu 18.04 x86_64 Setup as a Workstation\n"
printf "\n\nEnsure you've already run server.sh\n"

# This script was originally written for Ubuntu Studio, that comes with an
# Xfce4 Desktop. It might need a few modifications for KDE or Gnome.

printf "\n\nRemoving useless software\n\n"
apt remove --purge \
  light-locker \
  update-notifier \
  transmission-gtk \
  parole \
  -y

printf "\n\nSetup VSCode Repo\n\n"
curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscode.list

printf "\n\nSetup Wire Repo\n\n"
curl -s https://wire-app.wire.com/linux/releases.key | apt-key add -
echo "deb [arch=amd64] https://wire-app.wire.com/linux/debian stable main" | tee /etc/apt/sources.list.d/wire-desktop.list

printf "\n\nSetting up Cubic PPA\n\n"
apt-add-repository ppa:cubic-wizard/release -y

printf "\n\nSetting up Unetbootin PPA\n\n"
add-apt-repository ppa:gezakovacs/ppa -y

printf "\n\nSetting up proprietary GPUs PPA\n\n"
add-apt-repository ppa:graphics-drivers/ppa -y

printf "\n\nSetting up Ubuntu Studio Backports\n\n"
add-apt-repository ppa:ubuntustudio-ppa/backports -y

printf "\n\nRunning apt update once\n\n"
apt update

printf "\n\nDownload and install MongoDB Compass Isolated Edition\n\n"
wget -c https://downloads.mongodb.com/compass/mongodb-compass-isolated_1.20.5_amd64.deb
apt install -y ./mongodb-compass-isolated_1.20.5_amd64.deb

printf "\n\nInstall LTS Enablement Stack; Run Full-Upgrade\n\n"
apt install --install-recommends \
	linux-lowlatency-hwe-18.04-edge \
	xserver-xorg-hwe-18.04 \
	xserver-xorg-input-synaptics-hwe-18.04 \
	-y
apt full-upgrade -y

apt install \
  xscreensaver \
  deluge \
  cubic \
  unetbootin \
  fonts-comic-neue \
  guake \
  cpufrequtils \
  pcmanfm-qt \
  redshift-gtk \
  xserver-xorg-input-synaptics \
  xfce4-goodies \
  parcellite \
  arandr \
  code \
  wire-desktop \
  usb-creator-gtk \
  chromium-browser \
  xfce4-pulseaudio-plugin \
  hexchat \
  pgadmin4 \
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

printf "\n\nInstall Insomnia via Snap\n\n"
snap install insomnia

printf "\n\n\Install VLC via Snap\n\n"
snap install vlc

printf "\n\nInstall Slack via Snap\n\n"
snap install slack --classic

printf "\n\nInstall Telegram via Snap\n\n"
snap install telegram-desktop

printf "\n\nInstall Discord via Snap\n\n"
snap install discord

printf "\n\nInstall Microk8s via Snap\n\n"
snap install microk8s --classic

printf "\n\nInstall Eclipse via Snap\n\n"
snap install eclipse --edge --classic

printf "\n\nInstall Android Studio via Snap\n\n"
snap install android-studio --classic

printf "\n\nInstall Arduino IDE via Snap\n\n"
snap install arduino

printf "\n\nInstall IntelliJ Idea Community via Snap\n\n"
snap install intellij-idea-community --classic

printf "\n\nInstall PyCharm Community via Snap\n\n"
snap install pycharm-community --classic

printf "\n\nInstall DBeaver via Snap\n\n"
snap install dbeaver-ce

printf "\n\nInstall KeePassXC via Snap\n\n"
snap install keepassxc

printf "\n\nInstall Redis Desktop Manager via Snap\n\n"
snap install redis-desktop-manager

printf "\n\nInstall Olive Video Editor via Snap\n\n"
snap install olive-editor --edge

printf "\n\nDisable fix the stupid defaults on logind.conf\n\n"
cp ./logind.conf /etc/systemd/logind.conf
systemctl restart systemd-logind

printf "\n\nRun ubuntu-drivers autoinstall and HOPE for the best\n\n"
ubuntu-drivers autoinstall

printf "\n\nSetup MySQL Repo & install Workbench\n\n"
wget -c https://repo.mysql.com//mysql-apt-config_0.8.15-1_all.deb
apt install -y ./mysql-apt-config_0.8.15-1_all.deb
apt update
apt install -y mysql-workbench
apt full-upgrade -y

printf "\n\nFinall Apt Autoremove\n"
apt autoremove -y

printf "\n\nFinished setup of Ubuntu 18.04 Workstation x86_64!\n\n"

