# Ubuntu Configuration Automation

This repository contains scripts to automate the setup of Ubuntu 20.04 according
to my specific preferences.

I use Ubuntu 20.04 on my VPS boxes, and Kubuntu 20.04 with Ubuntu Studio tools
on my workstations (until UbuntuStudio 20.10 comes out with KDE as default!).

## Server Setup

I'm assuming you're on a random cloud provider (or a virtual machine) running
**Ubuntu Server 20.04 LTS**.

First, create a non-root user if you are currently root and give this user
administrative privileges. DigitalOcean for example by default makes you login
as root.

```bash
adduser lord
```

Accept all options and set a really strong password for this user. Then do

```bash
usermod -aG sudo lord
su lord
```

You're now operating as the **lord** user!

```bash
mkdir -p $HOME/ext/workspace
cd $HOME/ext/workspace
git clone https://github.com/wingedrhino/DistroSetup
cd DistroSetup/setup-helpers/Ubuntu
sudo ./server.sh
```

After this, move to the DistroAgnostic directory

```bash
cd ../DistroAgnostic
cat README.md
```

And finish the common post-install tasks there!

## Workstation Setup

I'm assuming you're on a laptop and you installed **Kubuntu 20.04 LTS**. I
also assume you have `sudo` privileges because this is the primary user.

```bash
mkdir -p $HOME/ext/workspace
cd $HOME/ext/workspace
apt install git -y
git clone https://github.com/wingedrhino/DistroSetup
cd DistroSetup/setup-helpers/Ubuntu
sudo ./server.sh
sudo ./workstation.sh
sudo ./install-snaps.sh
```

After this, move to the DistroAgnostic directory

```bash
cd ../DistroAgnostic
cat README.md
```

And finish the common post-install tasks there!

## Verifying Ubuntu ISOs

[This article](https://help.ubuntu.com/community/VerifyIsoHowto) on Ubuntu
Community Help Wiki explains quickly how to go about verifying an ISO download.
You SHOULD do this, especially for Ubuntu downloads because they don't seem to
be offered via HTTPS connections. Even the BitTorrent files are not served via
HTTPS. I'm summarizing contents from the linked article here for reference.

### Download Keys

```bash
gpg --keyid-format long --keyserver hkp://keyserver.ubuntu.com --recv-keys 0x46181433FBB75451 0xD94AA3F0EFE21092
```

### Verify Key Fingerprints

```bash
$ gpg --keyid-format long --list-keys --with-fingerprint 0x46181433FBB75451 0xD94AA3F0EFE21092
pub   dsa1024/46181433FBB75451 2004-12-30 [SC]
      Key fingerprint = C598 6B4F 1257 FFA8 6632  CBA7 4618 1433 FBB7 5451
uid                 Ubuntu CD Image Automatic Signing Key <cdimage@ubuntu.com>

pub   rsa4096/D94AA3F0EFE21092 2012-05-11 [SC]
      Key fingerprint = 8439 38DF 228D 22F7 B374  2BC0 D94A A3F0 EFE2 1092
uid                 Ubuntu CD Image Automatic Signing Key (2012) cdimage@ubuntu.com>
```

### Verify Signature

```bash
gpg --keyid-format long --verify SHA256SUMS.gpg SHA256SUMS
```

## Xfce Bugfix: light-locker messes up somewhow

Note: This section doesn't seem to be a problem anymore with KDE. But I'm
mentioning this in case any of you find this from an UbuntuStudio 20.04
installation.

You'd need to replace `light-locker` with `xscreensaver` because the former is
buggy and would prevent you from unlocking your screen. Atleast that's how it
is on my setup.

If you forgot to replace `light-locker` with `xscreensaver`, you may run
`loginctl list-sessions` and then run `loginctl unlock-session [id]` where `id`
is the session of yours which you spotted in `list-sessions`. The included
`unlockscreen.sh` does this for you automatically via a messy but effective
one-liner.
