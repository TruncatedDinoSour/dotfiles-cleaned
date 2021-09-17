#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/.scripts"

# Enable Vi(M) mode
set -o vi

# cd into a directory with only the name supplied
shopt -s autocd

source ~/.config/shells/bash/*.functions

export PROMPT_COMMAND='ps_one'

case "$TERM" in
    "bsd"|"linux") tty_autorun ;;
esac

source ~/.config/shells/bash/*.aliases

export dots='/home/ari/Ari/coding/resources_/dots'
export notes='/home/ari/Documents/notes/doc.tex'
export npdf='/home/ari/Documents/notes/doc.pdf'
export overlay='/home/ari/Ari/coding/resources_/dinolay'

autorun

