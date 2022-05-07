#!/usr/bin/env sh

set -xe

main() {
    pip install --user keystone-engine unicorn \
        capstone ropper
}

main "$@"
