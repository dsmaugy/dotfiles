#!/bin/bash

display=$1
wallpaper=$2

if [[ "$display" == *"HDMI"* ]]; then
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
ags request reload-colors

cp /home/darwin/.cache/wal/mako /home/darwin/.config/mako/colors
makoctl reload

# sleep 1
# if [[ $(hyprctl activewindow -j | jq '.fullscreen') == "2" ]]; then
#   hyprctl dispatch fullscreen 2
#   hyprctl dispatch fullscreen 2
# fi
