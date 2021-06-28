#!/usr/bin/bash

# disabling GDM
sudo systemctl disable gdm

# removing gdm
sudo pacman -R gdm

# cleaning up (will run until nothing is found or until 5 times)
for _ in {1...5}
do
    sudo pacman -Rsn $(pacman -Qdtq)
done

# reinstallng xorg
sudo pacman -S --needed xorg

# installing lightdm
sudo pacman -S lightdm lightdm-gtk-greeter

# enabling lightdm
sudo systemctl enable lightdm
