#!/usr/bin/env bash

wid=$1
class=$2
instance=$3
consequences=$4

if xdotool getwindowname $wid | grep "Steam Guard" 2>&1 >/dev/null; then
  echo state=floating
fi

