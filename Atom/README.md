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
  * `apm list installed --bare >> packages-list.txt`
  * Observe groups separated by blank lines; remove all but bottom-most group to
    keep only community packages
  * Replace regex `@.+$ ` with nothing to remove version names


## Handling Atom Upgrades

Sometimes you want a clean install of Atom. Here's a good way:

* Delete contents of `$ATOM_HOME` minus config files like `config.cson`
* Reinstall package list
* Launch Atom.
* Some packages might ask to install dependencies; do it.
* Reload Atom

