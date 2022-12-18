#!/usr/bin/env bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/.config/scripts"

# TMUX config
source "$HOME/.config/shells/tmux/tmux.conf"

# Start TMUX
[ -z "$TMUX" ] &&
    command -v tmux >/dev/null &&
    [ "$TERM" != 'linux' ] &&
    [ "$TERM" != 'eterm-color' ] &&
    [ ! "$__BASH_TMUX_DISABLE" ] &&
    exec tmux -2 -l

# shellcheck disable=SC1090
for _t in conf pre env; do
    source "$HOME/.config/shells/bash/bash.$_t"
done

# Load baz
_baz_loader="$HOME/.local/share/baz/loader.sh"

# shellcheck disable=SC1090
[ ! -f "$_baz_loader" ] || source "$_baz_loader"
# sleep 1000

# Functions
source "$HOME/.config/shells/bash/bash.functions"

# Aliases
source "$HOME/.config/shells/bash/bash.aliases"

export dots="$HOME/Ari/coding/resources_/dots" \
    tdots="$HOME/Ari/coding/resources_/tdots" \
    overlay="$HOME/Ari/coding/resources_/overlay" \
    ntex="$HOME/Documents/notes/doc.tex" \
    npdf="$HOME/Documents/notes/doc.pdf" \
    ndir="$HOME/Documents/notes"

autorun || vecho 'Autorun failed'
