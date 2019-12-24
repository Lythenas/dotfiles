#!/usr/bin/env sh

B='#00000000'  # blank
C='#f8f8f8FF'  # clear ish
D='#7cafc2FF'  # default
T='#7cafc2FF'  # text
W='#ab4642FF'  # wrong
V='#f7ca88FF'  # verifying

i3lock \
  --insidevercolor=$C \
  --ringvercolor=$V \
  \
  --insidewrongcolor=$C \
  --ringwrongcolor=$W \
  \
  --insidecolor=$B \
  --ringcolor=$D \
  --linecolor=$B \
  --separatorcolor=$D \
  \
  --color=282828 \
  --verifcolor=$T \
  --wrongcolor=$T \
  --timecolor=$T \
  --datecolor=$T \
  --layoutcolor=$T \
  --keyhlcolor=$W \
  --bshlcolor=$W \
  \
  --time-font="Iosevka Nerd Font Mono" \
  --date-font="Iosevka Nerd Font Mono" \
  --layout-font="Iosevka Nerd Font Mono" \
  --verif-font="Iosevka Nerd Font Mono" \
  --wrong-font="Iosevka Nerd Font Mono" \
  \
  --radius=120 \
  --ring-width=10 \
  \
  --screen=1 \
  --clock \
  --indicator \
  --timestr="%H:%M:%S" \
  --datestr="%Y-%m-%d" \
  --ignore-empty-password \
  --pass-media-keys \


