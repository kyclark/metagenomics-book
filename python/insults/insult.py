#!/usr/bin/env python3
"""Shakespearean insult generator"""

import sys
import random

ADJECTIVES = """
scurvy old filthy scurilous lascivious foolish rascaly gross rotten corrupt
foul loathsome irksome heedless unmannered whoreson cullionly false filthsome
toad-spotted caterwauling wall-eyed insatiate vile peevish infected
sodden-witted lecherous ruinous indistinguishable dishonest thin-faced
slanderous bankrupt base detestable rotten dishonest lubbery
""".split()

NOUNS = """
knave coward liar swine villain beggar slave scold jolthead whore barbermonger
fishmonger carbuncle fiend traitor block ape braggart jack milksop boy harpy
recreant degenerate Judas butt cur Satan ass coxcomb dandy gull minion
ratcatcher maw fool rogue lunatic varlet worm
""".split()

args = sys.argv[1:]
num = 5
if len(args) > 0 and args[0].isdigit():
    num = int(args[0]) 

for i in range(0, num):
    adjs = []
    for j in range(0, 3):
        adjs.append(random.choice(ADJECTIVES))

    print('You {} {}!'.format(', '.join(adjs), random.choice(NOUNS)))
