<p align="center">
<img src="https://user-images.githubusercontent.com/71613062/123562468-7acd1f80-d79e-11eb-9ca3-6ee2f67fc0c0.png" width="85%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Maintained-Yes-green?color=red&style=flat-square">
  <img src="https://img.shields.io/github/last-commit/TruncatedDinosour/dotfiles-cleaned?color=red&style=flat-square">
  <img src="https://img.shields.io/github/repo-size/TruncatedDinosour/dotfiles-cleaned?color=red&style=flat-square">
  <img src="https://img.shields.io/github/issues/TruncatedDinosour/dotfiles-cleaned?color=red&style=flat-square">
  <img src="https://img.shields.io/github/stars/TruncatedDinosour/dotfiles-cleaned?color=red&style=flat-square">
</p>

<h2 align="center"></h2>

<p align="center"><b>What Am I using right now?</b></p>
<pre>
OS:     Arch linux
WM/DE:  DWM
SHELL:  Bash
THEME:  coffee
</pre>

<p align="center"><b>What are the dependencies?</b></p>
<i>Arch Linux:</i>
<pre>
make
sh
python3
python-pip
</pre>

<h2 align="center"></h2>

<h1 align="center"><b>FAQ</b></h1>
<b>
Q: Are the windows floating by default?
</b><br/>
A: No
<br/><br/>

<b>
Q: How heavy is your system running?
</b><br/>
A: ~150-200MiBs of RAM and ~1% CPU usage on fresh boot
<br/><br/>

<b>
Q: What distro(-s) work best with the provided shellscript installer?
</b><br/>
A: Arch linux and Arch linux-based distrobutions
<br/><br/>

<b>
Q: How do I install the dotfiles?
</b><br/>
A: <code>cd</code> into the root (/) of the dotfiles-cleaned repo, check if the config is correct in scripts/install.sh and then type <code>make food</code>, but if you want a more reliable and controlled installation, read <a href="#manual-installation-arch-linux">this</a>
<br/><br/>

<b>
Q: Why is there ony one i3 screenshot when DWM has 2?
</b><br/>
A: Because I am not on i3 anymore and This is the most recent screenshot I have :)
<br/><br/>

<b>
Q: Why do some files only have some path to some file?
</b><br/>
A: Because it's a <a href="//www.howtogeek.com/287014/how-to-create-and-use-symbolic-links-aka-symlinks-on-linux/">symlink</a>
<br/><br/>

<b>
Q: Installer doesn't seem to work even though I am on an arch linux(-based) distrobution. what do I do?
</b><br/>
A: You may have set pacman as your package manager, But you actually need some our helper, like <a href="//aur.archlinux.org/packages/yay">yay</a>, or newer and more maintained <a href="//aur.archlinux.org/packages/paru">paru</a>
<br/><br/>

<br/>

<h1 align="center"><b>Look & Feel</b></h1>
<br/>
<h3>DWM (Floating)</h3>
<img src="https://user-images.githubusercontent.com/71613062/130159864-3e38e53d-f454-4b42-aced-e8765a5b6615.png">

<h3>DWM (Tiling)</h3>
<img src="https://user-images.githubusercontent.com/71613062/130159902-a983dd89-9046-4a42-9cec-0c246f3b971e.png">

<h2 align="center"></h2>

<h3>i3 (Floating)</h3>
<img src="https://user-images.githubusercontent.com/71613062/123563488-70ae1f80-d7a4-11eb-8b10-affa3e4a2cdd.png">

<br/>


<h1 align="center"><b>Manual Installation (Arch Linux)</b></h1>
<p align="center"><b>IMAGINE THAT <code>ari</code> IS YOUR USER, IF IT IS NOT, CHANGE ALL CONFIGS TO BE TO YOUR USERNAME</b></p>

## Back your data up!
```
Please back your data up before doing any of this,
this guide is only meant to be used on a base system and
if installed on a non-base system - it might break
```


## Preparing
```bash
$ cd
$ bash # You can use any POSIX complient shell, for example: ZSH, DASH, KSH
```


## Installing an AUR helper
```bash
$ cd
$ sudo pacman -S --needed base-devel git
$ git clone https://aur.archlinux.org/pikaur.git
$ cd pikaur
$ makepkg -fsri
$ cd ..
$ rm -rf pikaur
```


## Installing packages
### Updating the system
```bash
$ cd
$ sudo pacman -S --needed reflector
$ sudo reflector --age 10 --sort rate --latest 25 --save /etc/pacman.d/mirrorlist
$ pikaur -Syyu
```


