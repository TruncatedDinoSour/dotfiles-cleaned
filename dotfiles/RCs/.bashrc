#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


source ~/.config/shells/bash/*.functions

case "$TERM" in
    "bsd"|"linux") tty_autorun ;;
esac


export MAKEOPTS='-j4 -l4'
export PROMPT_COMMAND='ps_one'
export ENV="$HOME/.profile"
export PATH="$PATH:$HOME/.local/bin"
export EDITOR='vim'
export BROWSER='firefox'

source ~/.config/shells/bash/*.aliases


dots='/home/ari/Ari/coding/resources_/dots'
autorun


