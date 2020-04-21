# Manjaro Setup

Here's scripts for setting up a Manjaro Workstation from Scratch!

I've separated packages into "server" (console-only) and "workstation" (GUI).
They're in `server.list` and `workstation.list` respectively.

They're both installed after being merged by the `setup.sh` script. If you only
wish to install server packages, feel free to overwrite workstation.list with
an empty file!

The `setup.sh` script in addition performs platform checks, to see if the
requested packages are available. This is because it can also be used on a
Raspberry Pi 4.

Running `sudo snaps.sh` installs a bunch of snaps that don't have equivalent
up-to-date packages in the `community` repository.

Run `user-setup.sh` to set things up for individual users on the system.

## GRUB Setup

### Show Menu Always

* Run `sudo grub-editenv - unset menu_auto_hide`
* Edit `/etc/default/grub`
  * Set `GRUB_TIMEOUT_STYLE=menu`
  * Set `GRUB_TIMEOUT=10` or whatever seconds you want the menu for
* Run `update-grub`

### Misc Stuff

* [Fucked GRUB](https://wiki.manjaro.org/index.php/Restore_the_GRUB_Bootloader)

## Pro Audio

The [Pro Audio](https://www.archlinux.org/groups/x86_64/pro-audio/) package
group is included within the Workstation installer above, along with jack2!

### realTimeConfigQuickScan

Run `yay realTimeConfigQuickScan` to install this script from AUR.

Afterwards you can run `realTimeConfigQuickScan` in your terminal to check the
status of your system so you can individually fix things.

### Realtime Kernel

Go to System Settings -> Kernel. Install a current rt kernel

### Intel CPU Frequency Scaling

Run `yay plasma5-applets-plasma-pstate` to install a plasma applet that handles
configuring your CPU frequency scaling, if you have an Intel CPU.

You want Turbo disabled and CPU Governor set to performance. Change minimum
CPU speed and minimum GPU speed values to the highest they can go. Once you're
done with tracking audio, you can change these numbers back to what they were
earlier.

### The realtime group

Make sure the DAW user is in the realtime group. This is done already by the
`setup-user.sh` script. We're also installing the packages from the `realtime`
group to help set things up. Now is a good time to go through the RT docs on the
[Arch Wiki](https://wiki.archlinux.org/index.php/Realtime_process_management).

### Misc Scriptable Stuff

You can find these in `prepare-pro-audio.sh`. They're based on the output of
realTimeConfigQuickScan.

## Raspberry Pi 4

I'm going to try and make things so that the same desktop (Manjaro KDE) runs on
both a 64bit x86 laptop and a 64bit ARMv8 RaspberryPi 4. You can thus use the
same scripts on both platforms!

