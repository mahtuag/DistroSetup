#!/bin/sh

printf "Begin Ubuntu 18.04 x86_64 Setup as a Cloud Server\n"
printf "\n\nThis sets up the machine for use as a server\n"
printf "Ensure you have run base.sh!\n"

printf "Replacing Apache2 with Nginx"
cp ../../nginx/*.conf /etc/nginx/sites-available
systemctl disable apache2
systemctl stop apache2
systemctl restart nginx

printf "Enable and install Certbot for Let's Encrypt"
add-apt-repository universe -y
add-apt-repository ppa:certbot/certbot -y
apt update
apt install certbot python-certbot-nginx -y

printf "\n\nFinished Server Setup!"
