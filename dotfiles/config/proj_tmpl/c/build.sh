#!/usr/bin/env sh

set -xe

main() {
    cd src
    ${CC:-clang} -flto -Ofast -std=c99 -Wall -Wextra -Wpedantic -Wshadow -pedantic -ffunction-sections -fdata-sections -march=native -pipe -o ../PROJECT_NAME.elf main.c -s
    strip --strip-all --remove-section=.note --remove-section=.gnu.version --remove-section=.comment --strip-debug --strip-unneeded ../PROJECT_NAME.elf -o ../PROJECT_NAME.elf
    cd ..

    if [ "$1" = "-r" ]; then
        ./PROJECT_NAME.elf
    fi
}

main "$@"
