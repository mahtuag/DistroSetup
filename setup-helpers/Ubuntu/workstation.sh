#!/bin/sh

printf "Begin Ubuntu 18.04 Workstation x86_64 Setup\n"
printf "\n\nEnsure you've already run server.sh\n"

# Note: You'd probably be better off setting up Ubuntu Workstation starting with
# installing Ubuntu Studio, instead of starting with installing Ubuntu Desktop.
# Studio has all the media production tools already setup for you and it runs
# Xfce, which is the better Desktop Environment.
# Edit: This script IS written for Ubuntu Studio now

printf "\n\nSetup Slack Repo\n\n"
# Edit: The below command doesn't work because the repo is missing
# curl -s https://packagecloud.io/install/repositories/slacktechnologies/slack/script.deb.sh | bash
# We are installing Slack via Snap
snap install slack --classic

printf "\n\nSetup VSCode Repo\n\n"
curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscode.list

printf "\n\nRunning apt update once\n\n"
apt update

apt install \
  fonts-comic-neue \
  guake \
  pcmanfm-qt \
  redshift-gtk \
  xserver-xorg-input-synaptics \
  xfce4-goodies \
  parcellite \
  code \
  slack \
  setbfree \
  amsynth \
  whysynth \
  drumkv1 \
  samplv1 \
  qmidiarp \
  keepassx \
  -y

printf "\n\nSetting up Ubuntu Studio Backports\n\n"
add-apt-repository ppa:ubuntustudio-ppa/backports
apt update -y
printf "\n\nFinal run of apt full-upgrade\n\n"
apt full-upgrade -y

# This is needed for being able to read disk temp as a non-root sudo user
chmod u+s /usr/sbin/hddtemp

printf "\n\nInstall Insomnia via Snap\n\n"
snap install insomnia

printf "\n\n\Install VLC via Snap\n\n"
snap install vlc

printf "\n\nInstall LTS Enablement Stack & Run Full-Upgrade\n\n"
apt install --install-recommends xserver-xorg-hwe-18.04 linux-lowlatency-hwe-18.04-edge -y
apt update
apt full-upgrade -y


printf "\n\nFinished setup of Ubuntu 18.04 Workstation x86_64!\n\n"
