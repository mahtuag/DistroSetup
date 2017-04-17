## SSH Config

SSH Configuration: tips and ideas.

## SSH: Using Multiple Keys

There are a bunch of scenarios when you don't want to use the same SSH key pair
for all your applications. Here's a simple way to achieve that.

### Generate the key

We use ssh-keygen to create the keys. If you already have the keys, skip this
step.

```bash
mkdir -p ~/Documents/.secrets/crypto_keys/hostname.example.com
cd ~/Documents/.secrets/crypto_keys/hostname.example.com
ssh-keygen -t ed25519 -C "hostname.example.com"
```

* When asked to choose filename, type `id_ed25519`
* Press return to accept the defaults

Note that two files are created - `id_ed25519` and `id_ed25519.pub`. The former
should be kept super secret while the later is shared with machines which use it
to recognize you.

### Configure SSH to use the key

The file to edit is `~/.ssh/config`

Add the following lines to it:

```ssh_config
# Passwordless SSH into hostname.example.com
# Note that this can also be an IP address or something defined in /etc/hosts
Host hostname.example.com
  HostName hostname.example.com
  PreferredAuthentications publickey
  IdentityFile ~/Documents/.secrets/crypto_keys/hostname.example.com/id_ed25519
  LocalForward 80 localhost:8080
```

#### What different fields mean

You could read up more about ssh configuration by running `man ssh_config`

* **Host** could be an abbrevated name instead of the full name - you may use
  `my_example_host` instead of `hostname.example.com` for example.
* **HostName** is the actual address of the host you connect to. This could be
  an IP address like `192.168.1.5`, a public domain name like
  `somehost.example.com`, or a `/etc/hosts` domain hack like `officebox-ubuntu`.
* **PreferredAuthentications** sets the order in which you attempt to use
  various authentication methods. Since we are using a public key to log into
  the server, the only entry needed here is `publickey`
* **IdentityFile** points to the private key you just created.

##### LocalForward

This is an extra that I'm including because I couldn't find a better place to
put it.

**LocalForward** can be used to specify ports of the remote machine that you
want forwarded to from ports of the local machine. In the example, I use local
port 8080 to access remote port 80.

I have found this field to be extremely useful when working with a remote dev
workstation or a VirtualBox VM which I use for development (so that I don't
pollute my primary host).


### Copy your public key to the remote machine

Remember to copy the **public key** whose name ends in **.pub**. If you
accidentally share the private key, stop using it immediately - delete it from
the servers you access with that key and create a new set of keys.

#### Via command if you can login to the remote machine

* Run this command:

```bash
ssh-copy-id -i ~/Documents/.secrets/crypto_keys/hostname.example.com/id_ed25519.pub username@hostname.example.com
```

#### Manually if you can't login to the remote machine

Copy `~/Documents/.secrets/crypto_keys/hostname.example.com/id_ed25519.pub`
manually into the machine behind hostname.example.com by whatever means and run
these commands (assuming the file `id_ed25519.pub` exists in the machine) from
the directory in which you hve the file `id_ed25519.pub`.

```bash
mkdir ~/.ssh
chmod 700 ~/.ssh
cat id_ed25519.pub >> ~/.ssh/authorized_keys
rm id_ed25519.pub
```

Note that you can manually edit `~/.ssh/authorized_keys` to remove public keys
you wish to revoke.

#### For BitBucket, GitHub or similar software service

* Use the UI provided by the service to upload or paste your public key
