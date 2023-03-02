#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""PROJECT_TITLE"""

from warnings import filterwarnings as filter_warnings


def main() -> int:
    """entry/main function"""

    return 0


if __name__ == "__main__":
    assert main.__annotations__.get("return") is int, "main() should return an integer"

    filter_warnings("error", category=Warning)
    raise SystemExit(main())
