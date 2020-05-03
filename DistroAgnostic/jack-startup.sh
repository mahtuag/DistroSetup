#!/bin/sh

#
# This script is meant to be added to the startup of qJackCtl
# I'm assuming you need 2 sinks - one for playback; one to route to ardour.
# We just need 1 jack source though, for connection FROM ardour
# I'm going to assume you use Ubuntu Studio Controls or Cadence though.
# Both of those tools make this script unnecessary.
#
pactl load-module module-jack-sink channels=2 client_name=jack_out connect=yes
pactl load-module module-jack-source channels=2 client_name=jack_in connect=yes
pactl load-module module-jack-sink channels=2 client_name=ardour_jack_in connect=no
a2jmidid -e &
