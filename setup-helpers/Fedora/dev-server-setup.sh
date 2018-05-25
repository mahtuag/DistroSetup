#!/bin/sh

printf "Begin Fedora 28 Server x86_64 Setup\n"

printf "\n\nInitial run of dnf update --refresh\n"
dnf update --refresh -y

printf "\n\nEnable Docker Repo w/ Edge Release\n"
dnf config-manager \
  --add-repo \
  https://download.docker.com/linux/fedora/docker-ce.repo
dnf config-manager --set-enabled docker-ce-edge

printf "\n\nInstall docker-compose\n"
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

printf "\n\nEnable Node.js Repo\n"
curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -

printf "\n\nEnable Yarn Repo\n"
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo

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
  nodejs \
  yarn \
  -y

printf "\n\nInstall Group: Development Tools (with optional packages)\n"
dnf group install --with-optional "Development Tools" -y

printf "\n\nInstall Group: C Development Tools And Libraries\n"
dnf group install "C Development Tools and Libraries" -y

printf "\n\nRemove Unnecessary Installs from Group\n"
dnf remove gambas* -y

printf "\n\nFinished setup of Fedora 28 Server x86_64!\n\n"
