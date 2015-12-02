# Vagrant Rails Development Box


This setup is **not intended for production** as 3rd party repositories often
don't support non LTS releases of Ubuntu. PostgreSQL I specifically noted as
having this problem.

## Stack

* Ubuntu 15.10 "Wily Werewolf" 64-bit official Vagrantfile as base
* Ruby installed via Rbenv (currently 2.2.3)
* Rails installed via Gem (currently 4.x)
* PostgreSQL 9.4 from Ubuntu repositories
* NGINX mainline (now 1.9.x) from NGINIX for Ubuntu repository
* Node.js 5.x from NodeSource for Ubuntu repository


## Setup

Copy the files in this repository into someplace where you will create your
workspace.

Get the machine up and running.

```bash
vagrant up
```

Login to the box

```bash
vagrant ssh
```

Run required setup as root and wait for it to complete

```bash
sudo /vagrant/setup.sh
```

Run required setup as user and wait for it to complete

```bash
/vagrant/rbenv-setup.sh
```

Exit the VM

```bash
exit
```

Back in your own machine, restart the machine

```bash
vagrant reload
```

Login again and start working!

```bash
vagrant ssh
```

## Rails Setup

I recommend following [RailsTutorial.org](https://www.railstutorial.org/book/)
for a brilliant primer on how to get rails up and running.

## Rails 5 Setup

Coming soon! I'll create a shell script you can use to clone Rails from the
5.x dev branch if you wish to use that.

## Redis, RabbitMQ, etc

I am not using them with Rails personally so I haven't bothered adding them in
the mix as of now. Would do later when I get time!

