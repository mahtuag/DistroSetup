# Fedora Xfce Spin Setup

This file is going to document steps involved in setting up a fresh install of
Fedora GNU/Linux, Xfce Spin whose version currently is 22.

I shall seek to keep this document updated as and when I upgrade my own machine.

Oh and the install list involves actions for setting things up the way I need
them - YMMV.

I plan to migrate some of these steps into DevOps automation tools like Ansible
and Salt.

## Pre-install Partition Setup

* Enable full disk encryption (hoping your CPU supports
  [AES-NI](https://en.wikipedia.org/wiki/AES_instruction_set) instructions)
* [EXT4](https://en.wikipedia.org/wiki/Ext4) everywhere (TODO: Evaluate
  [Btrfs](https://en.wikipedia.org/wiki/Btrfs) sometime)
* 1.5GB /boot would be sda1 (enough room for all the messing around with
  experimental kernels you'll ever need - I managed just fine with a 0.5GB /boot
  in my earlier setup so this is plenty!)
* Rest is sda2 managed by
  [LVM](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux))
* 50GB / to be sure that experimenting with apps wouldn't screw up badly
* sizeof(RAM) + 1GB Swap (for hibernate + buffer when RAM is full)
* Remaining space as /home

## Xfce Setup

* Get rid of bottom panel: real-estate management Pt. 1
* Replace application menu with Whisker Menu: Poorman's Plasma Menu!
* Enable 2-rows in workspace switcher: real-estate management Pt. 2
* Enable autostart for Parcellite: Poor man's Klipper!


## Initial Tasks

* Enable RPM Fusion
* Import RPM Fusion GPG Keys
* Import Google Repository GPG Keys
* Download dotfiles from https://github.com/mahtuag/dotfiles
* Run ```dnf update``` once and reboot into a fresh kernel

## Software to Install

* levien-inconsolata-fonts
* zsh
* leafpad
* vim
* atom (download from https://atom.io)
  * atom-beautify
  * atom-jinja2
  * atom-ternjs
  * atom-typescript
  * autocomplete-plus-python-jedi
  * autocomplete-sass
  * autocomplete-polymer
  * color-picker
  * go-plus
  * language-puppet
  * language-terraform
  * linter
  * linter-coffeelint
  * linter-csslint
  * linter-js-yaml
  * linter-jshint
  * linter-pylint
  * linter-shellcheck
  * linter-tslint
  * linter-xmllint
  * minimap
  * preview
  * react
* libreoffice
* ShellCheck
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
* ruby
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
* parcellite

### Uninstall List

* Default email app
* Midori
* AbiWord
* GNUMetric
* Clipman
