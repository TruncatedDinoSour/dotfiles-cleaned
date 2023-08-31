#!/usr/bin/env sh

set -eux

main() {
    rm -rf -- dist

    python3 -m build --wheel
    python3 -m twine upload dist/*.whl
}

main "$@"
