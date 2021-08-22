#!/usr/bin/bash

# removing not needed packages
sudo pacman -R yelp gnome-calendar gnome-logs gnome-weather gnome-user-share gnome-user-docs gnome-system-monitor gnome-software gnome-remote-desktop gnome-photos gnome-maps gnome-getting-started-docs gnome-font-viewer gnome-documents gnome-contacts gnome-clocks gnome-characters gnome-boxes gnome-books gnome-backgrounds epiphany

# cleaning up (will run until nothing is found or until 5 times)
for _ in {1...5}
do
    sudo pacman -Rsn $(pacman -Qdtq)
done

# reinstalling fuse2
sudo pacman -S --needed fuse2
