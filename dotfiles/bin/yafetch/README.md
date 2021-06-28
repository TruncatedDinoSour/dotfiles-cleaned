<p align="center"> <img src="http://0x0.st/-P91.png"> </p>

<h4 align="center">Yafetch is a minimal command line system information tool written in C and configured in Lua. </h4>

# Dependencies

- a linux distribution
- a compiler
- `lua5.1`

# Installation

```zsh
git clone https://github.com/yrwq/yafetch && cd yafetch
make
make config # optional (copies default config to $HOME/.config/yafetch)
sudo make install
```

# Usage

`yafetch` or `yafetch <config.lua>`

# Configuration

Yafetch is extensible in lua, the default location for the config is `~/.config/yafetch/init.lua`

See [docs](https://github.com/yrwq/yafetch/blob/main/docs.md).
