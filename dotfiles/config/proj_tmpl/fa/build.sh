#!/usr/bin/env sh

set -xe

main() {
    mkdir -p -- symbols
    fac main.fa -o main -dbg symbols/main.fas -asm-flags -m,1000000,-p,10000 -run
}

main "$@"
