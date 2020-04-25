#!/bin/sh

echo "Begin Ubuntu 20.04 Server Setup"

echo "Initial run of apt update & full-upgrade"
sudo apt update -y
sudo apt dist-upgrade -y

echo "Install software needed for installer"
sudo apt install curl apt-transport-https

echo "Enable Universe Repo"
sudo add-apt-repository universe -y

echo "Enable Node.js Repo"
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
echo "deb https://deb.nodesource.com/node_14.x bionic main" | sudo tee /etc/apt/sources.list.d/node.list
echo "deb-src https://deb.nodesource.com/node_14.x bionic main" | sudo tee /etc/apt/sources.list.d/node.list

echo "Enable Yarn Repo"
curl -s https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

echo "Enable Kubernetes Repo"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "Enable PostgreSQL Global Development Group Repo"
curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list

echo "Enable Certbot PPA Repository for Let's Encrypt"
sudo add-apt-repository ppa:certbot/certbot -y

echo "Refresh newly added repos via apt update"
sudo apt update

echo "Install LTS Enablement Stack & Run Full-Upgrade"
# apt install --install-recommends linux-generic-hwe-20.04-edge -y
sudo apt full-upgrade -y

echo "Enable Docker Service"
sudo systemctl enable docker

echo "Replacing Apache2 with NGINX and copying over sample NGINX configs"
sudo cp ../../nginx/*.conf /etc/nginx/sites-available/

echo "Enable the Proposed Repository but keep it disabled"
echo "Refer https://wiki.ubuntu.com/Testing/EnableProposed for more info!"
echo "deb http://archive.ubuntu.com/ubuntu/ focal-proposed restricted main multiverse universe" | sudo tee /etc/apt/sources.list.d/focal-proposed.list
echo "Package: *" | sudo tee /etc/apt/preferences.d/proposed-updates
echo "Pin: release a=focal-proposed" | sudo tee -a /etc/apt/preferences.d/proposed-updates
echo "Pin-Priority: 400" | sudo tee -a /etc/apt/preferences.d/proposed-updates
echo "Done! Run sudo apt install packagename/focal-proposed to install a proposed version!"
sudo apt update -y

echo "Install New Software"
sudo apt install \
  aptitude \
  vim \
  mosh \
  screen \
  byobu \
  sshfs \
  exfat-fuse \
  exfat-utils \
  zsh \
  lzip \
  p7zip \
  p7zip-full \
  p7zip-rar \
  unrar \
  whois \
  parallel \
  iperf3 \
  nmap \
  iotop \
  atop \
  nethogs \
  git-all \
  docker.io \
  docker-compose \
  kubectl \
  wireguard \
  nodejs \
  yarn \
  php \
  python3 \
  python3-pip \
  python3-venv \
  ffmpeg \
  qrencode \
  zbar-tools \
  imagemagick \
  certbot \
  python-certbot-nginx \
  build-essential \
  automake \
  libtool \
  pkg-config \
  cmake \
  devscripts \
  equivs \
  gdebi-core \
  software-properties-common \
  nginx \
  openssh-server \
  fail2ban \
  udisks2 \
  qemu \
  qemu-user-static \
  binfmt-support \
  -y

echo "Final apt autoremove"
sudo apt autoremove -y

echo "Finished Ubuntu Server 20.04 Setup!"
