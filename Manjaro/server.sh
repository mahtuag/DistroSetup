#!/bin/sh
echo "The following server packages will be installed:"
cat server.list
cat server.list | sudo pacman -Syu --needed -

