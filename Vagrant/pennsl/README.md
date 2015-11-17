# PostgreSQL + EmberJS + Node.js + NGINX + SystemD + Linux Stack

I'd like to call it the "PENNSL" stack for the lulz.

I am not putting any opinions on my ideas of REST API framerworks for the lack
of space within the acronym and to keep the user free to pick whatever works.

Having said that, here is a list of framworks to provide the REST API:

* [Hapi](http://hapijs.com/)
* [Koa](http://koajs.com/)
* [Restify](http://restify.com/)
* [Loopback](http://loopback.io/)
* [Express](http://expressjs.com/)

## Installed Packages

* [CentOS 7 x86-64](https://www.centos.org/) uses [CentOS 7 Vagrantfile](https://atlas.hashicorp.com/centos/boxes/7)
* [Node.js](nodejs.org) uses the [NodeSource](https://github.com/nodesource/distributions) Node.js 5.x for RHEL7 x86-64 repository
* [ember-cli](http://www.ember-cli.com/) for [Ember](http://emberjs.com/) installed via npm
* [NGINX](http://nginx.org/) uses [NGINX mainline RHEL7 repository](http://nginx.org/en/linux_packages.html#mainline)
* [PostgreSQL](http://postgresql.org/) uses the [PostgreSQL 9.4 RHEL7 repository](http://yum.postgresql.org/)
* [SystemD](https://fedoraproject.org/wiki/Systemd) from the official repositories
* [Linux kernel](http://linux.com/) from the official repositories

Packages will be mercilessly upgraded to the latest stable version so do not
depend on this repository for old versions. In particular, I shall be tailing
the Node.js stable releases very closely (upgrade to 6.x asap) and eagerly look
forward to the PostgreSQL 9.5 release.

## Source Organization

You need the Vagrantfile and the setup.sh files to provision a new machine.
I am working on refactoring the provision scripts (which took a while to setup)
so that there is no "magic" (like nodesource's curl + bash one-liner) and each
package for CentOS 7 has a separate provision script.
