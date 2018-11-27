#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# pulseaudio
start-pulseaudio-x11  &

# set keyboard layout
setxkbmap -layout us  -option compose:ralt -option caps:hyper &

# screen powersave
xset +dpms
xset dpms 0 0 300

exec i3
