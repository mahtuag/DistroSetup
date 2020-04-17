#!/usr/bin/zsh

printf "Running commands as user $USER"

printf "\n\nInstall Anaconda\n"
rm -r $HOME/ext/bin/anaconda
wget -c https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
bash Anaconda3-2019.10-Linux-x86_64.sh -b -p $HOME/ext/bin/anaconda

