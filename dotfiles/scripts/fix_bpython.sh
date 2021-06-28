#!/usr/bin/bash

aur_install="paru -S --needed"
python_install="python3.9 -m pip install"
python_remove="python3.9 -m pip uninstall"

$aur_install bpython pyxdg
$python_install pyxdg
$python_remove xdg
