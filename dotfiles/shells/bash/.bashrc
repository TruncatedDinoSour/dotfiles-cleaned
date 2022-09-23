#!/usr/bin/env bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.config/scripts"

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
    exec tmux -2 -l
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

export dots="$HOME/Ari/coding/resources_/dots"
export tdots="$HOME/Ari/coding/resources_/tdots"
export overlay="$HOME/Ari/coding/resources_/overlay"
export ntex="$HOME/Documents/notes/doc.tex"
export npdf="$HOME/Documents/notes/doc.pdf"
export ndir="$HOME/Documents/notes"

autorun || vecho 'Autorun failed'
