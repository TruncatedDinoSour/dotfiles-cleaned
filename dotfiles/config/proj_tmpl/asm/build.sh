#!/usr/bin/env sh

set -xe

main() {
    fasm src/main.asm PROJECT_NAME
}

main "$@"
