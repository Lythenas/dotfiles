#!/usr/bin/env bash

wid=$1
class=$2
instance=$3
consequences=$4

windowname=$(xdotool getwindowname $wid)

echo -e "[$(date --rfc-3339=ns)]\nwid: $wid\nclass: $class\ninstance: $instance\nconsequences: $consequences\nwindowname: $windowname" >> ~/window.events

eval $consequences

if [[ "$class" == "Steam" ]] && echo "$windowname" | grep "Steam Guard" 2>&1 >/dev/null; then
    # steam guard => floating
  echo state=floating
elif [[ "$class" == "firefox" ]] && echo "$windowname" | grep "Opening" 2>&1 >/dev/null; then
    # firefox save dialog => on current desktop
    # echo desktop=focused
    echo node=focused
fi

