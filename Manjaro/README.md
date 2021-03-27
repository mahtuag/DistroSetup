# Manjaro / ArchLinux Setup

Here's scripts and docs for setting up a Manjaro Workstation from Scratch!

I'm assuming that you want to setup Manjaro with KDE, want all the usual office
and internet utilties, you'd like to be able to develop software in here, and
would like to also turn this into a multimedia workstation, with a focus on
Pro Audio. I'll also add some packages for video and image editing, but at this
moment I haven't tested them enough.

## Basic Install Steps

Here's how you go about getting the official Manjaro distribution onto your
machine

### Intel/AMD vs Raspberry Pi 4

#### Intel/AMD Desktops and Laptops

1. Download ISO from [here](https://manjaro.org/downloads/official/kde/)
3. Insert a USB drive and determine its location in `/dev`. I'm assuming it's
   `/dev/sdb` for the purpose of this section.
3. Run `sudo dd if=/path/to/the.iso of=/dev/sdb bs=4M status=progress oflag=sync`
4. Remove the USB drive, stick it into the machine you wish to Install Manjaro
   and Reboot.
5. Use the graphical installer to install Manjaro with full disk encryption on
   your machine with the default settings.

Note: I need to figure out how to install Manjaro with btrfs. This is supposed
to be MUCH better than EXT4 because you can take easy snapshots of your entire
filesystem. So if the `/` partition is separated from `/home`, you can easily
restore `/` to a different version if something goes wrong.
   
#### Raspberry Pi 4 Model B

1. Download image from [here](https://manjaro.org/download/arm/raspberry-pi-4/arm8-raspberry-pi-4-kde-plasma/)
2. Extract the `.xz` file via `unxz /path/to/image.img.xz`
3. Pop a >= 32GB MicroSD card into a MicroSD to SD adaptor and stick it into
   the SD Card slot in your laptop/desktop. Determine it's location in `/dev`.
   Usually it'll be `/dev/mmcblk0`.
4. Run `sudo dd if=/path/to/image.img of=/dev/mmcblk0 bs=4M status=progress oflag=sync`
5. Insert the MicroSD card into your Raspberry Pi 4 Model B.
6. Connect your Pi to a HDMI display, keyboard, and mouse. Manjaro doesn't
   currently seem to have a headless install option.
7. Power on the Raspberry Pi and wait to see the options on the screen to
   finish the install!

##### For Advanced Users

Read [this](https://forum.manjaro.org/t/wiki-contributing-to-manjaro-arm/91053)
to roll out your own custom installers!

### Server vs Workstation Install

**Note: If you're following along on your laptop/desktop/RaspberryPi, just skip
this step and move to the next one!**

I've separated packages into "server" (console-only) and "workstation" (GUI).
They're in `server.list` and `workstation.list` respectively. The "server"
packages are really meant for when you'd like to setup a cloud VPS with Manjaro
or ArchLinux, and would install no GUI packages.

The two lists are merged before being installed. If you'd like to install only
commandline tools, run `echo "" > workstation.list`.

This should empty the workstation package list. Then you can proceed as normal!

### Choose Extra packages.

**Note: For advanced users. You might want to skip this step if you'd just like
to have a base system that has the same packages I have.**.

If there's any packages that are present in the Arch/Manjaro repositories that
aren't in `server.list` or `workstation.list`, add them to `extras.list`.

### Run rankmirrors.sh

The very first thing you should do before you proceed with installing a large
number of packages is to make sure you have have the best package mirrors, for
optimal download speeds.

Disconnect any devices that are on the same WiFi/router as your laptop first,
to ensure you get the most accurate measurements.

Then run `sudo ./rankmirrors.sh` and wait a bit.

This should choose the fastest mirrors for your system.

### Run setup.sh

This script does the heavy lifting for you by downloading and installing all
updates, as well as downloading and installing any new packages.

After you run it, and just before you're prompted to enter your password, read
the output of the script and confirm that the packages you selected are all
there.

The script does the following things:

1. Merge `server.list`, `workstation.list`, and `extras.list` after de-duping
   them.
2. Look up the newly selected packages inside the repositories and de-select
   ones which are missing from the repositories. This can happen due to
   differences between Arch and Manjaro repositories, and due to differences
   between `x86_64` (Intel/AMD laptop/desktop) and `aarch64` (Raspberry Pi 4)
   repositories.
3. Simultaneously update the system and ask `pacman` (the Arch package manager)
   to install those packages from the list generated in the previous step that
   are not already installed.

## Run Post-Install Tasks from DistroAgnostic

Run `cd ../DistroAgnostic` and `less README.md`!

## Fix Signal Messenger to have tray icon

* https://askubuntu.com/questions/1123693/how-minimize-signal-messenger-to-system-tray-top-right-corner
* Edit `/usr/share/applications/signal-desktop.desktop`
* Add option `--use-tray-icon` to the command

## Misc Stuff

* [Fix GRUB](https://wiki.manjaro.org/index.php/Restore_the_GRUB_Bootloader)
  when you screwed up your bootloader.

## Pro Audio

The [Pro Audio](https://www.archlinux.org/groups/x86_64/pro-audio/) package
group is included within the Workstation installer above, along with `jack2`
and some scripts in the `realtime` package group!

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

### DistroAgnostic: prepare-pro-audio.sh

Misc tasks to prepare a pro audio system, like reducing swapiness, making a
better timers available, etc aare in `../prepare-pro-audio.sh`.
The steps there are based on the output of realTimeConfigQuickScan.

## Raspberry Pi 4

I'm going to try and make things so that the same desktop (Manjaro KDE) runs on
both a 64bit x86 laptop and a 64bit ARMv8 RaspberryPi 4. You can thus use the
same scripts on both platforms!

For now, it seems like a bunch of important packages aren't available, the
most prominent being IDEs like VS Code.


## Setup VirtualBox in Manjaro

Refer [the official wiki](https://wiki.manjaro.org/index.php?title=VirtualBox)
