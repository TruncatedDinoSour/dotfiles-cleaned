#!/bin/sh
# DEPENDENCIES: git, make, curl

# bdwmb
git clone https://github.com/TruncatedDinosour/bdwmb
cd bdwmb
make full
cd ..
rm -rf bdwmb

# vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

