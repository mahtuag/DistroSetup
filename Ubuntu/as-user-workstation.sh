#!/usr/bin/zsh

printf "Running commands as user $USER"

sudo usermod -aG jackuser $USER
sudo usermod -aG audio $USER