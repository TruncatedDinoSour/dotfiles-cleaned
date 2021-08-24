#!/bin/bash

if [[ "$USER" != "ari" ]];
then
    exit 255
fi


echo "[?] Are you sure that you want to update the dotfiles?"
read -p "=== [ press enter to continue ] ===" _


rm -rfv dotfiles list
mkdir -p list
mkdir -p dotfiles{,/RCs,/editors/vim,/core,/bin,/etc,/qbittorrent,/zsh,/custom,/programming}


from=(
    "/home/ari/.config"
    "/home/ari/.bashrc"
    "/home/ari/.icons"
    "/home/ari/.vim"
    "/home/ari/.vimrc"
    "/home/ari/.xinitrc"
    "/home/ari/Suckless"
    "/home/ari/.dwm"
    "/usr/local/src/fastfetch"
    "/usr/local/src/yafetch"
    "/etc/bash_git"
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
    "/home/ari/Pictures/wallpaper.png"
    "/usr/share/themes/mumble-dark.qbtheme"
    "/usr/share/applications/st.desktop"
    "/home/ari/.zshrc"
    "/home/ari/.zsh_userrc"
    "/home/ari/.oh-my-zsh/custom/plugins"
    "/home/ari/.xprofile"
    "/home/ari/.bash_profile"
    "/home/ari/.scripts"
    "/etc/hosts"
    "/etc/sysctl.conf"
    "/usr/share/applications/sc-im.desktop"
    "/home/ari/.config/VSCodium/User/snippets"
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
    "dotfiles/etc"
    "dotfiles/qbittorrent"
    "dotfiles/core"
    "dotfiles/zsh"
    "dotfiles/zsh"
    "dotfiles/zsh"
    "dotfiles/core"
    "dotfiles/RCs"
    "dotfiles/custom"
    "dotfiles/core"
    "dotfiles/core"
    "dotfiles/core"
    "dotfiles/programming/VSCodium_snippets"
)


for i in "${!from[@]}";
do
    sudo cp -rfv "${from[$i]}" "${to[$i]}"
    echo "${to[$i]} -> ${from[$i]}" >> list/location.list
done

sudo chown -R ari:ari dotfiles
rm -rfv dotfiles/config/balena-etcher-electron dotfiles/config/qBittorrent dotfiles/config/VirtualBox dotfiles/config/dconf dotfiles/editors/vim/.vim/undodir dotfiles/config/Bitwarden dotfiles/config/Code dotfiles/config/VSCodium dotfiles/config/chromium

pikaur -Qe | grep -io "^\S*" > list/package.list
pikaur -Q | grep -io "^\S*" > list/package_full.list
lsd -la /usr/local/src > list/src.list
sudo find /root -type l | xargs -I {} sudo ls -lA '{}' > list/root_symlinks.list

