#!/usr/bin/env sh

userresources="$HOME/.config/Xresources"
usermodmap="$HOME/.config/.Xmodmap"
sysresources='/etc/X11/xinit/.Xresources'
sysmodmap='/etc/X11/xinit/.Xmodmap'

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.config/.xprofile ] && . "$HOME/.config/.xprofile"

# merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge "$sysresources"
[ -f $sysmodmap ] && xmodmap "$sysmodmap"
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for file in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$file" ] && . "$file"
    done

    unset file
fi

# Start the WM
exec dwm
