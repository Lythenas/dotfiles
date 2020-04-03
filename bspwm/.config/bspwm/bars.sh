#!/usr/bin/env bash

killall polybar 2>/dev/null

CONFIG=base
if [ $USE_DESKTOP_CONFIG ]; then
  CONFIG=base-desktop
fi

echo "=> Starting bars with config $CONFIG" >&2

# start "base" bar on primary screen
echo "=> Starting bar for primary" >&2
polybar --reload "$CONFIG" &

# start secondary bar on other screens
# TODO create secondary bar
for m in $(polybar --list-monitors | grep -v "primary" | cut -d":" -f1); do
  echo "=> Starting bar for $m" >&2
  MONITOR=$m polybar --reload "$CONFIG" &
done
