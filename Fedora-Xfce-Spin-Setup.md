# Fedora Xfce Spin Setup

I'm documenting the way I setup my desktop/laptop environment here, based off
Fedora 22 Xfce Spin.

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

## Software to Install from Offical Repositories

### Web Browsers

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
* google-chrome (Download from Google)
  * Tamper Chrome
  * Postman
  * Webpage Screenshot

### Shell Tools

* zsh
  * my default shell
* levien-inconsolata-fonts
  * default programmer's font
* vim
  * CLI editor
* ShellCheck
  * utility to check shell scripts
  * used by Atom Editor Plugin
* screen
  * since I don't know how to use TMux yet
* parallel
  * basically a better xargs
  * no idea why it is not in every default install
  * you can do stuff like ```find -name "*firefox*" | parallel rm -r```


### Document Editing

* leafpad (minimal GUI text editor - atom takes a long time to start)
* libreoffice (cross platform open standards office suite)

### Programming Environments

* python3
* ruby, rubygems, ruby-devel
  * bundler
  * cucumber
  * sass
* java-1.8.0-openjdk

### Version Control Systems

Need a lot of them installed even though I only use Git, because various other
software like Golang have package authors using their respective preferred VCS

* git (install git-all metapackage)
* mercurial
* bzr
* subversion
* cvs

### Multimedia Tools

* vlc (default)
* smplayer (for a sane alternative)
* ffmpeg (transcoding purposes)

### Utilities

* keepassx (password manager)
* conky (stats for nerds)
* parcellite (clipboard manager; editable history)
* guake (drop down terminal)
* VirtualBox (for development)

### Manual Install List

* Vagrant (download from www.vagrantup.com/downloads)
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
* Golang (download from https://golang.org)
  * Extract to local bin
  * Setup $GOROOT and $GOPATH correctly (and they should be different!)
  * First $GOPATH directory should be external, second $GOPATH directory local
  * Atom plugin go-plus will install some addons on first run
  * Make sure you launch Atom from terminal when developing on Golang

* iojs (download from https://iojs.org)
  * bower
  * coffee-script
  * http-server
  * browserify
  * cson
  * grunt-cli
  * mocha
  * react-tools


### Software to Uninstall

* Default email app
* midori
  * Replaced by Firefox and Chrome
  * Buggy and does not play well with clipboard managers
* abiword (replaced by libreoffice)
* gnumetric (replaced by libreoffice)
* xfce4-clipman-plugin (replaced by parcellite)

### Random Rant about Fedora Repositories

What is the point of packaging language libraries in the repositories ? Perhaps
this would have made sense in the early days of C/C++ packages when the concept
of package management tools (like rubygems, pip, npm, etc) did not exist. But
now we don't force all software to use the same version of every single library.
They are free to depend on whichever version they choose and it is the package
maintainer (of the downstream package) to keep track of changes and security
updates to the upstream package.

The Fedora repositories are cluttered with countless nodejs, python, golang and
ruby packages which I absolutely don't give the slightest damn about. KISS needs
revisiting.
