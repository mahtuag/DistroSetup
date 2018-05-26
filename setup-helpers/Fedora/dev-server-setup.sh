#!/bin/sh

printf "Begin Fedora 28 Server x86_64 Setup\n"
printf "\n\nThis sets up the machine for use as a headless development server\n"

printf "\n\nAdd fastestmirror=1 to /etc/dnf/dnf.conf\n"
echo "fastestmirror=1" >> /etc/dnf/dnf.conf

printf "\n\nInitial run of dnf update --refresh\n"
dnf update --refresh -y

printf "\n\nEnable RPM Fusion\n"
dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
  -y

printf "\n\nEnable Docker Repo w/ Edge Release\n"
dnf config-manager \
  --add-repo \
  https://download.docker.com/linux/fedora/docker-ce.repo
dnf config-manager --set-enabled docker-ce-edge

printf "\n\nEnable Kubernetes Repo\n"
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

printf "\n\nInstall docker-compose\n"
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

printf "\n\nInstall minikube\n"
curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -o /usr/local/bin/minikube
chmod +x /usr/local/bin/minikube

printf "\n\nEnable Node.js Repo\n"
curl --silent --location https://rpm.nodesource.com/setup_10.x | bash -

printf "\n\nEnable Yarn Repo\n"
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo

printf "\n\nRefresh newly added repos via dnf update --refresh\n"
dnf update --refresh -y

printf "\n\nRemove Unneeded Software\n"
dnf remove \
  docker \
  docker-common \
  docker-selinux \
  docker-engine-selinux \
  docker-engine \
  -y

printf "\n\nInstall New Software\n"
dnf install \
  vim \
  zsh \
  byobu \
  parallel \
  iperf3 \
  nmap \
  iotop \
  htop \
  atop \
  nethogs \
  git-all \
  docker-ce \
  kubectl \
  nodejs \
  yarn \
  php \
  ffmpeg \
  ImageMagick \
  -y

printf "\n\nEnable Docker Service\n"
systemctl enable docker

printf "\n\nInstall Group: Development Tools (with optional packages)\n"
dnf group install --with-optional "Development Tools" -y

printf "\n\nInstall Group: C Development Tools And Libraries\n"
dnf group install "C Development Tools and Libraries" -y

printf "\n\nRemove Unnecessary Installs from Group\n"
dnf remove gambas* -y

printf "\n\nRun dnf autoremove once\n"
dnf autoremove -y

printf "\n\nInstall Golang\n"
rm -r /usr/local/go
wget -c https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.10.2.linux-amd64.tar.gz

if ! grep -qe "/usr/local/go/bin" "/etc/zshenv"; then
  echo 'PATH="/usr/local/go/bin:$PATH"' >> /etc/zshenv    
fi

printf "\n\nChange Root's Default Shell to ZSH\n"
chsh -s /usr/bin/zsh

printf "\n\nDownload ~/.irbirc\n"
curl -L https://raw.githubusercontent.com/mahtuag/DistroSetup/master/dotfiles/irbrc -o ~/.irbrc
printf "\n\nDownload ~/.zshrc\n"
curl -L https://raw.githubusercontent.com/mahtuag/DistroSetup/master/dotfiles/zshrc -o ~/.zshrc
printf "\n\nDownload ~/.vimrc\n"
curl -L https://raw.githubusercontent.com/mahtuag/DistroSetup/master/dotfiles/vimrc -o ~/.vimrc

printf "\n\nFinished setup of Fedora 28 Server x86_64!\n\n"
