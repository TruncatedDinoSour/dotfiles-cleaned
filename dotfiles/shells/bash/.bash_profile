#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export ENV="$HOME/.profile"
export EDITOR='/usr/bin/vim'
export VISUAL="$EDITOR"
export BROWSER='/usr/bin/firefox'
export TERMINAL='/usr/local/bin/st'
export XZ_OPT=-e9T0

# NNN
export NNN_TRASH=1
export NNN_LOCKER='cmatrix'

# FZF
export FZF_DEFAULT_OPTS="--layout=reverse --height=20 --no-mouse -i"
export FZF_TMUX_HEIGHT=20

