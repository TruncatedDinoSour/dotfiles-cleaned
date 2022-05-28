#!/usr/bin/env sh

set -xe

GENERIC_FLAGS="-std=c++98 -Wall -Wextra -Wpedantic -Wshadow -Werror -pedantic -march=native -pipe -o ../PROJECT_NAME.elf main.cpp"

main() {
    CXX="${CXX:-clang++}"

    cd src

    if [ "$DEBUG" ]; then
        $CXX -g $GENERIC_FLAGS
    else
        $CXX -flto -Ofast -ffunction-sections -fdata-sections -s $GENERIC_FLAGS
        strip --strip-all --remove-section=.note --remove-section=.gnu.version --remove-section=.comment --strip-debug --strip-unneeded ../PROJECT_NAME.elf -o ../PROJECT_NAME.elf
    fi

    cd ..

    if [ "$1" = '-r' ]; then
        ./PROJECT_NAME.elf
    fi
}

main "$@"
