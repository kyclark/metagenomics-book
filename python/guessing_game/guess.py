#!/usr/bin/env python3
"""guess the number game"""

import argparse
import random
import sys

# --------------------------------------------------
def get_args():
    """get args"""
    parser = argparse.ArgumentParser(description='Argparse Python script')
    parser.add_argument('-m', '--min', help='Minimum value',
                        metavar='int', type=int, default=1)
    parser.add_argument('-x', '--max', help='Maximum value',
                        metavar='int', type=int, default=50)
    parser.add_argument('-g', '--guesses', help='Number of guesses',
                        metavar='int', type=int, default=5)
    return parser.parse_args()

# --------------------------------------------------
def main():
    """main"""
    args = get_args()
    low = args.min
    high = args.max
    guesses_allowed = args.guesses

    secret = random.randint(low, high)
    num_guesses = 0
    prompt = 'Guess a number between {} and {}: '.format(low, high)

    while True:
        guess = input('[{}] {}'.format(num_guesses, prompt))
        num_guesses += 1

        if not guess.isdigit():
            print('"{}" is not a number'.format(guess))
            continue

        print('You guessed "{}"'.format(guess))
        num = int(guess)

        if num_guesses >= guesses_allowed:
            print('Too many guesses! The number was "{}."'.format(secret))
            sys.exit()
        elif num == secret:
            print('You win!')
            break
        elif num < secret:
            print('Too low.')
        else:
            print('Too high.')

# --------------------------------------------------
if __name__ == '__main__':
    main()
