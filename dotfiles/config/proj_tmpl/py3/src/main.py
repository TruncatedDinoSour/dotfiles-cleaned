#!/usr/bin/env python3
"""PROJECT_TITLE"""

import sys
import warnings

warnings.filterwarnings("error", category=Warning)


def main() -> int:
    """Entry/main function"""

    return 0


if __name__ == "__main__":
    assert main.__annotations__.get("return") is int, "main() should return an integer"
    sys.exit(main())
