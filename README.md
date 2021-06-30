<p align="center">
<img src="https://user-images.githubusercontent.com/71613062/123562468-7acd1f80-d79e-11eb-9ca3-6ee2f67fc0c0.png" width="75%">
</p>
<h2 align="center"></h2>

<p align="center"><b>What Am I using right now?</b></p>
<pre>
OS:     Arch Linux
WM/DE:  DWM
SHELL:  Bash
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
A: <code>cd</code> into the root (/) of the dotfiles-cleaned repo and type <code>make food</code>
<br/><br/>

<b>
Q: Why is there ony one i3 screenshot when DWM has 2?
</b><br/>
A: Because I am not on i3 anymore and This is the most screenshot I have :)
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
<img src="https://user-images.githubusercontent.com/71613062/123900488-b3185d80-d958-11eb-91b5-66da27aeadf0.png">

<h3>DWM (Tiling)</h3>
<img src="https://user-images.githubusercontent.com/71613062/123900545-c4fa0080-d958-11eb-8883-4b6d53f8c608.png">

<h2 align="center"></h2>

<h3>i3 (Floating)</h3>
<img src="https://user-images.githubusercontent.com/71613062/123563488-70ae1f80-d7a4-11eb-8b10-affa3e4a2cdd.png">

<br/>


<h1 align="center"><b>Manual Installation (Arch Linux)</b></h1>

```sh
$ sh # you can also use bash or zsh, but I put this here just in case you use something like FISH
$ cd
$ git clone https://aur.archlinux.org/paru.git
$ cd paru
$ makepkg -si
$ cd
$ git clone https://github.com/TruncatedDinosour/dotfiles-cleaned
$ cd dotfiles-cleaned
$ paru -S --needed $(cat list/package.list)
```
after that look at the `list/location.list` file and manually move the files

<b>IMAGINE THAT <code>ari</code> IS YOUR USER<b/>


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
<li><a href="//user-images.githubusercontent.com/71613062/123563850-7ad11d80-d7a6-11eb-92dd-6ac0e3033188.png">Wallpaper</a></li>
</ul>
