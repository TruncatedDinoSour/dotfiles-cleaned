#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /etc/bash_git


RESTORE='\033[0m'
GREEN='\033[00;32m'
RED='\033[00;31m'


autorun() {
    /usr/local/bin/yafetch
}


ps_one() {
    local c_status="$?"
    local git="$(__git_ps1 | sed 's/^ //g')"
    local venv="$(basename "$VIRTUAL_ENV")"
    local dir='\W'

    local propt_char='#'
    if [[ "$UID" != '0' ]]; then
        local propt_char='%'
    fi

    if [[ "$c_status" != '0' ]]; then
        local propt_colour="${RED}$c_status "
    fi

    if [[ "$git" ]]; then
        local dir="$git $dir"
    fi
    if [[ "$venv" ]]; then
        local extra="{${GREEN}$venv${RESTORE}} "
    fi


    export PS1="\n${extra}${GREEN}\u${RESTORE}@\h ${dir} ${propt_colour}${propt_char}${RESTORE} "
}


man() {
    # \E[...m = ANSI colour
    # \x1b[38;2;...;...;...m = RGB colours
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;36m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\x1b[38;2;128;128;128m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;36;146m' \
        man "$@"
    }

tty_autorun() {
    # TTY theme
    echo -en "\e]P0282828" #black
    echo -en "\e]P88F9494" #darkgrey
    echo -en "\e]P1AF5f5F" #darkred
    echo -en "\e]P9bb6868" #red
    echo -en "\e]P287875F" #darkgreen
    echo -en "\e]PA87875F" #green
    echo -en "\e]P3D7AF87" #brown
    echo -en "\e]PBbCBC6C" #yellow
    echo -en "\e]P4666C7F" #darkblue
    echo -en "\e]PC666C7F" #blue
    echo -en "\e]P5A1456E" #darkmagenta
    echo -en "\e]PDA1456E" #magenta
    echo -en "\e]P687875F" #darkcyan
    echo -en "\e]PE87875F" #cyan
    echo -en "\e]P7DDD0C0" #lightgrey
    echo -en "\e]PFDDD0C0" #white
    /bin/clear #for background artifacting
}


case "$TERM" in
    "bsd"|"linux") tty_autorun ;;
esac


export MAKEOPTS='-j4 -l4'

export PROMPT_COMMAND='ps_one'

export ENV="$HOME/.profile"
export PATH="$PATH:$HOME/.local/bin"

export EDITOR='vim'
export BROWSER='firefox'


alias ..='cd ..'

alias ls='/bin/lsd --color=auto -Fvh'
alias ll='ls -lFv'
alias la='ls -lFAv'

alias rm='trash-put'
alias rls='trash-list'
alias rrm='trash-empty'
alias rmk='trash-restore'

alias df='/bin/duf -hide special'
alias cat='/bin/bat --theme="gruvbox-dark"'

alias src='source ~/.bashrc'
alias stx='/bin/startx'

alias make="/bin/make ${MAKEOPTS}"
alias clear='/bin/clear; autorun'

alias grep='/bin/grep --color="auto" -i'
alias diff='/bin/diff --color=auto'

alias lsblk='/bin/lsblk -fa'
alias mv='/bin/mv -i'
alias cp='/bin/cp -i'
alias mkdir='/bin/mkdir -p'
alias curl='/bin/curl -fL'


dots='/home/ari/Ari/coding/resources_/dots'
autorun

