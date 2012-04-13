#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# start gnome-keyring
eval `gnome-keyring-daemon`
export GNOME_KEYRING_PID
export GNOME_KEYRING_SOCKET
export SSH_AUTH_SOCK
export GPG_AGENT_INFO

# start urxvt daemon
urxvtd -q -f -o & 

# sync clipboards
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection PRIMARY -fork &

# networkmanager
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1&

# set mouse pointer
xsetroot -cursor_name left_ptr

# set keyboard layout
setxkbmap -layout us  -option compose:ralt 

# disable trackpad while typing
syndaemon -t -k -i 2 -d &

# xscreensaver
/usr/bin/xscreensaver -no-splash &

(sleep 10&& /usr/lib/xfce4/notifyd/xfce4-notifyd)&
(sleep 60&& /home/jelle/bin/spotifynp.py)&
exec ck-launch-session dbus-launch xmonad
