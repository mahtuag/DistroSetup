# Ubuntu Configuration Automation

This repository contains scripts to automate the setup of Ubuntu 18.04 according
to my specific preferences. I used to use Fedora (because dnf is way better than
apt) but moved to Ubuntu because of better third party desktop app support.

## How to use these scripts

These are opinionated scripts that setup machines the way I like them. So I'm
assuming you use the exact same Ubuntu version that I expect you to!

### Server Setup

I'm assuming you're on a random cloud provider (or a virtual machine) running
**Ubuntu Server 18.04 LTS**.

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
./as-user.sh
sudo su root
./as-root.sh
chsh -s /usr/bin/zsh
exit
```

Note that half-way you login as root and then go back again. You'd need to enter
enter your password a few times if you haven't enabled passwordless sudo.

You're now done!

### Workstation Setup

I'm assuming you're on a laptop and you installed **Ubuntu Studio 18.04 LTS**. I
also assume you have `sudo` privileges because this is the primary user.

```bash
mkdir -p $HOME/ext/workspace
cd $HOME/ext/workspace
apt install git -y
git clone https://github.com/wingedrhino/DistroSetup
cd DistroSetup/setup-helpers/Ubuntu
sudo ./server.sh
sudo ./workstation.sh
./as-user.sh
./as-user-workstation.sh
sudo su root
```

The last step makes you login as root. Now do:

```bash
./as-root.sh
chsh -s /usr/bin/zsh
exit
```

You're now done!

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

## Disable Suspend on Lid Close

This section has been fully automated in `workstation.sh` but I'm including this
for some context.

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

### Bugfix: light-locker messes up somewhow

You'd also need to replace `light-locker` with `xscreensaver` because the former
is buggy and would prevent you from unlocking your screen. Atleast that's how it
is on my setup.

If you forgot to replace `light-locker` with `xscreensaver`, you may run
`loginctl list-sessions` and then run `loginctl unlock-session [id]` where `id`
is the session of yours which you spotted in `list-sessions`. The included
`unlockscreen.sh` does this for you automatically via a messy but effective
one-liner.

## UFW Setup

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

## Redshift Setup

RedShift tends to stay running when user logs out and you'd be left with several
instances of it running at the same time on subsequent logins. Avoid this by
disabling RedShift's autostart, run a `killall redshift` when you login and
start RedShift manually via the start menu.

TODO: Update with better work-arounds.

## Pro Audio Setup

UbuntuStudio comes with a low-latency kernel by default but we still need to
make a few tweaks to our setup. A quick check can be done via running
[realTimeConfigQuickScan](https://github.com/raboof/realtimeconfigquickscan).

```bash
git clone https://github.com/raboof/realtimeconfigquickscan
cd realtimeconfigquickscan
perl ./realTimeConfigQuickScan.pl
```

This should give you a diagnosis report.

### Setting CPU Governor to Performance

I've included a script, `makecpufast.py` that you need to run as root via
`sudo ./makecpufast.py`. This should be done each time you start your laptop
and run the jack server. I'll probably fix it up so it is a bit more generic and
put it in its own repository. But for now, this should do!

EDIT: This, alongside the option to disable Intel Boost is available via the
**Ubuntu Studio Controls** in your start menu. You don't really need my script
anymore but I've left it in regardless.

### Jack Setup

Set server path to `jackd -S` instead of the default `jackd` in the settings
section on `qjackctl`.

#### Focusrite Scarlett Solo

The settings I use are:

* Sample Rate 192000
* Frames/Period 512
* Periods/Buffer 3

This gives me a latency of 8 msec.

If I bump up the Frames/Period to 1024, I get a latency of 16 msec which is
still somewhat bearable.

#### Intel HDA Sound Card (Internal)

The settings I use are: **TODO**

Refer [Linux Audio Wiki](https://wiki.linuxaudio.org/wiki/list_of_jack_frame_period_settings_ideal_for_usb_interface)

### Liquorix Kernel

This is an alternate kernel you may install/remove via the interactive script in
`liquorix.sh`. Since this is a third-party package that may not be very stable,
do not consider installing it until you've finished every other pro audio setup
step and STILL find yourself dissatisfied with the audio performance.

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
  * A Linux Kernel which is tuned for realtime preemption.
  * I haven't yet tried this out, but it should ideally offer better performance
    than the `-lowlatency` kernels included in the official Ubuntu repositories.
* [KXStudio](https://kx.studio/)
  * Additional Pro Audio Software for Linux
  * I haven't tried these out myself so will update these docs if/when I do!
