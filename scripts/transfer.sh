#!/bin/bash

if [[ "$USER" != "ari" ]];
then
    exit 255
fi

echo "[?] Are you sure that you want to update the dotfiles?"
read -p "=== [ press enter to continue  ] ===" _

rm -rf dotfiles list
mkdir -p list
mkdir -p dotfiles{,/bin,/shells/bash,/shells/zsh,/suckless,/etc,/custom,/programming/VScodium,/core,/linux,/portage,/qbittorrent,/editors/vim,/fix}


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

    '/home/ari/.config/VSCodium/User/snippets'

    '/home/ari/.xinitrc'
    '/home/ari/.xprofile'
    '/etc/bash_git'
    '/etc/default/grub'
    '/etc/hosts'
    '/etc/dracut.conf'
    '/etc/dracut.conf.d'
    '/etc/tlp.conf'
    '/etc/sudoers'
    '/etc/X11/xorg.conf.d/20-intel-graphics.conf'
    '/etc/rc.conf'
    '/etc/modprobe.d/kernel_unfreeze_rtw.conf'
    '/etc/conf.d'

    '/etc/portage'

    '/usr/src/linux/.config'

    '/etc/fish'

    '/usr/share/themes/mumble-dark.qbtheme'

    '/usr/local/src/yafetch'

    '/home/ari/Documents/wpa_cli_fix/doc.latex'
    '/home/ari/Documents/new_kernel_gentoo/doc.md'
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
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'

    'dotfiles/portage'

    'dotfiles/linux'

    'dotfiles/shells'

    'dotfiles/qbittorrent'

    'dotfiles/bin'

    'dotfiles/fix/wpa_cli_fix.latex'
    'dotfiles/fix/gentoo_new_kernel.md'
)


for i in "${!from[@]}";
do
    sudo cp -rfv "${from[$i]}" "${to[$i]}"
    echo "${to[$i]} -> ${from[$i]}" >> list/location.list
done


ls -lA /usr/local/src > list/src.list

find /usr/local/bin -type l -exec ls -lA {} +
ls -lA /usr/bin/xterm >> list/location.list

sudo find /root -type l -exec ls -lA {} + | tee list/root_symlinks.list

equery list '*' | grep -io '[a-z].*' > list/packagei_full.list
cp /var/lib/portage/world list/package.list

uname -r > list/kernel.release

sudo chown -R ari:ari dotfiles
rm -rfv dotfiles/editors/vim/.vim/undodir dotfiles/config/keepassxc dotfiles/config/VSCodium dotfiles/config/VirtualBox dotfiles/config/transmission/dht.dat dotfiles/config/dconf

