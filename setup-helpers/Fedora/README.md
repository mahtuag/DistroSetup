# Fedora Setup

This page documents the way I setup Fedora on my laptops, while the scripts in
this folder provide some level of automation so that you may perform the setup
in an unattended manner.

The base installation is Fedora 29 Xfce Spin, with added tools for software
development, audio production, multimedia creation, general productivity and
a better commandline experience, all done for my personal needs.

I've ALSO included setup steps for Fedora 29 Jam Spin (based on KDE desktop)
because for some reason the Xfce Spin failed to compose for the 29th release
and I decided to revisit KDE.

If you have come here, you are either a future version of me looking to setup a
laptop quickly or an employee/intern/friend who'd like to setup their laptop
identically to mine for whatever reason.

## Pre-install Partition Setup

* Enable full disk encryption (hoping your CPU supports
  [AES-NI](https://en.wikipedia.org/wiki/AES_instruction_set) instructions)
* [EXT4](https://en.wikipedia.org/wiki/Ext4) everywhere (TODO: Evaluate
  [Btrfs](https://en.wikipedia.org/wiki/Btrfs) sometime)
* `1.5GB` for `/boot` would be sda1 (enough room for all the messing around with
  experimental kernels you'll ever need - I managed just fine with a 0.5GB in an
  earlier setup so this is plenty!)
* Rest is sda2 managed by
  [LVM](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux))
* `50GB` for `/` to be sure that experimenting with apps wouldn't screw up badly
* `sizeof(RAM) + 1GB` for `swap` (for hibernate + buffer when RAM is full)
* Remaining space as `/home`

## During Installation

While you install Fedora 28 on your new machine, use your browser to copy these
scripts into someplace you'll easily find, like /postinstall. That way you can
escape from having to first install git to run these scripts.

## Automated Setup Scripts

Following is the order in which scripts here should be executed:

1. Run `sudo ./dev-server-setup.sh` to automate setup of a headless development
   server
2. Run `./as-user.sh` to run setup commands that need to be run as a regular
   user.
3. Run `sudo ./workstation-setup.sh` to automate setup of a graphical desktop
   workstation.
   * **for KDE users** run `sudo ./workstation-setup-jam.sh` instead

You may follow just steps 1 and 2 if this is a virtual machine running `Fedora
28 Server Edition`. Otherwise follow all steps.

Please read all the scripts. I've made attempts to add enough `printf`
statements explaining what's going on and all the commands are pretty easy to
understand.

### Scripted Actions

#### dev-server-setup.sh

* Add `fastestmirror=1` to `/etc/dnf/dnf.conf`
* System Update
* Enable RPM Fusion and install `ffmpeg` and `ImageMagick` from it
* Enable Docker Repository w/ Edge Release and install `docker`
* autostart docker service
* Enable Kubernetes Repo and install `kubectl`
* Install `docker-compose`
* Install `minikube`
* Enable Node.js Repo and install `nodejs`
* Enable Yarn Repo and install `yarn`
* Install Golang and add it to `$PATH` for all `zsh` users
* Change root user and current user's default shell to `zsh`
* Import my dotfiles (within this repo) for root user
* Install `php` from Fedora's own repositories
* Install commandline tools like `vim`, `parallel`, `ipref3`, `nmap`, `htop`,
  `iotop`, `atop`, `nethogs`, etc.
* Install `git-all` package.
* Install `Development Tools` and `C Development Tools and Libraries` software
  groups but remove gambas which is a part of Development Tools and unneeded.

#### workstation-setup.sh

* Enable VSCode Repository and Install `code`
* Install Slack `rpm` after downloading it (this enables the slack repos too)
* Remove pre-installed software I don't like and replace with stuff I like (just
  read the script to know what modifications I make).
* Enable mounting a phone via `mtp` protocol.
* Install the `Audio Production` software group
* Install the roboto fonts because the human eye needs pampering.

#### workstation-setup-xfce4.sh

* Install guake terminal
* Install parcellite for clipboard management
* Install `redshift-gtk` for personal health

#### workstation-setup-jam.sh

* Install yakuake terminal

#### as-user.sh

* Add `$USER` to `docker`, `jackuser` and `audio` groups.
* Create some essential directories for the current user
* Change default shell to zsh
* Import dotfiles (within this repo) for `$USER`
* Download and install Anaconda for a Python 3.6 setup

## Xfce Setup

* Get rid of bottom panel: real-estate management Pt. 1
* Replace application menu with Whisker Menu: Poorman's Plasma Menu!
* Enable 2-rows in workspace switcher: real-estate management Pt. 2
* Enable autostart for Parcellite: Poor man's Klipper!

TODO: I'll figure out a way to automate this.

## KDE Setup

### Plasma Bar: Network Monitor

Add the network monitor widget to the top bar. VERY useful.

### Workspace Swicher

* In system settings search for desktop to go to the virtual desktop section
* Change number of workspaces to 4 and the number of rows to 2
* Update `switch one desktop to <left/right/up/down>` to use `ctrl+alt+arrow`
  combinations.

### Klipper Setup

* Right click on clipboard icon and select configure clipboard
* Set open clipper at mouse pointer location in the shortcuts section to
  `ctrl+alt+h`
* Set history size to something bigger, like 100 entries

### Disable Baloo

Baloo is today's Nepomuk. I don't need my files indexed because they're
extremely well organized and there's always `find . | grep -i filename` when I
need to look for something.

If you type baloo in system settings it should go to the file search section
where you can disable it. Just uncheck `Enable File Search`.

### Yakuake Setup

* Use F8 to start it
* Change shortcuts for next session and previous session to `ctrl+pg-dn` and
  `ctrl+pg-up` respectively so it feels like a browser
* Add yakuake to autostart in system settings (type autostart in search and
  you'd find the menu option)

## Setting up Fedora for Audio Production (w/o Fedora Jam)

If you chose to install Fedora Jam directly, you don't need this section.

**Note: Work In Progress** *This section may eventually be moved to its own
dedicated page if it grows large and comprehensive enough*

Install all of Fedora Jam's audio production software packages conveniently
placed in a single group.

```bash
sudo dnf group install "Audio Production"
```

Add your user to the `jackuser` and `audio` groups

```bash
sudo usermod -aG jackuser $USER
sudo usermod -aG audio $USER
```

Both the above steps have been automated in the included scripts.

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

### Low Resolution Screens

Example: 1366x768 pixel resolution on a 15.6" display.

* Monospace: Inconsolata
* Serif: DeJaVu Serif
* Sans-Serif: DeJaVu Sans

## High Resolution Screens

Example: 1920x1080 pixel resolution on a 13.3" display, or an Android device.

* monospace: Roboto Mono Regular
* Serif: Roboto Slab
* Sans: Roboto

Note: Google's roboto fonts seem to work particularly well on high resolution
displays because they don't contain some unnecessary details, like the stroke
through the S in the dollar symbol $ which makes them easier to read.

