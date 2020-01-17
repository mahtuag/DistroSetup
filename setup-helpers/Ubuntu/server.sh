#!/bin/sh

printf "Begin Ubuntu 18.04 x86_64 Server Setup\n"

printf "\n\nInitial run of apt update --refresh\n"
apt update -y

printf "\n\nInitial run of apt dist-upgrade --refresh\n"
apt dist-upgrade -y

printf "\n\nInstall software needed for installer\n"
apt install curl vim apt-transport-https ppa-purge -y

printf "\n\nAdd Docker's GPG Key\n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

printf "\n\nEnable Docker Repo w/ Edge Release\n"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   edge"

printf "\n\nEnable Kubernetes Repo\n"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
touch /etc/apt/sources.list.d/kubernetes.list
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

if hash docker-compose 2>/dev/null; then
  printf"\n\ndocker-compose already installed so not installing it.\n"
else
  printf "\n\nInstall docker-compose\n"
  curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

if hash minikube 2>/dev/null; then
  printf"\n\nminikube already installed so not installing it.\n"
else
  printf "\n\nInstall minikube\n"
  curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -o /usr/local/bin/minikube
  chmod +x /usr/local/bin/minikube
fi

if hash kompose 2>/dev/null; then
  printf"\n\nkompose already installed so not installing it.\n"
else
  printf "\n\nInstall kompose\n"
  curl -L https://github.com/kubernetes/kompose/releases/download/v1.18.0/kompose-linux-amd64 -o /usr/local/bin/kompose
  chmod +x /usr/local/bin/kompose
fi

printf "\n\nEnable the Universe Repository\n"
add-apt-repository universe -y

printf "\n\nEnable Node.js Repo\n"
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
printf "deb https://deb.nodesource.com/node_13.x bionic main\ndeb-src https://deb.nodesource.com/node_13.x bionic main\n" | tee /etc/apt/sources.list.d/node.list

printf "\n\nEnable Yarn Repo\n"
curl -s https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

printf "\n\nEnable Tesseract PPA Repository\n"
add-apt-repository ppa:alex-p/tesseract-ocr -y

printf "\n\nEnable WireGuard PPA Repository\n"
add-apt-repository ppa:wireguard/wireguard -y

printf "\n\nEnable PostgreSQL Global Development Group Repo"
curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

printf "Enable Certbot PPA Repository for Let's Encrypt"
add-apt-repository ppa:certbot/certbot -y

printf "\n\nRefresh newly added repos via apt update\n"
apt update

printf "\n\nInstall New Software\n"
apt install \
  aptitude \
  mosh \
  sshfs \
  exfat-fuse \
  exfat-utils \
  zsh \
  lzip \
  p7zip \
  p7zip-full \
  p7zip-rar \
  screen \
  byobu \
  parallel \
  iperf3 \
  nmap \
  iotop \
  atop \
  nethogs \
  git-all \
  docker-ce \
  kubectl \
  wireguard \
  nodejs \
  yarn \
  php \
  ffmpeg \
  imagemagick \
  tesseract-ocr-all \
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
  -y

printf "\n\nEnable Docker Service\n"
systemctl enable docker

printf "Replacing Apache2 with NGINX and copying over sample NGINX configs"
cp ../../nginx/*.conf /etc/nginx/sites-available
systemctl disable apache2
systemctl stop apache2
systemctl restart nginx

printf "\n\nInstall Golang\n"
rm -r /usr/local/go
wget -c https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.13.6.linux-amd64.tar.gz
echo 'export PATH="/usr/local/go/bin:$PATH"' > /etc/profile.d/golangpath.sh

printf "\n\nRemove unneeded software\n"
apt remove --purge \
apache2 \
-y

printf "\n\nFinal Apt Autoremove\n"
apt autoremove -y

printf "\n\nEnable the Proposed Repository but keep it disabled\n"
printf "Refer https://wiki.ubuntu.com/Testing/EnableProposed for more info!\n\n"
echo "deb http://archive.ubuntu.com/ubuntu/ bionic-proposed restricted main multiverse universe" > /etc/apt/sources.list.d/bionic-proposed.list
echo "Package: *" > /etc/apt/preferences.d/proposed-updates
echo "Pin: release a=bionic-proposed" >> /etc/apt/preferences.d/proposed-updates
echo "Pin-Priority: 400" >> /etc/apt/preferences.d/proposed-updates
echo "Done! Run sudo apt install packagename/bionic-proposed to install a proposed version!"
apt update -y

printf "\n\nFinished Ubuntu Server 18.04 x86_64 Setup!\n\n"
