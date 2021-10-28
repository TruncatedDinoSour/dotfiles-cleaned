#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/.scripts"

# Disable stuff like ^S and ^Q
stty -ixon


# Functions
source ~/.config/shells/bash/*.functions

# Enable FZF support
if [[ -x "$(command -v fzf)" ]]; then
    source /usr/share/bash-completion/completions/fzf
    source /usr/share/fzf/key-bindings.bash
else
    vecho 'Please install FZF for FZF keybindings'
fi

source ~/.config/shells/bash/*.aliases


# Enable Vi(M) mode
set -o vi

# cd into a directory with only the name supplied
shopt -s autocd

# Enable extended globbing
shopt -s globstar
shopt -s extglob


export PROMPT_COMMAND='ps_one'

case "$TERM" in
    "bsd"|"linux") tty_autorun ;;
esac


export dots='/home/ari/Ari/coding/resources_/dots'
export overlay='/home/ari/Ari/coding/resources_/overlay'
export ntex='/home/ari/Documents/notes/doc.tex'
export npdf='/home/ari/Documents/notes/doc.pdf'
export ndir='/home/ari/Documents/notes'


# Keybinds
bind -f ~/.config/shells/bash/inputrc

for keymap in ~/.config/shells/bash/input/*; do
    vecho "Setting up readline keybinds for $keymap"
    bind -m "$(basename "$keymap")" -f "$keymap" || vecho "Failed to set bindings"
done 2>/dev/null


autorun || vecho 'Autorun failed'

