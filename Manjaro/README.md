# Manjaro Setup

Here's scripts for setting up a Manjaro Workstation from Scratch!

I've separated packages into "server" (consone-only) and "workstation" (GUI).
They're in `server.list` and `workstation.list` respectively.

Running `server.sh` updates the system and installs packages in `server.list`.

Running `workstation.sh` updates the system and installs packages in
`server.list` as well as `workstation.list`.

Running `sudo snaps.sh` installs a bunch of snaps.

## Pro Audio

The [Pro Audio](https://www.archlinux.org/groups/x86_64/pro-audio/) package
group is included within the Workstation installer above!

TODO: Coming soon!

## Raspberry Pi 4

I'm going to try and make things so that the same desktop (Manjaro KDE) runs on
both a 64bit x86 laptop and a 64bit ARMv8 RaspberryPi 4. You can thus use the
same scripts on both platforms!

