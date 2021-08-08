<p align="center">
<img src="https://user-images.githubusercontent.com/71613062/123562468-7acd1f80-d79e-11eb-9ca3-6ee2f67fc0c0.png" width="85%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Maintained-Yes-green?color=red&style=flat-square">
  <img src="https://img.shields.io/github/last-commit/TruncatedDinosour/dotfiles-cleaned?color=red&style=flat-square">
  <img src="https://img.shields.io/github/repo-size/TruncatedDinosour/dotfiles-cleaned?color=red&style=flat-square">
  <img src="https://img.shields.io/static/v1?label=License&message=GPLv3&color=red&style=flat-square">
  <img src="https://img.shields.io/github/issues/TruncatedDinosour/dotfiles-cleaned?color=red&style=flat-square">
  <img src="https://img.shields.io/github/stars/TruncatedDinosour/dotfiles-cleaned?color=red&style=flat-square">
  <img src="https://img.shields.io/github/forks/TruncatedDinosour/dotfiles-cleaned?color=red&style=flat-square">
</p>

<h2 align="center"></h2>

<p align="center"><b>What Am I using right now?</b></p>
<pre>
OS:     Arch linux
WM/DE:  DWM
SHELL:  Bash
THEME:  Light-ish???
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
<img src="https://user-images.githubusercontent.com/71613062/127733814-049d07ae-a159-4df3-a8d3-202276edd5c3.png">

<h3>DWM (Tiling)</h3>
<img src="https://user-images.githubusercontent.com/71613062/127733833-536b372b-37a7-4556-8dce-0b9d15b9d331.png">

<h2 align="center"></h2>

<h3>i3 (Floating)</h3>
<img src="https://user-images.githubusercontent.com/71613062/123563488-70ae1f80-d7a4-11eb-8b10-affa3e4a2cdd.png">

<br/>


<h1 align="center"><b>Manual Installation (Arch Linux)</b></h1>
<p align="center"><b>IMAGINE THAT <code>ari</code> IS YOUR USER, IF IT IS NOT, CHANGE ALL CONFIGS TO BE TO YOUR USERNAME</b></p>

## Perparing
```bash
$ cd
$ bash # or sh, zsh, ...
```

## Installing paru
```bash
$ sudo pacman -S base-devel git
$ git clone https://aur.archlinux.org/paru.git
$ cd paru
$ makepkg -si
$ cd
$ rm -rfv paru
```

## Packages
```bash
$ paru
$ paru -S curl git make pango man-db nano sed cmake # base
$ paru -S adobe-source-code-pro-fonts awesome-terminal-fonts cantarell-fonts gnu-free-fonts nerd-fonts-hack siji-git ttf-font-awesome # fonts
$ paru -S gruvbox-dark-gtk gruvbox-material-icon-theme-git # themes
$ paru -S firefox kotatogram-desktop-bin ksnip pcmanfm tor-browser vscodium-bin # apps
$ paru -S lua51 python3 python-pip # language support
$ paru -S mpv bash-completion bat bpython feh tlp gmp preload lsd lxappearance vim vscodium-bin-marketplace xautolock # extra apps
$ paru -S xorg xorg-xinit # X.org
$ paru -S dunst-git # apps from source
$ paru -S imlib2 libxinerama libxft # libs for DWM
```

**or (this will install all packages that \*I\* use on my system)**

```bash
$ paru -S --needed $(curl -fL 'https://raw.githubusercontent.com/TruncatedDinosour/dotfiles-cleaned/master/list/package.list')
```

## Services
```bash
$ sudo systemctl enable fstrim.timer
$ sudo systemctl enable reflector.timer
$ sudo systemctl enable tlp.service
$ sudo systemctl enable gpm.service
$ sudo systemctl enable preload.service
```

# Installing the dotfiles
**preparing**
```bash
$ cd
$ git clone https://github.com/TruncatedDinosour/dotfiles-cleaned
$ cd dotfiles-cleaned
$ rm -rfv scripts README.md Makefile LICENSE .gitignore list
$ cd dotfiles
```

**single RC files**
```bash
$ cd RCs
$ mv .bashrc ~/.bashrc
$ sudo mv nanorc /etc/nanorc
$ cd ..
$ rm -rf RCs
```

**building from source**
```bash
$ sudo mv bin/* /usr/local/src
$ cd /usr/local/src
$ ln -s /usr/local/src/colours/colours /usr/local/bin/colours
$ ln -s /usr/local/src/dusntest/dunstest /usr/local/bin/dunstest
$ cd fastfetch
$ ./run.sh
$ ln -s /usr/local/src/fastfetch/build/fastfetch /usr/local/bin/fastfetch
$ ln -s /usr/local/src/fastfetch/build/flashfetch /usr/local/bin/flashfetch
$ cd ..
$ ln -s /usr/local/src/seject/seject /usr/local/bin/seject
$ ln -s /usr/local/src/shot/shot /usr/local/bin/shot
$ cd yafetch
$ make
$ ln -s /usr/local/src/yafetch/yafetch /usr/local/bin/yafetch
$ cd ~/dotfiles-cleaned/dotfiles
$ rm -rf bin
```

**config**
```bash
$ mv config ~/.config
```

**safe core files**
```bash
$ sudo mv bash_git /etc
$ mv .xinitrc ~
$ sudo mv st.desktop /usr/share/applications
```

**unsafe/might need to do manually core files**
```bash
grub -> /etc/default/grub
mkinitcpio.conf -> /etc/mkinitcpio.conf
pacman.conf -> /etc/pacman.conf
paru.conf -> /etc/paru.conf
reflector.conf -> /etc/xdg/reflector/reflector.conf
sudoers -> /etc/sudoers
```
```
$ sudo mkinitcpio -P
$ sudo grub-mkconfig -o /boot/grub/grub.cfg
$ sudo pacman -Syu
$ paru
```

***finishing: remove the directory***
```bash
$ rm -rf core
```

**editors**
```bash
$ cd editors/vim
$ mv .vim ~
$ mv .vimrc ~
$ mkdir ~/.vim/undodir
$ cd ~/dotfiles-cleaned/dotfiles
$ rm -rf editors
```

**etc**
```bash
$ mkdir ~/Pictures
$ mv etc/wallpaper.png ~/Pictures
$ rm -rf etc
```

**fish (depricated)**
```bash
$ sudo mv fish /etc
```

**icons**
```bash
$ mv icons ~/.icons
```

**scripts**
```bash
$ cd scripts
$ cdmod a+rx ./*
```

after that, select the scripts you want, I suggest `debloatify-xorg.arch.sh`:

```bash
$ ./debloatify-xorg.arch.sh
```

**suckless**
```bash
$ mv suckless ~/Suckless
$ cd ~/Suckless
$ ./compile
```

**finishing up**
```bash
$ cd
$ rm -rf dotfiles-cleaned
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
