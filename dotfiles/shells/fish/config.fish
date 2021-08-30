# Put system-wide fish configuration entries here
# or in .fish files in conf.d/
# Files in conf.d can be overridden by the user
# by files with the same name in $XDG_CONFIG_HOME/fish/conf.d

# This file is run by all fish instances.
# To include configuration only for login shells, use
# if status is-login
#    ...
# end
# To include configuration only for interactive shells, use
# if status is-interactive
#   ...
# end

# variables
set sudo_command	"/usr/bin/sudo"
set cli_editor		"vim"
set aur_helper		"/usr/bin/paru"
set username		"ari"

# fish commands
alias edit-fish-aliases="$sudo_command $cli_editor /etc/fish/config.fish"
alias show-fish-aliases="/usr/bin/cat /etc/fish/config.fish | /usr/bin/grep \"^alias\""
alias show-fish-config="/usr/bin/cat /etc/fish/config.fish"

# long commands
alias grub-remake="$sudo_command /usr/bin/grub-mkconfig -o /boot/grub/grub.cfg"
alias grub-config="$sudo_command $cli_editor /etc/default/grub"
alias get-grub-config="/usr/bin/cat /etc/default/grub"

alias edit-reflector-config="$sudo_command $cli_editor /etc/xdg/reflector/reflector.conf"
alias show-reflector-config="/usr/bin/cat /etc/xdg/reflector/reflector.conf"

alias installed-pks="$aur_helper -Q"

alias ssh-enable="$sudo_command /usr/bin/systemctl enable sshd.service && $sudo_command /usr/bin/systemctl start sshd.service"
alias ssh-disable="$sudo_command /usr/bin/systemctl stop sshd.service && $sudo_command /usr/bin/systemctl disable sshd.service"

alias edit-vim-config="$sudo_command $cli_editor /etc/vimrc"
alias vimsync="/usr/bin/cp /etc/vimrc ~/.vimrc"

# utility commands
alias ew="reboot"
alias wq="shutdown now"

alias add="$aur_helper -S"
alias nay="$aur_helper -R"
alias bye="$aur_helper -Rns"
alias upt="$aur_helper && omf update"
alias cle="$aur_helper -Rns ($aur_helper -Qdtq) 2> /dev/null || true"
alias cuc="$aur_helper -Scc && $sudo_command /usr/bin/pacman -Scc"
alias swr="$sudo_command /usr/bin/swapoff -a && $sudo_command /usr/bin/swapon -a"
alias mrf="$sudo_command /usr/bin/reflector --age 10 --latest 50 --sort rate --save /etc/pacman.d/mirrorlist && $aur_helper -Syyu"
alias ers="/usr/bin/echo \"\" >"
alias esh="/usr/bin/echo \"\" > /home/$username/.ssh/known_hosts"
alias fld="/usr/bin/find / 2>/dev/null | /usr/bin/grep -i"
alias suc="/usr/bin/rm -rfv ~/.cache/*"

# command remapping (people might want to remove these)
alias ls="/usr/bin/lsd --color=auto"
alias cat="/usr/bin/bat --theme=gruvbox-dark"
alias clear="/usr/bin/clear && autorun"
alias grep="/usr/bin/grep --color=auto -i"
alias lsblk="/usr/bin/lsblk --all --fs"
alias less="/usr/bin/less --raw-control-chars"
if test "$TERM" = "linux"
    alias vim="vim --noplugin"
end

# custom comands (people might what to remove these)
alias glew="/usr/bin/python3 /home/$username/$username/coding/python_/glew/glew/__main__.py"

alias edit-i3-config="$cli_editor /home/$username/.config/i3/config"
alias edit-i3blocks-config="$cli_editor /home/$username/.config/i3blocks/i3blocks.conf"

# tools (people might what to remove these)
alias etcher="/usr/bin/chmod +x $username/coding/tools_/etcher-flash/balenaEtcher.AppImage && $sudo_command ~/$username/coding/tools_/etcher-flash/balenaEtcher.AppImage"
alias ngrok="/usr/bin/chmod +x /home/$username/$username/coding/tools_/ngrok_/ngrok && /home/$username/$username/coding/tools_/ngrok_/ngrok"

# env
export EDITOR="vim"
export BROWSER="firefox"

# autorun (people might what to remove these)
if type -q autorun
    autorun
else
    function autorun
    end
    funcsave autorun
end

