#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# set keyboard layout
setxkbmap -layout us  -option compose:ralt -option caps:hyper &

exec i3
