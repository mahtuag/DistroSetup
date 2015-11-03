#!/usr/bin/env bash

echo "Provisioning dev machine. This script must be run as root!"

echo "Running empty yum update first"
yum update -y

echo "Enabling the EPEL Repository"
# First the install steo
yum install -y epel-release
# Second, sync with above changes
yum update -y

echo "Installing vim, wget, curl, gcc-c++, make, git, cvs, subversion and mercurial"
yum install -y vim wget curl gcc-c++ make git cvs subversion mercurial

echo "Installing package group 'Development Tools'"
yum groups mark convert "Development Tools"
yum groupinstall "Development Tools"

echo "Installing PostgreSQL 9.4 from official external repository"
# HTTPS; better than liks at http://yum.postgresql.org/repopackages.php
wget https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm
yum install -y pgdg-centos94-9.4-2.noarch.rpm
# Update to sync above changes
yum update -y
# And now the install
yum install -y postgresql94-server postgresql94-contrib
# Manually initialize the database
/usr/pgsql-9.4/bin/postgresql94-setup initdb
# Now enable and start it
systemctl enable postgresql-9.4
systemctl start postgresql-9.4

echo "Installing Node.js 5.x from NodeSource's RPM Distribution"
# TODO replace. Hate these curl script things. Bloody annoying.
curl -sL https://rpm.nodesource.com/setup_5.x | bash -
# Sync above changes
yum update -y
yum install -y nodejs

echo "Installing Nginx mainline from the official external repositorie"
# First, Add the GPG key used to sign the packages
rpm --import http://nginx.org/keys/nginx_signing.key
# Now create and populate nginx.repo file
NGINX_REPO=/etc/yum.repos.d/nginx.repo
echo "[nginx]" >> $NGINX_REPO
echo "name=nginx repo" >> $NGINX_REPO
echo "baseurl=http://nginx.org/packages/mainline/rhel/7/x86_64" >> $NGINX_REPO
echo "gpgcheck=1" >> $NGINX_REPO
echo "enabled=1" >> $NGINX_REPO
# Next sync repositories
yum update -y
# Last, install nginx
yum install -y nginx

echo "A final yum update"
yum update -y

echo "Done provisioning dev machine. You're good to go!"
