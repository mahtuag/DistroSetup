#!/bin/sh

echo "Setting up a few things that'd make Pro Audio Nicer"
sudo sysctl -w fs.inotify.max_user_watches=524288
sudo sysctl -w vm.swappiness=1
sudo sysctl -w dev.hpet.max-user-freq=3072
echo -n 3072 | sudo tee /sys/class/rtc/rtc0/max_user_freq
sudo chmod 660 /dev/hpet /dev/rtc0
sudo chgrp audio /dev/hpet /dev/rtc0

