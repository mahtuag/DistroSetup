#!/bin/sh

echo "Fix the stupid defaults on logind.conf"
sudo cp ./logind.conf /etc/systemd/logind.conf
sudo systemctl restart systemd-logind
