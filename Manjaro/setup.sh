#!/bin/sh

# Thanks to this awesome trick for this script:
# https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Install_packages_from_a_list

echo "We'd like to install the following list of server packages:"
sort server.list | tee server.tmplist
echo "We'd like to install the following list of workstation packages:"
sort workstation.list | tee workstation.tmplist
echo "We'd like to install the following extra packages that you added to extras.list:"
sort extras.list | tee extras.tmplist
echo "We'd like to install these packages overall:"
cat server.list workstation.list extras.list | sort | uniq | tee merged.tmplist
pacman -Slq | sort > pacman-packages.tmplist
pacman -Sg | sort > pacman-groups.tmplist
cat pacman-packages.tmplist pacman-groups.tmplist | sort > pacman-available.tmplist
echo "The following packages will be installed (after excluding unavaiable ones):"
comm -12 pacman-available.tmplist merged.tmplist | tee final-install.tmplist
echo "These packages were skipped because no installation candidates were available for `uname -m` architecture"
comm -23 merged.tmplist final-install.tmplist | tee skipped.tmplist
echo "Running pacman -Syu and installing packages now..."
sudo pacman -Syu --needed - < final-install.tmplist
echo "Cleaning up temporary files..."
rm *.tmplist

