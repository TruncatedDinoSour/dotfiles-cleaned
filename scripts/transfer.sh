#!/bin/sh

if [[ "$USER" != "ari" ]];
then
    exit -1
fi


echo "[?] Are you sure that you want to update the dotfiles?"
read -p "=== [ press enter to continue ] ===" x


rm -rfv dotfiles list
mkdir -p list
mkdir -p dotfiles{,/RCs,/editors/vim,/core,/bin}


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
    "/usr/src/yafetch"
    "/usr/src/colours"
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
)


for i in "${!from[@]}";
do
    sudo cp -rfv "${from[$i]}" "${to[$i]}"
done

sudo chown -R ari:ari dotfiles
rm -rfv dotfiles/editors/vim/.vim/undodir dotfiles/config/Code dotfiles/config/VSCodium

paru -Q > list/package.list
lsd --tree --depth=2 /usr/src > list/src.list

