#!/usr/bin/env python3
"""hello with to many"""

import sys
import os

def main():
    """main"""
    args = sys.argv

    if len(args) < 2:
        script = os.path.basename(args[0])
        print('Usage: {} NAME [NAME2 ...]'.format(script))
        sys.exit(1)

    print('Hello, {}!'.format(', '.join(args[1:])))

if __name__ == '__main__':
    main()
