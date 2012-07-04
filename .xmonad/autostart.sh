if pgrep -u jelle nm-applet &> /dev/null;
then
  echo alive &> /dev/null
else
    nm-applet&
fi
if pgrep -u jelle trayer &> /dev/null;
then
  echo alive &> /dev/null
else
  trayer --edge top --align left   --SetDockType true --SetPartialStrut true --width 3 --height 18
  /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1&
fi
