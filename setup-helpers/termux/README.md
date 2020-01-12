# Termux Setup

Termux is an awesome Linux environment for Android, based on Ubuntu. I am
currently in the very early stages of automating its setup, so that I can run
it on a bunch of old Android phones and treat them like tiny low powered
servers.

## SSH Setup

Refer to wiki on [Remote Access](https://wiki.termux.com/wiki/Remote_Access)
before you proceed, because the lack of a full-sized keyboard to monkey on
makes Termux *slightly* painful before SSH is setup.

### Static IP

Make sure your household WiFi router's DHCP server assigns the same IP to the
phone on which Termux runs, whenever it connects. This would make your life a
LOT easier. Example: [TP-Link](https://www.tp-link.com/us/support/faq/488/).

### Android Debugger based Port Forwarding

By default SSH runs on Port 8022 in Termux. ADB can forward this port on the
phone to the same port on localhost. There's a nice blog about this subject
[here](https://glow.li/technology/2016/9/20/access-termux-via-usb/).

### Passwordless SSH

You'd want to follow my existing docs for passwordless SSH. But before you go
about adding entries into $HOME/.ssh/authorized_keys, I suggest you enable
password-based login so that the first login is easy.

Later you disable password-based login via

```bash
echo "PasswordAuthentication no" >> $HOME/.ssh/sshd_config
```

## Get PostgreSQL Running

Refer: https://wiki.termux.com/wiki/Postgresql

## Other Stuff

More coming soon!
