# Fedora Setup

I'm documenting the way I setup Fedora on my laptops. The base installation is
Fedora 26 Xfce Spin.

TODO: Update me

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
* Download dotfiles from https://github.com/mahtuag/DistroSetup
* Run ```dnf update --refresh``` once and reboot into a fresh kernel

## Software to Install from Offical Repositories

### Web Browsers

* firefox
  * AutoHiDPI
  * DownThemAll!
  * FlashGot
  * RightToClick
  * Disable Ctrl-Q Shortcut
  * HTTP/2 and SPDY Indicator
  * SQLite Manager
  * Strict Pop-up Blocker
* Chromium (Or maybe Google Chrome)
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
* byobu
  * Frontend for screen and tmux.
  * For a tmux ignorant person (me), this brings screen at par with tmux w.r.t
    features and I like the defaults
* parallel
  * basically a better xargs
  * no idea why it is not in every default install
  * you can do stuff like ```find -name "*firefox*" | parallel rm -r```


### Document Editing

* leafpad (minimal GUI text editor - atom takes a long time to start)
* libreoffice (cross platform open standards office suite)

### Programming Environments

* ruby, rubygems, ruby-devel
  * bundler
  * cucumber
  * sass
* java-1.8.0-openjdk
* ```sudo dnf groupinstall "Development Tools"```

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

* vscode
  * Download installer; will also enable repositories for auto updates
  * Install golang, protocol buffers plugins
* python3
  * Installed via Continuum's Anaconda Distribution
* Vagrant (download from www.vagrantup.com/downloads)
* atom (download from https://atom.io)
  * Setup documented within this repository
* Golang (download from https://golang.org)
  * Extract to local bin
  * Setup $GOROOT and $GOPATH correctly (and they should be different!)
  * First $GOPATH directory should be external, second $GOPATH directory local
  * Atom plugin go-plus will install some addons on first run
  * Make sure you launch Atom from terminal when developing on Golang
* nodejs (download from https://nodejs.org)

### Software to Uninstall

TODO: Revisit this section for Fedora 26

* Default email app
* midori
  * Replaced by Firefox and Chrome
  * Buggy and does not play well with clipboard managers
* abiword (replaced by libreoffice)
* gnumetric (replaced by libreoffice)
* xfce4-clipman-plugin (replaced by parcellite)

