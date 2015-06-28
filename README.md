# DistroSetup

A quick TODO list to setup a fresh GNU/Linux install to my liking.

As of now, my preferred GNU/Linux distribution is Fedora 22 Xfce Spin and the
instructions here are written with that in mind.

I'm going to have to reinstall this atleast 3-4 times in the next few months so
having things on the internet to refer quickly helps!

## Pre-install

* Enable full disk encryption (hoping your CPU supports AES-NI instructions)
* EXT4 everywhere (TODO: Evaluate BtrFS sometime)
* 1.5GB /boot
* Rest is LVM
  * 50GB /
  * sizeof(RAM) + 1GB Swap (for hibernate + buffer when RAM is full)
  * Rest as /home

## Initial Tasks

* Enable RPM Fusion
* Import RPM Fusion GPG Keys
* Import Google Repository GPG Keys
* Download dotfiles from https://github.com/mahtuag/dotfiles
* Run ```dnf update``` once and reboot into a fresh kernel

## Software to Install

* zsh
* leafpad
* vim
* atom (download from https://atom.io)
* libreoffice
* firefox
  * Abduction!
  * Adblock Edge
  * Classic Theme Restorer
  * Firebug
  * CodeBurner for Firebug
  * Firefinder for Firebug
  * User Agent Overrider
  * Greasemonkey
  * Tamper Data
  * User Agent Overrider
  * Video DownloadHelper
  * FlashGot
  * Disconnect
  * Flashblock
  * HTTPS-Everywhere
  * Remove It Permanently
  * RightToClick
  * DownThemAll!
  * Disable Ctrl-Q Shortcut
* google-chrome
  * Tamper Chrome
  * Postman
  * Webpage Screenshot
* golang
* python3
* java-1.8.0-openjdk
* nodejs, npm
  * bower
  * coffee-script
  * http-server
  * browserify
* conky
* screen
* git
* vlc
* ffmpeg
* smplayer
* keepassx

## Xfce Setup

* Get rid of bottom panel: real-estate management Pt. 1
* Replace application menu with Whisker Menu: Poorman's Plasma Menu!
* Enable 2-rows in workspace switcher: real-estate management Pt. 2
* Enable autostart for Clipman: Poor man's Klipper!

