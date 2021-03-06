#!/bin/bash

counter=0

while [ $counter -lt 4 ]; do
  counter=$(("$counter" + 1))

  if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
      updates_arch=0
      sleep 1
  else
    break
  fi
done

# if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
# if ! updates_aur=$(cower -u 2> /dev/null | wc -l); then
# if ! updates_aur=$(pikaur -Qua 2> /dev/null | wc -l); then
# if ! updates_aur=$(rua upgrade --printonly 2> /dev/null | wc -l); then
if ! updates_aur=$(trizen -Su --aur --quiet | grep -E "^.+\$" | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    echo "$updates"
else
    echo ""
fi

