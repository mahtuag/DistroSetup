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

## UFW Setup

See [here](https://serverfault.com/questions/468907/ufw-blocking-apt) for how to
setup a sane default for UFW.

Digital ocean also has[a nice tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-16-04)
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
