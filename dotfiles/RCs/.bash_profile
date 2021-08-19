#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export MAKEOPTS='-j4 -l4'
export ENV="$HOME/.profile"
export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts"
export EDITOR='vim'
export BROWSER='firefox'
export TERMINAL='st'

# NNN
export NNN_TRASH=1
export NNN_LOCKER='cmatrix'

