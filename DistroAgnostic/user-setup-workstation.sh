#!/bin/sh

echo "Add user to various groups"
sudo gpasswd -a $USER vboxusers
sudo gpasswd -a $USER audio
sudo gpasswd -a $USER realtime
sudo gpasswd -a $USER docker
sudo gpasswd -a $USER uucp
sudo gpasswd -a $USER adbusers

balooctl stop
balooctl disable

