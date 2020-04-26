# Distro Agnostic Setup Tasks

These are scripts to automate various server/workstation setup steps that are
common to all Linux distros.

## Common Post-Install Tasks

### user-setup-common.sh

This script needs to be run as each user who'll use the system; including root.

### user-setup-workstation.sh

This script needs to be run as each user who'd be a primary user of a Linux
workstation. It sets things up for pro audio, docker, virtualbox, raw disk
access, etc.

### install-snaps.sh

This script installs a bunch of common snaps. These are primarily IDEs and
communication apps.

### Disable Suspend on Lid Close

Just run this:

```bash
/logind-fix.sh
```

And now for the explanation!

Auto-suspend is the one feature that absolutely triggers me. A lot of laptops
cannot handle suspend properly, and closing the lid is by NO means an indication
that I'd like to suspend my laptop. I still have no idea why Ubuntu has this as
the default behavior. I've included my `/etc/systemd/logind.conf` that disables
this and replaces it with a lock option. Additionally, power butons don't
automatically cause actions but go to a menu that asks the user what to do.

You'd think these preferences can be set in xfce4 settings but you'd be wrong.
Like I said, this is a REALLY annoying bug.

You can replace your `/etc/systemd/logind.conf` with the `logind.conf` file from
this folder. For more about this file, take a look at the official documentation
[here](https://www.freedesktop.org/software/systemd/man/logind.conf.html).

### UFW Setup

Run `sudo systemctl --now enable ufw.service ` to enable UFW; `gufw` => GUI.

See [here](https://serverfault.com/questions/468907/ufw-blocking-apt) for how to
setup a sane default for UFW.

Digital Ocean also has[a nice tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-16-04)
on UFW basics.

```bash
ufw reset
ufw default deny incoming
ufw default deny outgoing
ufw limit ssh
ufw allow svn
ufw allow git
ufw allow out http
ufw allow in http
ufw allow out https
ufw allow in https
ufw allow out 53
ufw logging on
ufw enable
```

### Show Grub Menu Always

* Run `sudo grub-editenv - unset menu_auto_hide`
* Edit `/etc/default/grub`
  * Set `GRUB_TIMEOUT_STYLE=menu`
  * Set `GRUB_TIMEOUT=10` or whatever seconds you want the menu for
* Run `update-grub`


## Pro Audio

### High Level Steps

1. Add your user to `audio` and `realtime` groups (as appropriate) and reboot.
2. Run `prepare-pro-audio.sh`.
3. Run `realTimeConfigQuickScan` (see section below) and identify what else
   needs to be configured.
4. Start `jack2`; ensure things in `jack-startup.sh` are started (if using
   `qJackCtl`). `Ubuntu Studio Controls` and `Cadence` remove the need for
   doing this.

### realTimeConfigQuickScan

This is a tool to quickly see if your system is ready for Pro Audio. See the
[GitHub repo](https://github.com/raboof/realtimeconfigquickscan) for more
information! Here's how you run it:

```bash
git clone https://github.com/raboof/realtimeconfigquickscan
cd realtimeconfigquickscan
perl ./realTimeConfigQuickScan.pl
```

### Setup Sound Card

For both internal (Intel HDA) and external (Focusrite Scarlett Solo) sound
cards, I prefer a Sample Rate of 48000. This is the same sample rate most
modern systems (like mobile phones and bluetooth headsets) use, and all
sound cards support it. Anything higher would only lead to high CPU usage
and you'd frequently find some LV2 plugins crashing or misbehaving.

The settings I use are:

* Sample Rate 48000
* Frames/Period 256
* Periods/Buffer 3

This gives me a latency of 16 msec.

If I close all running apps (except the DAW), and run a realtime kernel, I can
get the Frames/Period down to 128.

Refer [Linux Audio Wiki](https://wiki.linuxaudio.org/wiki/list_of_jack_frame_period_settings_ideal_for_usb_interface)

### Extra Jack Sinks (for Ardour)

Run

```bash
pactl load-module module-jack-sink client_name=pulse_sink_ardour channels=2 connect=no
```

If you'd like to have an extra Jack Sink, to route apps that run through Ardour

This might be needed for example if you wanted to use Ardour to route YouTube
audio into a Facebook Messenger video call.

### References

* [Ubuntu HowToJACKConfiguration](https://help.ubuntu.com/community/HowToJACKConfiguration)
  * Describes how to setup JackAudio with Ubuntu
* [realTimeConfigQuickScan](https://github.com/raboof/realtimeconfigquickscan)
  * Tool to quickly check whether your system is real-time ready
* [Check if HyperThreading is Enabled](https://unix.stackexchange.com/a/121989/149056)
  * You should disable it if it is!
  * This might be part of realTimeConfigQuickScan hopefully and then I'll remove
    it from the references section.
    * Refer to this [GitHub issue](https://github.com/raboof/realtimeconfigquickscan/issues/27)
* [Liquorix](https://liquorix.net/)
  * A Linux Kernel which is tuned for realtime audio, available for Debian and
    I haven't yet had to use this, because the UbuntuStudio `lowlatency` kernel
    has been more than enough for my needs!

## Burn a Windows ISO into a USB drive from Linux

This is MUCH harder than doing the same thing with a Linux ISO. So do it once
and keep the USB drive safe somewhere so you don't have to do it again! Read
[here](https://forum.manjaro.org/t/howto-use-manjaro-to-create-a-bootable-windows-usb/92780)
for instructions.

Also keep [Hiren's BootCD PE](https://www.hirensbootcd.org) handy!

## Groups Management

Sometimes you might wish to remove a user from a group after you're done doing
tasks that needed the permissions of that group. Here are some of the groups
you'd need:

1. audio
    * Needed for low-latency audio via jack2
2. realtime
   * Allows user some realtime privileges when doing low latency audio work
   * You might want to remove this permission once done with audio work!
3. disk
   * Grants a user "raw" access to the disk (eg: `/dev/sdb`).
   * You might want this when playing with `vmdk` files on VirtualBox
4. wheel
   * Gives a user sudo privileges
5. docker
   * Allows the user to access the docker daemom
6. vboxusers
   * Allows the user to access VirtualBox

Add a user to a group via `sudo gpasswd -a $USER groupname`

Remove a user from a group via `sudo gpasswd -d $USER groupname`

## Installing Distros via VirtualBox in a USB Drive

This is a safe way to install Linux onto a USB drive without going away from
the host machine. This [AskUbuntu](https://askubuntu.com/a/693729/976894)
answer from [Terrance](https://askubuntu.com/users/231142/terrance) helped me
get this working!

1. Find out where your USB drive is located in `/dev`. I'll assume it is at
   `/dev/sdb`.
2. Create a VMWare `.vmdk` disk that points to this USB drive internally.
   `sudo vboxmanage internalcommands createrawvmdk -filename ./usb.vmdk -rawdisk /dev/sdb`
3. Gain ownership of this `sudo chown $USER:$USER ~/usb.vmdk`
4. Add yourself to the `disk` group if you aren't running this as root
   `sudo gpasswd -a $USER disk`
5. Reboot once for permissions to take effect
6. Open VirtualBox and create a VM with the following options
    * Enable UEFI
    * use `usb.vmdk` as the main storage device
    * Mount the distro's .iso into VirtualBox
7. Congratulations! You can now boot the installer and install to a USB drive
   directly!

Note: If your drive letter changed, edit the `usb.vmdk` file by hand. It's just
a text file!
