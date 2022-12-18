#!/usr/bin/env sh

set -xe

GENERIC_FLAGS="-std=c89 -Wall -Wextra -Wpedantic -Wshadow -Werror -pedantic -march=native -mtune=native -pipe -o ../PROJECT_NAME.elf main.c"

main() {
    CC="${CC:-clang}"

    cd src

    if [ "$DEBUG" ]; then
        $CC -g $GENERIC_FLAGS
    else
        $CC -flto -Ofast -ffunction-sections -fdata-sections -s $GENERIC_FLAGS
        strip --strip-all --remove-section=.note --remove-section=.gnu.version --remove-section=.comment --strip-debug --strip-unneeded ../PROJECT_NAME.elf -o ../PROJECT_NAME.elf
    fi

    cd ..

    if [ "$1" = '-r' ]; then
        ./PROJECT_NAME.elf
    fi
}

main "$@"
