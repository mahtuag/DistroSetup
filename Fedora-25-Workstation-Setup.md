# Fedora 25 Workstation Setup

Documenting all steps followed during setup of Fedora 25 workstation for my Acer
eMachines e725 laptop.


## User Customization

* Add relevant groups to the user $USERNAME
  * TODO get the group names
* Enable keyboard shortcuts for search engines on Firefox
  * (Y)ouTube, (W)ikipedia, (G)oogle, (B)ing
* Install Firefox Plugins
  * DownThemAll
  * ChatZilla

## Software Installation

* Install from media
* Enable touch to click on touchpad
* First system update `sudo dnf update`
* Enable RPM Fusion
   * https://rpmfusion.org/Configuration/
   * `su -c 'dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'`
* Download and install Google Chrome
* Install relevant Chrome plugins
