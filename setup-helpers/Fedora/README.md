# Fedora Setup

I'm documenting the way I setup Fedora on my laptops. The base installation is
Fedora 26 Xfce Spin.

I use this for regular "browsing" and multimedia, software developnment and
music production so those are the stuff I'll install. Eventually I shall
separate use-cases into setup scripts but for now, I have a single setup.sh
that does a whole lot of things.

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

## Dotfiles

* Download dotfiles from https://github.com/mahtuag/DistroSetup

## Automated Install and Uninstall

setup.sh enables rpm fusion, docker repos and installs software for development
and music production along with regular desktop-ish stuff.

It doesn't install everything but very few are left to manually install now.

## Manual Download and Install List

* vscode
  * Installer will also enable repositories for auto updates
  * Install golang, protocol buffers plugins
* Continuum Anaconda with Python 3
  * Installed via Continuum's Anaconda Distribution
* Vagrant
  * download from www.vagrantup.com/downloads
* atom
  * ```wget -c https://atom.io/download/rpm --output-document=atom.x86_64.rpm```
  * Setup documented within this repository
* Golang (download from https://golang.org)
  * Extract to local bin
  * Setup $GOROOT and $GOPATH correctly (and they should be different!)
  * First $GOPATH directory should be external, second $GOPATH directory local
  * Atom plugin go-plus will install some addons on first run
  * Make sure you launch Atom from terminal when developing on Golang
* nodejs (download from https://nodejs.org)

