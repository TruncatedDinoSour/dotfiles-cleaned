#!/bin/sh

if [[ "$USER" != "ari" ]];
then
    exit -1
fi


echo "[?] Are you sure that you want to update the dotfiles?"
read -p "=== [ press enter to continue ] ===" x


rm -rfv dotfiles list
mkdir -p list
mkdir -p dotfiles{,/RCs,/editors/vim,/core,/bin,/etc}


from=(
    "/home/ari/.config"
    "/home/ari/.bashrc"
    "/home/ari/.icons"
    "/home/ari/.vim"
    "/home/ari/.vimrc"
    "/home/ari/.xinitrc"
    "/home/ari/Suckless"
    "/home/ari/.dwm"
    "/usr/src/fastfetch"
    "/usr/local/src/yafetch"
    "/usr/local/src/colours"
    "/usr/local/src/dunstest"
    "/etc/bash_git"
    "/etc/doas.conf"
    "/etc/paru.conf"
    "/etc/pacman.conf"
    "/etc/fish"
    "/etc/xdg/reflector/reflector.conf"
    "/etc/nanorc"
    "/home/ari/Ari/coding/resources_/dotfiles-cleaned/scripts"
    "/etc/sudoers"
    "/etc/mkinitcpio.conf"
    "/home/ari/.profile"
    "/etc/default/grub"
    "/usr/local/src/shot"
    "/home/ari/Pictures/wallpaper.png"
)
to=(
    "dotfiles/config"
    "dotfiles/RCs"
    "dotfiles/icons"
    "dotfiles/editors/vim"
    "dotfiles/editors/vim"
    "dotfiles/core"
    "dotfiles/suckless"
    "dotfiles/suckless"
    "dotfiles/bin"
    "dotfiles/bin"
    "dotfiles/bin"
    "dotfiles/bin"
    "dotfiles/core"
    "dotfiles/core"
    "dotfiles/core"
    "dotfiles/core"
    "dotfiles/fish"
    "dotfiles/core"
    "dotfiles/RCs"
    "dotfiles/scripts"
    "dotfiles/core"
    "dotfiles/core"
    "dotfiles/RCs"
    "dotfiles/core"
    "dotfiles/core"
    "dotfiles/core"
    "dotfiles/bin"
    "dotfiles/etc"
)


for i in "${!from[@]}";
do
    sudo cp -rfv "${from[$i]}" "${to[$i]}"
    echo "${to[$i]} -> ${from[$i]}" >> list/location.list
done

sudo chown -R ari:ari dotfiles
rm -rfv dotfiles/config/dconf dotfiles/editors/vim/.vim/undodir dotfiles/config/Code dotfiles/config/VSCodium dotfiles/config/chromium

paru -Q | grep -io "^\S*" > list/package.list
paru -Q > list/package_full.list
lsd --tree --depth=2 /usr/local/src > list/src.list

