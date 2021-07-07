<p align="center">
<img src="https://user-images.githubusercontent.com/71613062/123562468-7acd1f80-d79e-11eb-9ca3-6ee2f67fc0c0.png" width="75%">
</p>
<h2 align="center"></h2>

<p align="center"><b>What Am I using right now?</b></p>
<pre>
OS:     Arch Linux
WM/DE:  DWM
SHELL:  Bash
THEME:  Gruvbox (cyan)
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
<img src="https://user-images.githubusercontent.com/71613062/124836703-f6835500-df72-11eb-808c-3d89fb3244b1.png">

<h3>DWM (Tiling)</h3>
<img src="https://user-images.githubusercontent.com/71613062/124836803-22063f80-df73-11eb-94bd-1c9ff521c901.png">

<h2 align="center"></h2>

<h3>i3 (Floating)</h3>
<img src="https://user-images.githubusercontent.com/71613062/123563488-70ae1f80-d7a4-11eb-8b10-affa3e4a2cdd.png">

<br/>


<h1 align="center"><b>Manual Installation (Arch Linux)</b></h1>
<p align="center"><b>IMAGINE THAT <code>ari</code> IS YOUR USER, IF IT IS NOT, CHANGE ALL CONFIGS TO BE TO YOUR USERNAME</b></p>

```sh
$ cd
$ sh
$ sudo pacman -S git
$ git clone https://aur.archlinux.org/paru.git
$ cd paru
$ makepkg -si
$ cd
$ rm -rfv paru
$ git clone https://github.com/TruncatedDinosour/dotfiles-cleaned
$ cd dotfiles-cleaned
$ rm -rfv scripts README.md Makefile LICENSE
$ paru -S --needed $(cat list/package.list)
$ sudo systemctl enable systemd-networkd.service
$ sudo systemctl enable fstrim.timer
$ sudo systemctl enable reflector.timer
$ sudo systemctl enable tlp.service
$ sudo systemctl enable gpm.service
$ sudo systemctl enable preload.service
$ cd dotfiles
$ sudo mv bin/* /usr/src
$ rm -rfv bin
$ mv config ~/.config
$ cd core
$ mv .xinitrc ~/.xinitrc
$ sudo mv bash_git /etc/bash_git
$ sudo mv mkinitcpio.conf /etc/mkinitcpio.conf
$ sudo mkinitcpio -P
$ sudo mv paru.conf /etc/paru.conf
$ sudo mv doas /etc/doas.conf
$ sudo mv pacman.conf /etc/pacman.conf
$ paru -Syyyu
$ sudo mv reflector.conf /etc/xdg/reflector.conf
$ sudo pacman -S reflector rsync
$ sudo reflector --age 10 --latest 35 --sort rate --save /etc/pacman.d/mirrorlist
$ cd ..
$ rm -rfv core
$ cd editors/vim
$ mv .vimrc ~/.vimrc
$ mv .vim ~/.vim
$ cd ../..
$ rm -rfv editors
$ sudo mv fish /etc/fish
$ mv icons ~/.icons
$ cd RCs
$ mv .bashrc ~/.bashrc
$ mv nanorc /etc/nanorc
$ cd ..
$ rm -rfv RCs
$ mv suckless ~/Suckless
$ cd
$ rm -rfv dotfiles-cleaned
$ cd Suckless
$ chmod a+rx ./compile
$ ./compile
$ cd
$ vim .vimrc
#    ;PlugInstall
#    ;q
#    ;wq
$ paru -S cmake python3 python3-pip
$ chmod a+rx ~/.vim/plugged/youcompleteme/install.py
$ ~/.vim/plugged/youcompleteme/install.py
$ cd
$ ln -s $HOME/.bashrc $HOME/.profile
$ echo $USER > a
$ su
$ h=$(/bin/cat a)
$ rm a
$ cd
$ ln -s /home/$h/.bashrc /root/.bashrc
$ ln -s /home/$h/.config /root/.config
$ ln -s /home/$h/.icons /root/.icons
$ ln -s /home/$h/.profile /root/.profile
$ ln -s /home/$h/.vim /root/.vim
$ ln -s /home/$h/.vimrc /root/.vimrc
$ exit
$ cd /usr/src
$ cd fastfetch
$ sudo mkdir -p build && \
  cd build && \
  sudo cmake .. && \
  sudo cmake --build .
$ sudo ln -s /usr/src/fastfetch/build/fastfetch /usr/local/bin/fastfetch
$ sudo ln -s /usr/src/fastfetch/build/flashfetch /usr/local/bin/flashfetch
$ cd /usr/src
$ cd yafetch
$ sudo make
$ sudo ln -s /usr/src/yafetch/yafetch /usr/local/bin/yafetch
$ cd /usr/src
$ sudo ln -s /usr/src/dunstest/dunstest /usr/local/bin/dunstest
$ sudo ln -s /usr/src/shot/shot /usr/local/bin/shot
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
<li><a href="//user-images.githubusercontent.com/71613062/124837065-ae186700-df73-11eb-88a5-ce82916d80c8.png">Wallpaper</a></li>
</ul>
