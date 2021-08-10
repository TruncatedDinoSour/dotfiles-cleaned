#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


source ~/.config/shells/bash/*.functions

case "$TERM" in
    "bsd"|"linux") tty_autorun ;;
esac

source ~/.config/shells/bash/*.aliases

dots='/home/ari/Ari/coding/resources_/dots'
autorun

