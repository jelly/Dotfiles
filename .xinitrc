#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# set keyboard layout
setxkbmap -layout us  -option compose:ralt -option caps:hyper &

# screen powersave
xset +dpms
xset dpms 0 0 300

exec dbus-launch i3
