#!/usr/bin/env bash

echo "Provisioning dev machine. Should be run as root!"

echo "Updating distro"
apt-get update -y
apt-get upgrade -y
apt-get dist-upgrade -y
echo "Done updating distro"

echo "Installing some essentials"
apt-get install -y build-essential readline libreadline-dev vim git mercurial svn cmake curl wget elinks
echo "Done installing some essentials"

echo "Installing PostgreSQL 9.4 from official repos"
apt-get install -y postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4 libpq-dev
echo "Done installing PostgreSQL 9.4"

echo "Setting up and installing NGINX mainline"
wget http://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key
echo "deb http://nginx.org/packages/mainline/ubuntu/ wily nginx" >> /etc/apt/sources.list
echo "deb-src http://nginx.org/packages/mainline/ubuntu/ wily nginx" >> /etc/apt/sources.list
apt-get update -y
apt-get install -y nginx
echo "Done setting up and installing NGINX"

echo "Setting up and installing Node.js 5.x"
curl -sL https://deb.nodesource.com/setup_5.x | bash -
apt-get install -y nodejs
echo "Done setting up and installing Node.js 5.x"

echo "Done provisioning dev machine!"

exit
