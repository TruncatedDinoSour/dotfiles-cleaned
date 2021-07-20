#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#[[ -f "$HOME/.bashrc" ]] && return

source /etc/bash_git


RESTORE='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'


autorun() {
    /usr/local/bin/yafetch
}

ps_one() {
    local status="$?"
    local git="$(__git_ps1 | sed "s/^ //g")"
    local date="$(date "+%H:%M:%S")"
    local extra=""

    local dir="${LBLUE}\\W${RESTORE}"
    if [[ "$git" ]];
    then
        local extra+=" -+- [ $dir ]"
        local dir="${LBLUE}$git${RESTORE}"
    fi

    local prompt="$"
    if [[ "$EUID" == 0 ]];
    then
        local prompt="${LRED}#${RESTORE}"
    fi

    local status_c="${GREEN}"
    if [[ "$status" -ne 0 ]];
    then
        local status_c="${LRED}"
    fi


    local PS1_P1="[ \\u${YELLOW}@${RESTORE}\\h ] -+- [ $date ] -+- [ ${status_c}$status${RESTORE} ]${extra}"
    local PS1_P2="[ $dir ]${prompt} "

    export PS1="\n$PS1_P1\n$PS1_P2"
}

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}


# gruvbox TTY theme, pattern: \e]P*[HEX CODE]
if [ "$TERM" == "linux" ]; then
    echo -en "\e]P0282828" #black
    echo -en "\e]P83C3C3C" #darkgrey
    echo -en "\e]P1CC241D" #darkred
    echo -en "\e]P9FB4934" #red
    echo -en "\e]P298971A" #darkgreen
    echo -en "\e]PA689D6A" #green
    echo -en "\e]P3D7AF87" #brown
    echo -en "\e]PBB8BB26" #yellow
    echo -en "\e]P4458588" #darkblue
    echo -en "\e]PC83A598" #blue
    echo -en "\e]P5B16286" #darkmagenta
    echo -en "\e]PDD3869B" #magenta
    echo -en "\e]P6458588" #darkcyan
    echo -en "\e]PE83A598" #cyan
    echo -en "\e]P7C0B087" #lightgrey
    echo -en "\e]PFEBDBB2" #white
    /bin/clear #for background artifacting
fi


alias ..='cd ..'
alias rm="trash-put"
alias ls='/bin/lsd --color=auto'
alias ll='/bin/lsd -l --color=auto'
alias la='/bin/lsd -la --color=auto'
alias rms='trash-empty'
alias rml='trash-list'
alias df='/bin/duf -hide special'
alias cat='/bin/bat --theme="gruvbox-dark"'
alias src='source ~/.bashrc'
alias stx='/bin/startx'
alias grep='/bin/grep --color="auto" -i'
alias glew="/home/ari/Ari/coding/python_/glew/glew/__main__.py"
alias clear='/bin/clear && autorun'
alias lsblk='/bin/lsblk -fa'
alias ngrok='/home/ari/Ari/coding/tools_/ngrok_/ngrok'

if [[ "${TERM,,}" == 'linux' ]];
then
    alias vim='vim --noplugin'
fi


export MAKEOPTS="-j4 -l4"
export LDFLAGS="-Wl,--gc-sections,-strip-all"
export CXXFLAGS="-Wall -Wextra -Wpedantic -ffunction-sections -fdata-sections -Wno-c++98-compat -O3 -s -g"
export CXX="g++"

alias make="/bin/make ${MAKEOPTS}"
alias cxx="$CXX ${CXXFLAGS}"

export ENV="$HOME/.profile"
export PATH="$PATH:$HOME/.local/bin"
export EDITOR='vim'
export PROMPT_COMMAND='ps_one'
export TORBROWSER_PKGLANG='en-US'

dots="/home/ari/Ari/coding/resources_/dots"
autorun

