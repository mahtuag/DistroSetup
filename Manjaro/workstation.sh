#!/bin/sh
echo "The following server packages will be installed:"
cat server.list
echo "The following workstation packages will be installed:"
cat workstation.list
cat workstation.list server.list | sudo pacman -Syu --needed -

