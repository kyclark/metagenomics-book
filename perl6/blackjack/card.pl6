#!/usr/bin/env perl6

use lib '.';
use Card;

for True, False -> $bool {
    my $card = Card.new(:suite('Diamonds'), :face('A'), :aces-high($bool));
    dd $card;
    put "value = ", $card.value;
    put ~$card;
}
