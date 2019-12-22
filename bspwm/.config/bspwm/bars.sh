#!/usr/bin/env bash

killall polybar

# start "base" bar on primary screen
polybar --reload base &

# start secondary bar on other screens
# TODO create secondary bar
for m in $(polybar --list-monitors | grep -v "primary" | cut -d":" -f1); do
  MONITOR=$m polybar --reload base &
done
