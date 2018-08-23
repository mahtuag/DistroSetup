#!/bin/sh

printf "Begin Ubuntu 18.04 Server x86_64 Setup\n"
printf "\n\nThis sets up the machine for use as a headless development server\n"

printf "\n\nInitial run of apt update --refresh\n"
apt update --refresh -y

printf "\n\nInitial run of apt dist-upgrade --refresh\n"
apt update --refresh -y

printf "\n\nInstall apt-transport-https\n"
apt install apt-transport-https

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
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

if hash docker-compose 2>/dev/null; then
  printf"\n\ndocker-compose already installed so not installing it.\n"
else
  printf "\n\nInstall docker-compose\n"
  curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

if hash minikube 2>/dev/null; then
  printf"\n\nminikube already installed so not installing it.\n"
else
  printf "\n\nInstall minikube\n"
  curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -o /usr/local/bin/minikube
  chmod +x /usr/local/bin/minikube
fi

printf "\n\nEnable Node.js Repo\n"
curl --silent --location https://deb.nodesource.com/setup_10.x | bash -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

printf "\n\nEnable Yarn Repo\n"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo

printf "\n\nRefresh newly added repos via dnf update --refresh\n"
dnf update --refresh -y

printf "\n\nInstall New Software\n"
apt install \
  sshfs \
  zsh \
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
  nodejs \
  yarn \
  php \
  ffmpeg \
  imagemagick \
  build-essential \
  -y

printf "\n\nEnable Docker Service\n"
systemctl enable docker

printf "\n\nInstall Golang\n"
rm -r /usr/local/go
wget -c https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
echo 'export PATH="/usr/local/go/bin:$PATH"' > /etc/profile.d/golangpath.sh

# This needs password; to make this automated, we could temporarily remove the
# need via https://askubuntu.com/questions/812420/chsh-always-asking-a-password-and-get-pam-authentication-failure
# And then put it back. This would need some serious file editing!
# printf "\n\nChange Root's Default Shell to ZSH\n"
# chsh -s /usr/bin/zsh

printf "\n\nDownload ~/.irbirc\n"
curl -L https://raw.githubusercontent.com/mahtuag/DistroSetup/master/dotfiles/irbrc -o ~/.irbrc
printf "\n\nDownload ~/.zshrc\n"
curl -L https://raw.githubusercontent.com/mahtuag/DistroSetup/master/dotfiles/zshrc -o ~/.zshrc
printf "\n\nDownload ~/.vimrc\n"
curl -L https://raw.githubusercontent.com/mahtuag/DistroSetup/master/dotfiles/vimrc -o ~/.vimrc

printf "\n\nFinished setup of Ubuntu 18.04 Server x86_64!\n\n"
