# DistroSetup

A quick TODO list to setup a fresh GNU/Linux install to my liking.

As of now, my preferred GNU/Linux distribution is Fedora 22 Xfce Spin and the
instructions here are written with that in mind.

I'm going to have to reinstall this atleast 3-4 times in the next few months so
having things on the internet to refer quickly helps!

Oh and right now a whole bunch of sections are in a single file. Once this gets
hard to manage I shall refactor into multiple files

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

### Uninstall List

* Default email app
* Midori (you can keep it as an webmail client if you want)
* AbiWord (We installed LibreOffice)
* GNUMetric (same as above)

## Xfce Setup

* Get rid of bottom panel: real-estate management Pt. 1
* Replace application menu with Whisker Menu: Poorman's Plasma Menu!
* Enable 2-rows in workspace switcher: real-estate management Pt. 2
* Enable autostart for Clipman: Poor man's Klipper!

## Heroku CLI Setup

I'm not too fond of installing stuff on root when it isn't managed by the
offical package management solution.

Heroku CLI by default expects to be installed as root so this is how you avoid
that:

* Check out the install  shell script https://toolbelt.heroku.com/install.sh
* It points to
  https://s3.amazonaws.com/assets.heroku.com/heroku-client/heroku-client.tgz
  which is the archive where the Heroku CLI is actually held.
* Download the above archive and extract to an appropriate directory
* Add ```$BASE_DIR_OF_EXTRACTION/heroku-client/bin``` to your $PATH
* Run ```heroku login```
* Ba dum tss!
