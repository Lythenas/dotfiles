#!/bin/bash

export PATH=$HOME/bin:$PATH

export TERMINAL=alacritty

# Fix gnome apps and service
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Load resources
xrdb -merge .Xresources

# Set up an icon tray
trayer --edge top --align right \
  --SetDockType true --SetPartialStrut true \
  --expand true --widthtype request --transparent true \
  --tint 0x191970 --height 17 --monitor primary &

# Set the background
xsetroot -solid midnightblue

# Set cursor
xsetroot -xcf /usr/share/icons/Adwaita/cursors/left_ptr 24

# Fire up apps

# Screensaver and locking
xscreensaver -no-splash &
#xss-lock -- xscreensaver-command -lock &
xfce4-power-manager &

# Clipboard manager
clipit &

## Notification center
deadd-notification-center &

if [ -x /bin/nm-applet ] || [ -x /usr/bin/nm-applet ]; then
  nm-applet --sm-disable &
fi

syncthing-gtk &

# Start window manager
exec xmonad
