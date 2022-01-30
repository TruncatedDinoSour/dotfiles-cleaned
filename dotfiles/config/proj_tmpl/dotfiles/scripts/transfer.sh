#!/usr/bin/env bash

main() {
    if [[ $USER != "DOT_USERNAME" ]]; then
        exit 255
    fi


    echo "[?] Are you sure that you want to update the dotfiles?"
    read -p "=== [ press enter to continue  ] ==="


    rm -rf dotfiles
    mkdir -p dotfiles{,config}


    from=(
        "/home/DOT_USERNAME/.config"
    )

    to=(
        'dotfiles/config'
    )


    for i in "${!from[@]}"; do
        sudo cp -rfv "${from[$i]}" "${to[$i]}"
        echo "${from[$i]} -> ${to[$i]}" >>list/location.list
    done


    sudo chown -R DOT_USERNAME:DOT_USERNAME dotfiles
    rm -rfv dotfiles/config/asciinema dotfiles/editors/vim/.vim/undodir dotfiles/config/keepassxc dotfiles/config/VSCodium dotfiles/config/VirtualBox dotfiles/config/transmission/dht.dat dotfiles/config/dconf dotfiles/config/netlify dotfiles/config/transmission/resume dotfiles/editors/vim/.vim/.netrwhist
}
