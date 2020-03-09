#!/bin/sh

echo "Welcome to the Liquorix Kernel Setup Helper for Ubuntu"
echo "This script can install or remove Liquorix."
echo "In the prompt below, type 'install' or 'remove' (without the quotes)"
echo "If you type neither, this script will terminate."
read -p "Action to perform: " OPERATION

if [ "$OPERATION" = "install" ]
then
  echo "Begin Liquorix Install"
  echo "Adding Liquorix PPA"
  add-apt-repository ppa:damentz/liquorix
  echo "Running apt update"
  apt update
  echo "Installing linux-image-liquorix-amd64 and linux-headers-liquorix-amd64"
  apt install linux-image-liquorix-amd64 linux-headers-liquorix-amd64
  echo "Finished Liquorix Install!"
elif [ "$OPERATION" = "remove" ]
then
  echo "Begin Liquorix Removal"
  echo "Running ppa-purge"
  ppa-purge ppa:damentz/liquorix
  echo "Finished Liquorix Removal!"
else
  echo "Aborting with no actions"
fi

