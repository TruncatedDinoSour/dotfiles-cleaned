#!/bin/bash

if [[ "$USER" != "ari" ]];
then
    exit 255
fi

echo "[?] Are you sure that you want to update the dotfiles?"
read -p "=== [ press enter to continue  ] ===" _

rm -rf dotfiles list
mkdir -p list
mkdir -p dotfiles{,/bin,/shells/bash,/shells/zsh,/suckless,/etc,/custom,/programming/VScodium,/core,/qbittorrent,/editors/vim,/editors/nano,/fix}


from=(
    '/home/ari/.bashrc'
    '/home/ari/.profile'

    '/home/ari/.config'

    '/home/ari/.dwm'
    '/home/ari/Suckless'

    '/home/ari/.fehbg'
    '/home/ari/.gtkrc-2.0'
    '/home/ari/.jupyter'

    '/home/ari/.icons'

    '/home/ari/.oh-my-zsh'
    '/home/ari/.zsh_userrc'
    '/home/ari/.zshrc'

    '/home/ari/.scripts'

    '/home/ari/.vim'
    '/home/ari/.vimrc'
    '/etc/nanorc'

    '/home/ari/.config/VSCodium/User/snippets'
    '/home/ari/.config/VSCodium/product.json'

    '/home/ari/.xinitrc'
    '/home/ari/.xprofile'
    '/etc/bash_git'
    '/etc/default/grub'
    '/etc/hosts'
    '/etc/mkinitcpio.conf'
    '/etc/modprobe.d'
    '/etc/pacman.conf'
    '/etc/pam.d'
    '/etc/sudoers'
    '/etc/tlp.conf'
    '/etc/xdg/reflector'
    '/etc/X11/xorg.conf.d'
    '/etc/paru.conf'

    '/usr/local/src'

    '/usr/share/themes/mumble-dark.qbtheme'

    '/home/ari/Documents/wpa_cli_fix/doc.tex'
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
    'dotfiles/core'

    'dotfiles/bin'

    'dotfiles/qbittorrent'

    'dotfiles/fix'
)


for i in "${!from[@]}";
do
    sudo cp -rfv "${from[$i]}" "${to[$i]}"
    echo "${to[$i]} -> ${from[$i]}" >> list/location.list
done


sudo find /root -type l -exec ls -lA {} + | tee list/root_symlinks.list

pikaur -Q | awk '{ print $1 }' > list/package_full.list
pikaur -Qe | awk '{ print $1 }' > list/package.list

uname -r > list/kernel.release
systemctl list-unit-files --state=enabled > list/systemd_services.list

python3 -m jupyter nbextension list 2>/dev/null > list/jupyter_entensions.list
python3 -m pip list | awk '{ print $1 }' | tail -n +3 > list/pip_modules.list


sudo chown -R ari:ari dotfiles
rm -rfv dotfiles/config/asciinema dotfiles/editors/vim/.vim/undodir dotfiles/config/keepassxc dotfiles/config/VSCodium dotfiles/config/VirtualBox dotfiles/config/transmission/dht.dat dotfiles/config/dconf

sed -i '/PHONE/d' dotfiles/config/tg/conf.py

