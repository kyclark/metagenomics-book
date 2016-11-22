#!/usr/bin/env perl6

use lib '.';
use Test;

use-ok 'Blackjack';
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

#my $card1 = Card.new(:face('2'), :suite('Heart'));
#is $card1.face, '2', 'Face is 2';
#is $card1.suite, 'Heart', 'Suite is Heart';
#is $card1.value, 2, 'Value is 2';
#
#my $card2 = Card.new(face => 'Jack', suite => 'Diamond');
#is $card2.face, 'Jack', 'Face is Jack';
#is $card2.suite, 'Diamond', 'Suite is Diamond';
#is $card2.value, 10, 'Value is 10';
#
#my $card3 = Card.new(face => 'Ace', suite => 'Club');
#is $card3.face, 'Ace', 'Face is Ace';
#is $card3.suite, 'Club', 'Suite is Club';
#ok $card3.aces-high == False, 'Aces high is False';
#is $card3.value, 1, 'Value is 1';
#
#my $card4 = Card.new(face => 'Ace', suite => 'Club', :aces-high);
#is $card4.face, 'Ace', 'Face is Ace';
#is $card4.suite, 'Club', 'Suite is Club';
#ok $card4.aces-high == True, 'Aces high is True';
#is $card4.value, 11, 'Value is 11';
#
#dies-ok { Card.new(face => 'Foo', suite => 'Club') }, "Bad Face";
#dies-ok { Card.new(face => '3', suite => 'Foo') }, "Bad Suite";
