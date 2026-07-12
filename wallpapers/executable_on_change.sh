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
# colors.conf is now read by hyprland.lua (no longer `source`d), so trigger a
# reload explicitly instead of relying on Hyprland's sourced-file auto-reload.
hyprctl reload >/dev/null 2>&1 || true

cp /home/darwin/.cache/wal/colors.scss /home/darwin/projects/grackle/_colors.scss
ags request reload-colors

cp /home/darwin/.cache/wal/mako /home/darwin/.config/mako/colors
makoctl reload

cp ~/.cache/wal/kvantum-pywal.kvconfig ~/.config/Kvantum/pywal/pywal.kvconfig
cp ~/.cache/wal/kvantum-pywal.svg ~/.config/Kvantum/pywal/pywal.svg

# sleep 1
# if [[ $(hyprctl activewindow -j | jq '.fullscreen') == "2" ]]; then
#   hyprctl dispatch fullscreen 2
#   hyprctl dispatch fullscreen 2
# fi
