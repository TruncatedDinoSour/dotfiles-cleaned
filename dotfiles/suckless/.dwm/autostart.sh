#!/bin/sh

# this script autostarts on startup
# please be careful

# wallpaper
# dwm status
# locker

wallpaper="/home/ari/Pictures/wallpaper.png"

feh --bg-fill $wallpaper &
~/.dwm/dwm-bar/dwm_bar.sh 2>/dev/null &
xautolock -time 10 -locker /usr/local/bin/slock &

