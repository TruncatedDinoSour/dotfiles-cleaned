# Installation of my dotfiles in gentoo, #WIP

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

4. Add torbrowser
```bash
$ sudo eselect repository add 'torbrowser' 'git' 'https://github.com/MeisterP/torbrowser-overlay.git'
$ sudo eselect repository enable torbrowser
```

5. Sync portage
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
$ sudo mv portage /etc/portage
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

