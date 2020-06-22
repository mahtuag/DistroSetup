# Raspberry Pi Setup

I own a Pi Zero W and a Pi Zero WH, as well as a Pi 4 Model B 4GB. They all run
Debian Buster. Here's how I set things up.


## Install

You first need a good MicroSD card. I use a Samsung Evo+ Class 10 32GB.
https://www.amazon.in/gp/product/B00WR4IJBE/

But TBH you can also use an old slow 8GB memory card that you have lying around,
if all you do with the Pi is treat it like a much beefier microcontroller to do
random gruntwork where performance isn't important as much as the fromfactor
being tiny.

Download the latest image via BitTorrent. Here's the Torrent link for quick
access: https://downloads.raspberrypi.org/raspbian_lite_latest.torrent

Follow the official install instructions here:
https://www.raspberrypi.org/documentation/installation/installing-images/linux.md

For those who know how to be smart about copy-pasting commands, here's the
relevant command to burn a `.img` file to your MicroSD card:

```bash
sudo dd bs=4M if=2019-09-26-raspbian-buster-lite.img of=/dev/mmcblk0 status=progress conv=fsync
```

## Resizing the Root Partition

Raspbian does this automatically upon first boot

## Enabling SSH

Go to the boot partition on the card in your laptop (it's a tiny ~43mb fat32)
and run `touch ssh` to enable SSH access. Otherwise SSH access is disabled due
to security reasons.

For the same security reasons (default username is `pi` and default password is
`raspberry`) I suggest connecting to a trusted network for the very first time
to change the password so that a nefarious machine doesn't infect the Pi before
you even begin to use it. Or better, just launch it while it's connected to a
HDMI display, keyboard and mouse.

## Setting up Ethernet

You don't need to. This comes pre-configured!

## Setting up WiFi

You can create a `wpa_supplicant.conf` in the boot partition like this:

```
country=IN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="your WiFi SSID"
    psk="<your WiFi password>"
}

```

After booting up it'll be copied over automatically to where it should go -
`/etc/wpa_supplicant/wpa_supplicant.conf`.

## Setting up Static IP Address

Edit `/etc/dhcpcd.conf` and add this to the bottom:

```
interface wlan0
static ip_address=192.168.43.22
static routers=192.168.43.1
static domain_name_servers=1.1.1.1 1.0.0.1
```

You could do something similar for `interface eth0`, if this is a full-sized Pi
that comes with Ethernet.

I've this setup where ALL my routers/hotspots use the same subnet address,
`192.168.43.0`. I then allocate static IP addresses to all my machines so that
whatever network they're on, their IP addresses remain the same. You might note
that this subnet `192.168.43.0` is what's used by an Android phone.

## Pi Zero Gadget Mode

This is _the_ thing that makes a Pi Zero a fun toy. You can make the Pi Zero
emulate a keyboard, mouse, ethernet port, MIDI device, etc.

1. Edit `/boot/config.txt`
    * add a line with `dtoverlay=dwc2` at the very end of the file.
2. Edit `/boot/cmdline.txt`
    * This file is weird; it has no newlines and everything is separated by
      exactly ONE space
    * add `modules-load=dwc2,g_ether` after `rootwait`
3. Your next boot should have your Pi Zero working as an ethernet controller.
4. Plug the Pi Zero into your laptop and wait ~90 seconds.
5. Wait for the Wired Connection (1/2/3) to show up in your network manager tab
6. Go to network-manager's menu
    * hit edit connections
    * edit the new connection
    * switch to ipv4 tab
    * change the method to "Link-Local"
    * save and close
7. Disconnect and reconnect this network
8. You can now run `ssh pi@raspberrypi.local` to access the Pi.
9. Make a bridge connection between the Pi and your WiFi to give it internet
   access.

TODO: elaborate on bridge network

### Reference Links

* https://blog.gbaman.info/?p=791
* https://blog.gbaman.info/?p=699
* https://e2e.ti.com/support/processors/f/791/t/612303?Linux-AM5728-USB-OTG-network-works-intermittently

## Sharing ethernet from laptop via NetworkManager

If you use NetworkManager to share your ethernet connection via a cable, the
allocated IP address seems to be consistent each time the Pi reconnects. I'm yet
to check why this is but there's probably some hardcoded values in play here.

To check that IP, do an `ifconfig` and determine your IP address on the
appropriate ethernet interface after you've activated the connection. It's
usually something like `10.42.0.1`.

Then make sure the package `nmap` is installed and run `nmap -sn 10.42.0.0/24`
to see what other machines in the network are reachable.

The only machine other than `10.42.0.1` is the Raspberry Pi. Add this to your
laptop's `/etc/hosts` for quick access, via a one-line entry like this:

```
rpi3b 10.42.0.216
```

Now you can do a simple `ssh rpi3b` to access the machine.

If like mine, your laptop comes without an ethernet port, look for a cheap USB
adapter on Amazon. I have this one: https://www.amazon.in/gp/product/B0752TG1WC/

## Using the Pi as a hotspot

TODO: WIP

https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md

TODO: I am creating a bunch of scripts to automate some of the actions involved
in turning the Pi into a Hotspot / shared connection tool.
