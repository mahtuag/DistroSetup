# Dot Files

This repository contains a few dotfiles I end up repeatedly settinng up after a
fresh install of a GNU/Linux distro.

## .vimrc

No fancy IDE setup - I use Atom editor for that. This just contains enough to
make a standard default Fedora vim installation slightly more bearable.

## .zshrc

I found a .zshrc on the internet sometime in Q2 2013 which I really liked.
Removed a few things I did not need and that's about it! I also made zsh
use `.bash_history` as its history file to be compatible with bash.

## .profile

Common things setup my way, for use across shells - bash and zsh.

## .gitconfig

This has a curated set of git shortcuts I personally have found to be extremely
handy. And without these shortcuts I find git slightly painful to manage.

## .conkyrc

I based this off Fedora's default conkyrc file. Only tested on Xfce4. For some
reason putting conky on autostart causes the conky window to disappear. Only
solution as of now seems to be manually starting it (it goes off to the
background).
