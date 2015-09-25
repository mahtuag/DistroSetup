# Use Vagrant, reduce pain

## The Trouble

### The Multiple Projects Problem

* I have one workstation
* I need to work on multiple projects at the same time
* Each project has its own specific setup like databases, runtimes, etc
* I reuse standard ports across projects (8080)

Switching between projects is hard!

### The Multiple Corporate Accounts Problem

* I have a separate username@project.com corporate email setup for communication
  in some of my bigger projects
* Heroku, GitHub, AWS and various SaaS services are accessed via this email and
  not my personal email

Switching between accounts is hard! I need multiple browsers and/or multiple
user accounts - one for each project.

### The Project default Distro Problem

* Some projects extensively depend on a specific Linux distribution's ecosystem
  which is most commonly CentOS, Ubuntu or Debian.
* My laptop needn't necessarily run the same distro making local development
  painful.

### Screwing with Default Setup is PITA

* I don't like it when my personal GitHub, BitBucket and Heroku accounts are
  inaccessible for some reason or give up ability to passwordlessly SSH into
  my personal GitHub Account.
* I don't like switching browsers and losing my active sessions. I'm not willing
  to go through the pain of setting up a complex sync tool either.
* I need to context switch across projects constantly and I don't like when it
  interferes with my "normal" laptop use.

## The Solution

Now for all this to work from one user account running on a machine is asking
for a little too much. The "corporate" solution is to have a separate work and
personal laptop, but if you're the type who does not appreciate shoving around
multiple laptops, this wouldn't work for you.

Here comes [Vagrant](http://vagrantup.com), which would soon become your savior.
I recommend everyone to go through the website and follow the really easy to use
tutorials and understand what vagrant does.

### Using Vagrant

What a developer would need to do is setup a Vagrant box starting with a base
distro, like CentOS 7 (or whatever you use in your production machines) and
create a provisioning script (I recommend re-using production provisioners
or just sticking to good old shell scripts) which installs all the software
needed to compile and run the project. You could then SSH into the machine via
`vagrant ssh` and setup your personal account details accurately, like a
.gitconfig file which uses your company email, passwordless push for GitHub,
Heroku, etc with your company email and a browser (enable GUI in Vagrant first)
where you're logged into all the company stuff neatly.

Now all you need to do is to run `vagrant up` and there you go! A custom box
configured just right for your project.

If you're the smart type you can separate out the personal aspects (like setting
up passwordless push for GitHub) from the non-personal aspects (like installing
the software you need to work) when setting up the machine and share the new
Vagrantfile along with its provisioning script to the rest of your team.

### My ArchLinux Vagrantfile

I like to use the latest versions of all software for personal, small-time or
"indie" projects because there are always shiney new features I like to develop
against.

Sadly, the current ecosystem revolves around keeping users with really old
software happy - this works in an enterprise world but not in my world. A
typical Linux Distro's repositories often contain weirdly packaged obsolete
versions of software.

There is an exception to that - ArchLinux. It stays bleeding edge no matter what
and has been one of the first to package software like Go 1.5, nodejs 4.0, etc.

If you aren't comfortable with installing it just for the latest packages, you
can still use it as a development playground through Vagrant.

In this folder I have uploaded a sample Vagrantfile which you can hack.
