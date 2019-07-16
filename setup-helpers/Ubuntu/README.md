# Ubuntu Configuration Automation

This repository contains scripts to automate the setup of Ubuntu 18.04 according
to my specific preferences.

This is largely based on my Fedora Installation Automation. I've been a long
time user of Fedora (which IMO has a vastly superior package manager that allows
rollbacks if something went horribly wrong and it also has delta-rpm that
greatly reduces upgrade sizes) but I think it is now time to switch to Ubuntu
because I'm getting very tired of not having niche software available for Fedora
like very new development tools or audio production software.

TODO: Update this README.md with more information

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

## Audio Setup

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

