# PostgreSQL + Node.js + Nginx Stack

This Vagrantfile is for a development stack containing the latest versions of
Node.js, PostgreSQL and Nginx (mainline) setup on CentOS 7.

I'm focusing on stability for production use (hence CentOS 7) while at the same
time including the ability to use the latest and the greatest features offered
by each of the components of this stack (Node.js, PostgreSQL and Nginx) and thus
I am installing all of them from external, regularly maintained and updated
repositories that contain the latest stable versions all the time.

## Source Packages

* CentOS uses CentOS 7.x Vagrantfile published by centos.org
* Node.js uses the NodeSource Node.js 5.x for RHEL7 x86-64 repository
* Nginx uses Nginx mainline RHEL7 x86-64 repository
* PostgreSQL uses the PostgreSQL 9.4 official x86-64 repository for RHEL7

Packages will be mercilessly upgraded to the latest stable version so do not
depend on this repository for old versions. In particular, I shall be tailing
the Node.js stable releases very closely (upgrade to 6.x asap) and eagerly look
forward to PostgreSQL 9.5 release.

## Source Organization

You need the Vagrantfile and the setup.sh files to provision a new machine.
