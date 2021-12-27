## Changelog on 2021-10-21
- Dropped FISH support
```
Removed /etc/fish support for forever.
```
## Changelog on 2021-10-28
- Added firefox hardening support
``` Added /etc/firefox
```
- Made shbangs work with /usr/bin/env
```
Shbangs were put into env so they'd work no matter where the bin is
```
- Made vim buffers not spellcheck by default
```
Changed .vimrc to have no automatic buffer conversion to text
```
- Made DWM set env variables regarding the desktop session
```
See: setenv(3)
```
- Dropped ZSH support
```
I don't use it so I decided to drop it
```
## Changelog on 2021-10-29
- Added my firefox profile
```
Added my *whole (a cleanup script is ran so it wouldn't expose my cookies and stuff) firefox profile,
can be found in /etc/filefox
```
## Changelog on 2021-12-18
- Switched from GCC to CLANG in suckless
```
All suckless software is now compiled with clang
```
- Updated some installation steps
```
Now installation includes updated instructions
```
## Changelog on 2021-12-27
- Changed release naming
```
v[version]-[theme] -> v[version]-[theme]-[distro]
```
- Archived a bunch of stuff
```
- No i3 support
- Dropped nvim support
- Dropped alacritty
- Dropped i3blocks
...
```
