#!/bin/sh
# DEPENDENCIES: git, make, curl

# bdwmb
git clone https://github.com/TruncatedDinosour/bdwmb
cd bdwmb || exit 1
sudo make full
cd .. || exit 1
rm -rf bdwmb

# vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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

