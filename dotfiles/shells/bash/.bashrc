#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

dots='/home/ari/Ari/coding/resources_/dots'
notes='/home/ari/Ari/coding/resources_/NOTES.txt'

autorun

