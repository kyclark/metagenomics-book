#!/usr/bin/env python3

import random

secret = random.randint(1,101)
print("The secret number is %s" % secret)

while True:
    while True:
        try:
            guess = int(input("Please enter a number: "))
            break
        except ValueError:
            print("That was not a number")

    print("You guessed %s" % guess)

    if guess == secret:
        print("You win!")
        break
    elif guess < secret:
        print("Too low.")
    else:
        print("Too high.")
