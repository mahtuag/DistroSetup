#!/bin/sh
loginctl unlock-session `loginctl list-sessions | grep -i $USER | grep -v tty | awk '{print $1}'`