### Installing the packages
1. Base
```bash
$ pikaur -S curl git make pango man-db nano sed cmake alsa alsa-utils reflector
```

2. Fonts
```bash
$ pikaur -S adobe-source-code-pro-fonts awesome-terminal-fonts cantarell-fonts gnu-free-fonts nerd-fonts-hack siji-git ttf-font-awesome
```

3. Themes & icons
```bash
$ pikaur -S gruvbox-dark-gtk gruvbox-material-icon-theme-git
```

4. Apps
```bash
$ pikaur -S feh firefox keepassxc kotatogram-desktop-bin lxappearance mpv thunderbird tor-browser vscodium-bin vscodium-bin-marketplace zathura zathura-pdf-poppler
```

5. Language support
```bash
$ pikaur -S lua51 python3 python-pip
```

6. Extra support for languages
```bash
$ pikaur -S bpython radian R openblas npm nodejs
```

6. Extra packages
```bash
$ pikaur -S bat duf-bin atool ffmpegthumbnailer libcaca lynx perl-image-exiftool python-chardet transmission-cli fzf gpm lsd ngrok-bin ranger texlive-most scrot tlp transmission-cli vim xautolock xclip
```

7. Display server
```bash
$ pikaur -S xorg xorg-xinit
```

8. Compiling from source
```bash
$ pikaur -S dunst-git preload
```

9. Libs for DWM
```bash
$ pikaur -S imlib2 libxinerama libxft
```

10. Packages from pypi
```bash
$ python3 -m pip install trash-cli
```


## Services
```bash
$ sudo systemctl enable fstrim.timer
$ sudo systemctl enable reflector.timer
$ sudo systemctl enable tlp.service
$ sudo systemctl enable gpm.service
$ sudo systemctl enable preload.service
```


## Installing dotfiles
### Cloning the repository
```bash
$ git clone https://github.com/TruncatedDinosour/dotfiles-cleaned
$ cd dotfiles-cleaned
```

### Cleaning up
```bash
$ rm -rfv README.md Makefile LICENSE .gitignore list scripts
$ cd dotfiles
```

### Installing single configuration files
```bash
$ cd RCs
$ rm -rfv ~/.bash_profile ~/.bashrc
$ sudo rm -rf /etc/nanorc
$ mv .bash_profile ~
$ mv .bashrc ~
$ ln -s /home/$USER/.bashrc /home/$USER/.profile
$ sudo mv nanorc /etc/nanorc
$ cd ..
$ rm -rfv RCs
```

### Source files
```bash
$ sudo mv bin/* /usr/local/src
$ rm -rfv bin
```

### Configs
```bash
$ rm -rfv ~/.config
$ mv config ~/.config
```

### Core files
```bash
$ cd core
```

* I will leave this step up to you what to use or not to use, here's a map where they're supposed to go
```bash
.xinitrc = ~/.xinitrc
.xprofile = ~/.xprofile
bash_git = /etc/bash_git
grub = /etc/default/grub
hosts = /etc/hosts
mkinitcpio.conf = /etc/mkinitcpio.conf
pacman.conf = /etc/pacman.conf
paru.conf = /etc/paru.conf
reflector.conf = /etc/xdg/reflector/reflector.conf
sc-im.desktop = /usr/share/applications/sc-im.desktop
st.desktop = /usr/share/applications/st.desktop
sudoers = /etc/sudoers
sysctl.conf = /etc/sysctl.conf
```

* I'd suggest using all of them except for:
  * sudoers (make your own, make it that /bin/xbacklight can run as root with no password)
  * mkinitcpio.conf (load your own gpu-specific modules)
  * hosts [if you want to use it, edit it]
  * grub (your encrypted home partition might not have the same UUID as mine) [if you want to use it, edit it]


### Cleanup
```bash
$ cd ..
$ rm -rfv core
```


### Custom
```bash
$ cd custom
```

#### Scripts
```bash
$ rm -rfv ~/.scripts
$ mv .scripts ~
$ chmod a+rx ~/.scripts/*
```

#### cleanup
```bash
$ cd ..
$ rm -rfv custom
```


### Editors
```bash
$ cd editors
```

#### ViM
```bash
$ rm -rf ~/.vim*
$ mv vim/.* ~
$ rm -rfv vim
```

#### Cleanup
```bash
$ cd ..
$ rm -rfv editors
```


