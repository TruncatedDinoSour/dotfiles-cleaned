## Changelog on 2021-10-21
- Dropped FISH support
```
Removed /etc/fish support for forever.
```
## Changelog on 2021-10-28
- Added firefox hardening support
```
Added /etc/firefox
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
