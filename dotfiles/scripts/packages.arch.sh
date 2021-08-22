#!/usr/bin/bash

aur_helper_install="paru -S --needed"
sudo_command="sudo"

echo 'installing python and pip'
sleep 2
$aur_helper_install python3 python-pip


echo 'installing important packages'
sleep 2
$aur_helper_install i3-gaps xorg i3lock-color i3blocks xorg-xinit rofi terminator thunar


echo 'installing extra packages'
sleep 2
$aur_helper_install autotiling-git picom ttf-font-awesome lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lxappearance fish git vim

echo 'installing vimplug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


echo 'installing fish'
sleep 2
chsh -s /usr/bin/fish
$sudo_command chsh -s /usr/bin/fish


echo 'enabling lightdm'
sleep 2
$sudo_command systemctl enable lightdm

echo 'Done!'
