# Installation of my dotfiles in gentoo (WORK IN PROGRESS)

**Before doing any of this - back everything up, this is not a 100% fool-proof method, this works on my machine, you might need to tweak some things like instead of username "ari" you might use "joe"**


## Clone the repository

1. Install git
```bash
$ sudo emerge -qa dev-vcs/git
```

2. Clone it
```bash
$ git clone https://github.com/TruncatedDinosour/dotfiles-cleaned
```

3. Enter it
```bash
$ cd dotfiles-cleaned
```




## Install the needed overlays

1. Back up your portage directory
```bash
$ mkdir ~/backups
$ cp -r /etc/portage ~/backups
```

2. Install eselect-repository
```bash
$ sudo emerge -qa app-eselect/eselect-repository
```

3. Add dinolay
```bash
$ sudo eselect repository add 'dinolay' 'git' 'https://github.com/TruncatedDinosour/dinolay.git'
$ sudo eselect repository enable dinolay
```
<!-- 
4. Add torbrowser
```bash
$ sudo eselect repository add 'torbrowser' 'git' 'https://github.com/MeisterP/torbrowser-overlay.git'
$ sudo eselect repository enable torbrowser
``` -->

4. Sync portage
```bash
$ sudo emerge --sync
```




## Installing the packages

1. Enter the dotfiles directory
```bash
$ cd dotfiles
```

2. Remove the old portage directory
```bash
$ sudo rm -r /etc/portage
```

3. Get the new one
```bash
$ sudo mv portage/portage /etc/portage
```

4. Sync portage
```bash
$ sudo emerge --sync
```

5. Move into the list directory
```bash
$ cd ../list
```

6. Install vim
```bash
$ sudo emerge app-editors/vim
```

7. Optionally edit the `package.list`
```bash
$ vim package.list
```

8. Install the packages
```bash
$ sudo emerge $(cat package.list)
```

9. Exit the directory
```bash
$ cd ..
```



# Enable some services
1. Enable `alsasound`
```bash
$ sudo rc-update add alsasound default
```



# Install tools
1. Make the `tools.sh` executable
```bash
$ chmod a+rx scripts/tools.sh
```

2. Run the provided script
```bash
$ ./scripts/tools.sh
```



# Dotfiles
1. Enter the dotfiles directory
```bash
$ cd dotfiles
```

2. Make the `/usr/local/src` directory
```bash
$ sudo mkdir /usr/local/src
```

3. Move some source files into it
```bash
$ sudo mv bin/* /usr/local/src
```

4. Go to the `/usr/local/src` directory
```bash
$ cd /usr/local/src
```

5. Install yafetch
```bash
$ cd yafetch
$ sudo make
$ sudo ln -s /usr/local/src/yafetch/yafetch /usr/local/bin/yafetch
```

6. Go back to dotfiles
```bash
$ cd ~/dotfiles-cleaned/dotfiles
```

7. Remove the old `~/.config`
```bash
$ rm -rf ~/.config
```

8. Get my config files
```basg
$ mv config ~/.config
```

9. Enter the `core` directory
```bash
$ cd core
```

10. Install safe core files
```bash
$ mv .xinitrc ~
$ mv .xprofile ~
$ sudo mv bash_git /etc
```

11. Install other core dotfiles
```
I will leave this step up to you, get whatever you want, but at this point you will probably need to edit everything.
If you don't know what goes where - see ../list/location.list
```

12. Get my scripts
```bash
$ mv custom/.scripts ~
```

13. Get my vim config
```bash
$ mv editors/vim/.vim ~
$ mv editors/vim/.vimrc ~
```

14. Make the `~/.pictures` directory
```bash
$ mkdir ~/Picrures
```

15. Get my wallpaper
```bash
$ mv etc/wallpaper.png ~/Pictures
```

16. Get my gtkrc
```bash
$ mv etc/.gtkrc-2.0 ~
```

17. Get the icons I use
```bash
$ rm -rf ~/.icons
$ mv icons ~/.icons
```

18. Get my linux config
```
My kernel config is very specific to my hardware (HP 250 G7 Notebook PC) - you might need to tweak the config.
```

19. Move the kernel config to the linux dir
```bash
$ mv linux/.config /usr/src/linux
```

20. Compile the kernel
```bash
$ cd /usr/src/linux
$ sudo make oldconfig
$ sudo make
$ sudo make modules_install
$ sudo make install
$ sudo dracut --force
$ sudo grub-mkconfig -o /boot/grub/grub.cfg
```

21. Get my suckless software builds
```bash
$ mv suckless/.dwm ~
$ mv suckless/Suckless ~
$ cd suckless/Suckless
$ chmod a+rx ./compile
$ ./compile
```

22. Done
```
The installation is done, now you can add the extra stuff that is left in the
directory if you feel like it and you could reboot.
```

