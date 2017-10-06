# Raspberry Pi 3 Model B Setup

I run Raspbian Stretch Lite on my Raspberry Pi 3 Model B. Here's my setup.

A lot of documentation on the internet on how to setup the Pi seems to be
outdated. I shall keep this page updated as long as I use the Pi.

All instructions work on a Fedora 26 x86_64 Xfce4 Spin laptop.

## Install

You first need a good MicroSD card. I use a Samsung Evo+ Class 10 32GB.
https://www.amazon.in/gp/product/B00WR4IJBE/

Download the latest image via BitTorrent. Here's the Torrent link for quick
access: https://downloads.raspberrypi.org/raspbian_lite_latest.torrent

Follow the official install instructions here:
https://www.raspberrypi.org/documentation/installation/installing-images/linux.md

For those who know how to be smart about copy-pasting commands, here's the
relevant command to burn a `.img` file to your MicroSD card:

```bash
sudo dd bs=4M if=2017-08-16-raspbian-stretch-lite.img of=/dev/mmcblk0 status=progress conv=fsync
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
you even begin to use it.

## Connecting to Ethernet

### Connecting via DHCP

You don't need to setup ethernet on the Pi if the ethernet interface the Pi
connects to supports DHCP for IP address allocation because the Raspberry Pi
comes setup with this enabled out of the box.

### Connecting via Static IP

**TODO**

I don't use this setup so I'm leaving this section emtpy.

### Sharing ethernet from laptop via NetworkManager

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

## Setting up WiFi

Edit `/etc/wpa_supplicant/wpa_supplicant.conf` and add this:

```
country=IN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="your WiFi SSID"
    psk="<your WiFi password>"
}

```

### Static IP Address on WiFi

You probably need a static IP connection to the Pi. I'm assuming you are using
an Android hotspot as a router, for which the gateway is usually `192.16843.1`.

Edit `/etc/network/interfaces` and make it look like this:

```
# interfaces(5) file used by ifup(8) and ifdown(8)

# Please note that this file is written to be used with dhcpcd
# For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

allow-hotplug wlan0
iface wlan0 inet static
        address 192.168.43.100
        netmask 255.255.255.0
        gateway 192.168.43.1
        dns-nameservers 8.8.8.8 8.8.4.4
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

```

That's it! The Rapsberry Pi now connects to WiFi automatically during boot.

You can also make this edit before the first boot, so that the Pi starts with
WiFi already setup.
