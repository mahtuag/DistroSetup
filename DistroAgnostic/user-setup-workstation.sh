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

echo "Installing pipx"
python3 -m pip install --user pipx
echo "Run pipx install blah instead of pip install blah for sandboxed packages!"

echo "Installing Platform.IO"
pipx install platformio
pio settings set projects_dir $WORKSPACE_DIR

