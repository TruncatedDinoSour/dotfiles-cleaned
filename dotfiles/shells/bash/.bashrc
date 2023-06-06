#!/usr/bin/env bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/.config/scripts"

# TMUX config
. "$HOME/.config/shells/tmux/tmux.conf"

# Start TMUX
[ -z "$TMUX" ] &&
    [ "$DISPLAY" ] &&
    command -v tmux >/dev/null &&
    exec tmux -2 -l

. "$HOME/.config/shells/bash/bash.conf"
. "$HOME/.config/shells/bash/bash.env"

# Load baz
_baz_loader="$HOME/.local/share/baz/loader.sh"

# export BAZ_DEBUG_LOAD=1
# shellcheck disable=SC1090
[ -f "$_baz_loader" ] && . "$_baz_loader"
# sleep 1000

# Functions
. "$HOME/.config/shells/bash/bash.functions"

# Aliases
. "$HOME/.config/shells/bash/bash.aliases"

export dots="$HOME/Ari/coding/resources_/dots" \
    tdots="$HOME/Ari/coding/resources_/tdots" \
    overlay="$HOME/Ari/coding/resources_/overlay" \
    ntex="$HOME/Documents/notes/doc.tex" \
    npdf="$HOME/Documents/notes/doc.pdf" \
    ndir="$HOME/Documents/notes"

autorun
