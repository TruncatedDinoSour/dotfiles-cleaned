#!/bin/sh
# DEPENDENCIES: git, make, curl

# bdwmb
# git clone https://github.com/TruncatedDinosour/bdwmb
# cd bdwmb || exit 1
# sudo make full
# cd .. || exit 1
# rm -rf bdwmb
# Ebuild in ::dinolay - https://ari-web.netlify.app/gentooatom/x11-misc/bdwmb

# vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# gef
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

# Themes and icons
# git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk
# cd gruvbox-material-gtk || exit 1
# sudo mkdir /usr/share/themes
# sudo mkdir /usr/share/icons
# sudo mv themes/Gruvbox-Material-Dark /usr/share/themes
# sudo mv icons/Gruvbox-Material-Dark /usr/share/icons
# cd .. || exit 1
# rm -rf gruvbox-material-gtk
# Use the dinolay or TheGreatMcPain-overlay overlays

