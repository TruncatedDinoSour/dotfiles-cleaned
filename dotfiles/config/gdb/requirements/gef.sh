#!/usr/bin/env sh

set -xe

main() {
    pip install --user --break-system-packages --upgrade keystone-engine unicorn capstone ropper rpyc
}

main
