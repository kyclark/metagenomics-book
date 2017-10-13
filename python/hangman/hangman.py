#!/usr/bin/env python3

import argparse
import os
import random
import re
import sys

# --------------------------------------------------
def get_args():
    parser = argparse.ArgumentParser(description='Argparse Python script')
    parser.add_argument('-m', '--max', help='Max length',
                        type=int, default=8)
    parser.add_argument('-g', '--guesses', help='Max guesses',
                        type=int, default=10)
    parser.add_argument('-w', '--wordlist', help='Word list',
                        type=str, default='/usr/share/dict/words')
    return parser.parse_args()

# --------------------------------------------------
def main():
    args = get_args()
    max_len = args.max
    max_guesses = args.guesses
    wordlist = args.wordlist

    if not os.path.isfile(wordlist):
        print('--wordlist "{}" is not a file.'.format(wordlist))
        sys.exit(1)

    if not 3 <= max_len <= 20:
        print('--max length should be between 3 and 20')
        sys.exit(1)

    words = [w for w in open(wordlist).read().split() if len(w) <= max_len]
    word = random.choice(words)
    play({'word': word, 'max_guesses': max_guesses})

# --------------------------------------------------
def play(state):
    word = state.get('word') or ''

    if not word:
        print('No word!')
        sys.exit(1)

    guessed = state.get('guessed') or list('_' * len(word))
    prev_guesses = state.get('prev_guesses') or set()
    num_guesses = state.get('num_guesses') or 0
    max_guesses = state.get('max_guesses') or 0

    if ''.join(guessed) == word:
        print('You win!')
        sys.exit(0)

    if num_guesses >= max_guesses:
        print('You lose.  The word was "{}".'.format(word))
        sys.exit(0)

    print('{} (Guesses: {})'.format(' '.join(guessed), num_guesses))
    new_guess = input('Your guess? ')

    if not re.match('^[a-zA-Z]$', new_guess):
        print('Please guess on letter')
        play({'word': word, 'guessed': guessed})

    if new_guess in prev_guesses:
        print('You already guessed that')
    else:
        prev_guesses.add(new_guess)
        last_pos = 0
        while True:
            pos = word.find(new_guess, last_pos)
            if pos < 0:
                break
            elif pos >= 0:
                guessed[pos] = new_guess
                last_pos = pos + 1

    play({'word': word, 'guessed': guessed, 'num_guesses': num_guesses + 1,
          'prev_guesses': prev_guesses, 'max_guesses': max_guesses})

# --------------------------------------------------
if __name__ == '__main__':
    main()
