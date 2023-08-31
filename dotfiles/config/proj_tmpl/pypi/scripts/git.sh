#!/usr/bin/env sh

set -xe

main() {
    tox

    git add -A
    git commit -sa
    git push -u origin "$(git rev-parse --abbrev-ref HEAD)"

    ./scripts/pypi.sh
}

main "$@"
