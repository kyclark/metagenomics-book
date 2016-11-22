#!/usr/bin/env perl6

use Test;

use lib '.';
use Blackjack;

my $deck1 = Deck.new(:num-decks(1));
is $deck1.cards.elems, 52, '52 cards (1 deck)';
my @cards1 = $deck1.cards.grab(2);
is @cards1.elems, 2, 'Grabbed 2 cards';
is $deck1.cards.elems, 50, 'Now there are 50 cards';

my $deck2 = Deck.new(:num-decks(4));
is $deck2.cards.elems, 208, '208 cards (4 decks)';
my @cards2 = $deck2.cards.grab(2);
is @cards2.elems, 2, 'Grabbed 2 cards';
is $deck2.cards.elems, 206, 'Now there are 206 cards';
