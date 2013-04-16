#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# pulseaudio
start-pulseaudio-x11  &

# sync clipboards
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection PRIMARY -fork &

# networkmanager
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1&

# set mouse pointer
xsetroot -cursor_name left_ptr &

# set keyboard layout
setxkbmap -layout us  -option compose:ralt 

# xscreensaver
#/usr/bin/xscreensaver -no-splash &

# screen powersave
xset +dpms
xset dpms 0 0 300


#(sleep 10&& /usr/lib/xfce4/notifyd/xfce4-notifyd)&
#(sleep 60&& /home/jelle/bin/spotifynp.py)&
exec dbus-launch xmonad
