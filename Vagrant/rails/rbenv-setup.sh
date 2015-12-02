#!/usr/bin/env bash
#
# NOTE:
# * Rbenv install is not idempotent
# * This script assumes necessary tools to compile a ruby are present
# * This script should be run as the user which is used to deploy an app with
#

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
echo 'export RBENV_VERSION="2.2.3"' >> ~/.bashrc
~/.rbenv/bin/rbenv install 2.2.3
~/.rbenv/bin/rbenv rehash

