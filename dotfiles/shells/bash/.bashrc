#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/.config/scripts"

# config

source ~/.config/shells/bash/*.conf

# pre-run
source ~/.config/shells/bash/*.pre

# Environment
source ~/.config/shells/bash/*.env

# TMUX config
source ~/.config/shells/tmux/*.conf

# Check for TMUX
if [ -z "$TMUX" ] && [ "$TERM" != 'linux' ] && command -v tmux >/dev/null && [ ! "$__BASH_TMUX_DISABLE" ]; then
    tmux -2 -l
    exit 127
else
    vecho 'TMUX not started'
fi

# Load baz
_baz_loader="$HOME/.local/share/baz/loader.sh"
[ ! -f "$_baz_loader" ] || source "$_baz_loader"
# sleep 1000

# Functions
source ~/.config/shells/bash/*.functions

# Aliases
source ~/.config/shells/bash/*.aliases

# GPG
GPG_TTY="$(tty)"
export GPG_TTY

export dots='/home/ari/Ari/coding/resources_/dots'
export tdots='/home/ari/Ari/coding/resources_/tdots'
export overlay='/home/ari/Ari/coding/resources_/overlay'
export ntex='/home/ari/Documents/notes/doc.tex'
export npdf='/home/ari/Documents/notes/doc.pdf'
export ndir='/home/ari/Documents/notes'

# Enable luarocks
command -v luarocks >/dev/null && eval "$(luarocks path)"

autorun || vecho 'Autorun failed'
