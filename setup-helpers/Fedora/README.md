# Fedora Setup

I'm documenting the way I setup Fedora on my laptops.

The base installation is Fedora 26 Xfce Spin, with added tools for software
development, audio production, multimedia creation, general productivity and
a better commandline experience.

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

## DNF Setup

Add `fastestmirror=1` to `/etc/dnf/dnf.conf` to ensure that you use the
fastest available mirrors when performing updates.

## Dotfiles

* Download dotfiles from https://github.com/mahtuag/DistroSetup

## Automated Install and Uninstall

setup.sh does some automated installing (and uninstalling) of packages I want
(or don't want).

It doesn't cover everything but very few manual steps are needed next.

Until I'm confident that things work, I wouldn't add the `-y` switch to dnf
commands to run them without intervention, so do keep an eye on your screen
while the commands run to occasionally inspect things. You may want to run the
steps manually by copy pasting from the script.

### Docker Issue

Right now Docker 17.06 isn't available for Fedora 26. But Docker 17.07 is in
the testing repository. I'll remove this section when the stable version of
docker-ce-17.07 is pushed into the Fedora 26 repositories but until then, enable
the docker-ce-testing repository before you install Docker.

```bash
sudo dnf config-manager --set-enabled docker-ce-test
```

## Manual Download and Install List

* vscode
  * Download here: https://code.visualstudio.com/download
  * Installer will also enable repositories for auto updates
  * Install golang, protocol buffers plugins
* Continuum Anaconda with Python 3
  * Download here: https://www.continuum.io/downloads#linux
* Vagrant
  * download here: www.vagrantup.com/downloads
* atom
  * `wget -c https://atom.io/download/rpm --output-document=atom.x86_64.rpm`
  * Setup documented within this repository
* Golang
  * Download here: https://golang.org/dl/
  * Extract to local bin
  * Setup $GOROOT and $GOPATH correctly (and they should be different!)
  * First $GOPATH directory should be external, second $GOPATH directory local
  * Atom plugin go-plus will install some addons on first run
  * Make sure you launch Atom from terminal when developing on Golang
* Node.js
  * Download here: https://nodejs.org/

## Setting up Fedora for Audio Production

**Note: Work In Progress** *This section may eventually be moved to its own
dedicated page if it grows large and comprehensive enough*

Install all of Fedora Jam's audio production software packages conveniently
placed in a single group.

```bash
sudo dnf group install "Audio Production"
```

Add your user to the `jackuser` and `audio` groups

```bash
sudo usermod -aG jackuser yourname
sudo usermod -aG audio yourname
```

I used https://wiki.linuxaudio.org/wiki/system_configuration to help me tune my
setup. A useful tool it recommends (which is a part of the `Audio Production`
software group) is `realTimeConfigQuickScan` which checks for system-level
configuration changes you may need to make.

## CPU Frequency Scaling

To ensure that your CPU is at the highest performance setting and isn't being
throttled to save power (useful during audio work for example), run this:

```bash
sudo cpupower frequency-set --governor performance
```

Alternatively, you may use a powersaver mode when all you are doing is surfing
the internet on battery power.

```bash
sudo cpupower frequency-set --governor powersave
```

## Recommended Fonts

* monospace: Inconsolata
* Serif: *todo*
* Sans: *todo*