### Etc.
```bash
$ cd etc
```

#### Wallpaper
```bash
$ mkdir -p ~/Pictures
$ mv wallpaper.png ~/Pictures
```

#### Cleanup
```bash
$ cd ..
$ rm -rfv etc
```


## Icons
```bash
$ rm -rfv ~/.icons
$ mv icons ~/.icons
```


## Qbittorrent
```bash
$ cd qbittorrent
```

### Themes
```bash
$ sudo mkdir /usr/share/themes
$ sudo mv mumble-dark.qbtheme /usr/share/themes
```

### Cleanup
```bash
$ cd ..
$ rm -rf qbittorrent
```


## Suckless
```bash
$ rm -rfv ~/Suckless
$ mv suckless ~/Suckless
```


## ZSH
```bash
$ cd zsh
```

### RCs
```bash
$ rm -rf ./.zsh*
$ mv ./.zsh* ~
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ rm -rf ~/.oh-my-zsh/plugins
$ mv plugins ~/.oh-my-zsh/plugins
```

### Cleanup
```bash
$ cd ..
$ rm -rf zsh
```


## Scripts
```bash
$ cd scripts
$ chmod a+rx ./*
```

* Now select what scripts you want to run, my recomendations:
  * alsa-restrore.sh
  * debloatify-xorg.arch.sh
  * fix_bpython.sh


## Clean up
```bash
$ cd
$ rm -rf dotfiles-cleaned
```


## Suckless
```bash
$ cd Suckless
$ chmod a+rx ./compile
$ ./compile
$ cd
```


## Compiling apps manually
```bash
$ cd /usr/local/src
```

### Fastfetch
```bash
$ cd fastfetch
$ sudo chmod a+rx ./run.sh
$ sudo ./run.sh
$ sudo ln -s /usr/local/src/fastfetch/build/fastfetch /usr/local/bin/fastfetch
$ sudo ln -s /usr/local/src/fastfetch/build/flashfetch /usr/local/bin/flashfetch
$ cd /usr/local/src
```

### Yafetch
```bash
$ cd yafetch
$ sudo make
$ sudo ln -s /usr/local/src/yafetch/yafetch /usr/local/bin/yafetch
$ cd
```


## Root symlinks
```bash
# REMEMBER: YOUR USERNAME IS SUPPOSED TO BR ARI, IF NOT, CHANGE ALL CONFIGS AND COMMANDS TO BE YOUR USERNAME
$ sudo su -
$ cd
$ function l() { rm -rfv "/root/$1"; ln -s "/home/ari/$1" "/root/$1"; }
$ l .icons
$ l .zsh_userrc
$ l .nvim
$ l .config
$ l .local
$ l .dwm
$ l .mozilla
$ l .zshrc
$ l .oh-my-zsh
$ l .vim
$ l .gitconfig
$ l .bashrc
$ l .vscode-oss
$ l .bash_profile
$ l .xinitrc
$ l .vimrc
$ l .scripts
$ l .profile
```


## Finalizing
```bash
$ grub-mkconfig -o /boot/grub/grub.cfg
$ mkinitcpio -P
$ reboot
$ startx
```

<br/>

<h1 align="center"><b>Resources</b></h1>
<ul>
<li><a href="//github.com/yrwq/yafetch">Yafetch - "Yet another fetch ..."</a></li>
<li><a href="//github.com/htop-dev/htop">Htop - "htop - an interactive process viewer"</a></li>
<li><a href="//github.com/LinusDierheimer/fastfetch">Fastfetch - "Like neofetch, but much faster because written in c. Only Linux."</a></li>
<li><a href="//github.com/abishekvashok/cmatrix">Cmatrix - "Terminal based "The Matrix" like implementation"</a></li>
<li><a href="//github.com/morganamilo/paru">Paru - "Feature packed AUR helper"</a></li>
<li><a href="//github.com/gilbertw1/telegram-gruvbox-theme">Telegram-gruvbox-theme - "Gruvbox theme for Telegram Desktop"</a></li>
<li><a href="//github.com/kotatogram/kotatogram-desktop">Kotatogram-desktop - "Experimental Telegram Desktop fork."</a></li>
<li><a href="//suckless.org">Suckless's website</a></li>
<li><a href="//github.com/TruncatedDinosour/dotfiles-cleaned/blob/master/dotfiles/etc/wallpaper.png">Wallpaper</a></li>
</ul>
