#!/usr/bin/env perl6

use Test;

use lib '.';
use Blackjack;

my $deck1 = Deck.new(:num-decks(1));
my $player = Player.new(:player-num(1), :deck($deck1));
is $player.player-num, 1, 'Player One';
ok $player.deal, 'Deal a hand.';
is $player.cards.elems, 2, 'Initial hand is 2 cards';
ok $player.hit, 'Hit';
is $player.cards.elems, 3, 'After hit there are 3 cards';

my @cards = $player.cards;
ok @cards[*-1].Str eq $player.last-card.Str, "Last card works";

my $sum = @cards.map(*.value).sum;
is $sum, $player.sum, "Sum is good ($sum)";

done-testing();
