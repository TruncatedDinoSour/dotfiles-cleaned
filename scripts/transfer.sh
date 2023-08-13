#!/usr/bin/env bash

FIREFOX_PROFILE='/home/ari/.mozilla/firefox/3s4h1qq0.default-release'

[ "$EUID" != 0 ] && exit 255

echo "[?] Are you sure that you want to update the dotfiles?"
read -rp "=== [ press enter to continue  ] ==="

rm -rf dotfiles list
mkdir -m 700 -p list
mkdir -p dotfiles{,/shells/bash,/suckless,/etc,/core,/editors,/fix}
chmod 700 -R dotfiles

from=(
    '/home/ari/.bashrc'
    '/home/ari/.profile'

    '/home/ari/.config'

    '/home/ari/Documents/dwm_bar.sh'
    '/home/ari/Suckless'

    '/home/ari/Media/Pictures/wallpaper.png'
    '/home/ari/.mailcap'
    '/home/ari/.mutt/muttrc'
    '/home/ari/.lynxrc'
    "$FIREFOX_PROFILE/chrome/userChrome.css"

    '/home/ari/.icons'

    '/home/ari/.vim'
    '/home/ari/.idlerc'

    '/home/ari/.xinitrc'
    '/etc/default/grub'
    '/usr/share/kbd/keymaps/i386/qwerty/custom_mapping.map.gz'
    '/home/ari/Documents/custom_mapping.map'
    '/etc/pacman.conf'

    '/home/ari/Documents/wpa_cli_fix/doc.tex'
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
    'dotfiles/etc'
    'dotfiles/etc'

    'dotfiles/icons'

    'dotfiles/editors/vim'
    'dotfiles/editors/idle'

    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'
    'dotfiles/core'

    'dotfiles/fix/wpa_cli_fix.tex'
    'dotfiles/fix/gentoo_new_kernel.md'
)

for i in "${!from[@]}"; do
    cp -rfv "${from[$i]}" "${to[$i]}"
    echo "${from[$i]} -> ${to[$i]}" >>list/location.list
done

cp ../hosts.xz dotfiles/core

find /root -type l -exec ls -lA {} + | tee list/root_symlinks.list

# cp /var/lib/portage/world list/package.list
yay -Qq >list/package.list

uname -r >list/kernel.release
# rc-update >list/openrc_services.sysvinit.list

# python3 -m jupyter nbextension list 2>/dev/null >list/jupyter_entensions.list
python3 -m pip list | awk '{ print $1 }' | tail -n +3 >list/pip_modules.list
npm list --location=global --depth=0 >list/npm.list

while read -r line; do
    baz info exist "$(echo "$line" | awk '{print $2}')" 2>&1
    echo
done <<<$(baz list 2>&1 | tail -n +2) >list/baz.list

rm -rfv dotfiles/config/asciinema \
    dotfiles/editors/vim/.vim/undodir \
    dotfiles/config/VSCodium \
    dotfiles/config/VirtualBox \
    dotfiles/config/transmission/dht.dat \
    dotfiles/config/dconf \
    dotfiles/config/netlify \
    dotfiles/config/transmission/resume \
    dotfiles/editors/vim/.vim/.netrwhist \
    dotfiles/editors/emacs/.emacs.d/.cache \
    dotfiles/editors/emacs/.emacs.d/.lsp-session-v1 \
    dotfiles/editors/emacs/.emacs.d/auto-save-list \
    dotfiles/editors/emacs/.emacs.d/elpa \
    dotfiles/editors/emacs/.emacs.d/recentf \
    dotfiles/config/chromium \
    dotfiles/config/SlippiOnline \
    dotfiles/config/mpv/watch_later

# cp scripts/clean_firefox_profile dotfiles/etc/firefox
# cd dotfiles/etc/firefox || exit 1
# ./clean_firefox_profile
# cd ../../.. || exit 2

# sed -i '/PHONE/d' dotfiles/config/arigram/config.py
sed -i '/signingkey/d; /email/d; /name/d; /\[user\]/d; /\[github\]/d; /user/d' dotfiles/config/git/config

chown -R ari:ari dotfiles list
