#!/usr/bin/env perl6

use Test;
use lib '.';
use Blackjack;

my $card1 = Card.new(:face('2'), :suite('Hearts'));
is $card1.face, '2', 'Face is 2';
is $card1.suite, 'Hearts', 'Suite is Heart';
is $card1.value, 2, 'Value is 2';

my $card2 = Card.new(face => 'J', suite => 'Diamonds');
is $card2.face, 'J', 'Face is Jack';
is $card2.suite, 'Diamonds', 'Suite is Diamond';
is $card2.value, 10, 'Value is 10';

my $card3 = Card.new(face => 'A', suite => 'Clubs');
is $card3.face, 'A', 'Face is Ace';
is $card3.suite, 'Clubs', 'Suite is Club';
is $card3.value, 1, 'Value is 1';
