#!/bin/bash

if [[ "$USER" != "ari" ]];
then
    exit 255
fi

echo "[?] Are you sure that you want to update the dotfiles?"
read -p "=== [ press enter to continue  ] ===" _

rm -rf dotfiles list
mkdir -p list
mkdir -p dotfiles{,/bin,/shells/bash,/shells/zsh,/suckless,/etc,/custom,/programming/VScodium,/core,/linux,/portage,/qbittorrent,/editors/vim,/editors/nano}


from=(
    '/home/ari/.bashrc'
    '/home/ari/.profile'

    '/home/ari/.config'

    '/home/ari/.dwm'
    '/home/ari/Suckless'

    '/home/ari/.fehbg'
    '/home/ari/.gtkrc-2.0'
    '/home/ari/Pictures/wallpaper.png'

    '/home/ari/.icons'

    '/home/ari/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting'
    '/home/ari/.zshrc'
    '/home/ari/.zsh_userrc'

    '/home/ari/.scripts'

    '/home/ari/.vim'
    '/home/ari/.vimrc'
    '/etc/nanorc'

    '/home/ari/.config/VSCodium/User/snippets'

    '/home/ari/.xinitrc'
    '/home/ari/.xprofile'
    '/etc/bash_git'
    '/etc/default/grub'
    '/etc/hosts'
    '/etc/hosts.allow'
    '/etc/dracut.conf'
    '/etc/dracut.conf.d'
    '/etc/tlp.conf'
    '/etc/sudoers'

    '/etc/portage'

    '/usr/src/linux/.config'

    '/etc/fish'

    '/usr/share/themes/mumble-dark.qbtheme'

    '/usr/local/src/mfetch'
)

to=(
    'dotfiles/shells/bash'
    'dotfiles/shells/bash'

    'dotfiles/config'

    'dotfiles/suckless'
    'dotfiles/suckless'

    'dotfiles/etc'
    'dotfiles/etc'
    'dotfiles/etc'

    'dotfiles/icons'

    'dotfiles/shells/zsh'
    'dotfiles/shells/zsh'
    'dotfiles/shells/zsh'

    'dotfiles/custom'

    'dotfiles/editors/vim'
    'dotfiles/editors/vim'
    'dotfiles/editors/nano'

    'dotfiles/programming/VScodium'

    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'

    'dotfiles/portage'

    'dotfiles/linux'

    'dotfiles/shells'

    'dotfiles/qbittorrent'

    'dotfiles/bin'
)


for i in "${!from[@]}";
do
    sudo cp -rfv "${from[$i]}" "${to[$i]}"
    echo "${to[$i]} -> ${from[$i]}" >> list/location.list
done


sudo chown -R ari:ari dotfiles
rm -rfv dotfiles/editors/vim/.vim/undodir dotfiles/config/keepassxc dotfiles/config/VSCodium dotfiles/config/VirtualBox dotfiles/config/transmission/dht.dat dotfiles/config/dconf

