#!/bin/bash

display=$1
wallpaper=$2

if [[ "$display" != "DP-1" ]]; then
  exit
fi

echo "Running pywal"
/home/darwin/.local/bin/wal -s -i "$wallpaper" --cols16 darken

cp /home/darwin/.cache/wal/ghostty.conf /home/darwin/.config/ghostty/themes
killall -SIGUSR2 ghostty

cp /home/darwin/.cache/wal/tmux-pywal.conf /home/darwin/.tmux.conf
tmux source-file /home/darwin/.tmux.conf

cp /home/darwin/.cache/wal/hyprland-pywal.conf /home/darwin/.config/hypr/colors.conf

cp /home/darwin/.cache/wal/colors.scss /home/darwin/projects/grackle/_colors.scss
ags quit
ags run /home/darwin/projects/grackle --gtk 4

makoctl reload
