# Atom Editor Setup

This documents my Atom editor setup.

## Multiple Profiles

By changing `$ATOM_HOME` (default ~/.atom) we can create multiple profiles with
different sets of plugins. This makes Atom leaner and also prevents one plugin
from messing up another plugin.

For launching Atom with various profiles, add similar commands to zshrc:
```bash
alias nuclide='export ATOM_HOME=~/.nuclide && atom'
```
Refer to dotfiles/zshrc for the setup I actually use.

## Package Lists

* Maintain different package lists for different profiles
* Install package list via `apm install --packages-file package-list.txt`
* Lists are generated via following steps:
  * `apm list installed --bare > package-list.txt`
  * Observe groups separated by blank lines; remove all but bottom-most group to
    keep only community packages
  * Replace regex `@.*$` with nothing to remove version names
    * On vim, you may run `%s/@.*$//g`
* To run apm commands on one profile, you would set `$ATOM_HOME` to the correct
  profile directory before running the apm install command, like this:
  `ATOM_HOME=$ATOM_PROFILES/goide apm list installed`

### Package Lists I use

* base-package-list.txt has packages all my setups of Atom need. Install this
  in addition to any of the lists below.
* default-package-list.txt has packages to make Atom useful as a general Linux
  text editor.
* goide-package-list.txt has packages to setup Atom as a Golang IDE
  * May need extra packages installed when you open Atom for the first time
* nuclide-packages-list.txt has packages to setup Nuclide
  * May need extra packages installed when you open Atom for the first time

## Handling Atom Upgrades

Sometimes you want a clean install of Atom. Here's a good way:

* Delete contents of `$ATOM_HOME` minus config files like `config.cson`
* Reinstall package list
* Launch Atom.
* Some packages might ask to install dependencies; do it.
* Reload Atom

## Atom on High Resolution Screens

Atom is really hard to use on my 1080p 13.3" screen because all the UI text is
super tiny.

For fixing the editor, hit `Ctrl+` until the font is comfortable.

For the UI, go to the default one-dark-ui theme's settings and change font size
there. Go [here](https://github.com/atom/one-dark-ui#settings) for instructions.

If you have a screen like mine, I suggest a UI font size of 18 for optimum
comfort. It's rather big but since I have a glossy high glare screen, I need all
the size I can get to avoid straining my eyes.
