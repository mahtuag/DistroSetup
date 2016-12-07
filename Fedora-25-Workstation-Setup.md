# Fedora 25 Workstation Setup

Documenting all steps followed during setup of Fedora 25 workstation for my Acer
eMachines e725 laptop.

1. Install from media
2. Add relevant groups to the user $USERNAME
   * TODO get the group names
3. Enable touch to click on touchpad
4. First system update `sudo dnf update`
5. Enable RPM Fusion
   * https://rpmfusion.org/Configuration/
   * `su -c 'dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'`
6. 
