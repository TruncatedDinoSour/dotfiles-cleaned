#!/usr/bin/env sh

set -xe

GENERIC_FLAGS="$CFLAGS -std=c99 -Wall -Wextra -Wpedantic -Wshadow -Werror -pedantic -march=native -mtune=native -pipe -o dfetch src/main.c"

main() {
    case "$1" in
    -i) install -Dm 700 ./dfetch "$HOME/.local/bin" ;;
    -u) rm -f -- "$HOME/.local/bin/dfetch" ;;
    *) nx=1 ;;
    esac

    [ "$nx" ] || return 0

    CC="${CC:-clang}"

    if [ "$DEBUG" ]; then
        $CC -g $GENERIC_FLAGS
    else
        $CC -flto -Ofast -ffunction-sections -fdata-sections -ffast-math -mfancy-math-387 -fno-ident -fmerge-all-constants -fno-unroll-loops -fno-math-errno -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -s $GENERIC_FLAGS
        llvm-strip $STRIPFLAGS --strip-all --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.note.gnu.gold-version --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.note --remove-section=.gnu.version --remove-section=.comment --strip-debug --strip-unneeded dfetch
    fi

    if [ "$1" = '-r' ]; then
        ./dfetch
    fi
}

main "$@"
