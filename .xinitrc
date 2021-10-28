#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# https://bugs.archlinux.org/task/58368
dbus-update-activation-environment DISPLAY XAUTHORITY

# set keyboard layout
setxkbmap -layout us  -option compose:ralt -option caps:hyper &

exec i3
