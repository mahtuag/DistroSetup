#!/bin/sh
echo "Installing Python 3.8 into Ubuntu 18.04"
sudo apt install -y python3.8 python3.8-venv
python3.8 -m pip install --user pipx
pipx install youtube-dl
pipx install mypy
