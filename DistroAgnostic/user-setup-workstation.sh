#!/bin/sh

echo "Add user to docker, audio, and realtime groups"
sudo gpasswd -a $USER vboxusers
sudo gpasswd -a $USER audio
sudo gpasswd -a $USER realtime
sudo gpasswd -a $USER docker
sudo gpasswd -a $USER uucp

balooctl stop
balooctl disable

echo "Installing pipx"
python3 -m pip install --user pipx
echo "Run pipx install blah instead of pip install blah for sandboxed packages!"

echo "Installing Platform.IO"
pipx install platformio

