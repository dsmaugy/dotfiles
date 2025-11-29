#!/bin/sh

# Get focused window name in Hyprland
window_name=$(hyprctl activewindow -j | jq -r '.title // "Game"')

# Sanitize
window_name=$(printf "%s" "$window_name" | tr '/\\' '_')

video_dir="/home/darwin/Videos/Replays/$window_name"
mkdir -p "$video_dir"

video="$video_dir/${window_name}_$(date +'%Y-%m-%d_%H-%M-%S').mp4"

mv "$1" "$video"
sleep 0.5 && notify-send -t 6000 "GPU Screen Recorder" "Replay saved to $video"
