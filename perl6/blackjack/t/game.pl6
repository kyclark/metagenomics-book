#!/usr/bin/env perl6

use Test;

use lib '.';
use Blackjack;

my $game = Blackjack.new;
is $game.num-players, 1, 'One player';

ok my $dealer = $game.get-player(0), "Get player 0";
ok $dealer.is-dealer == True, 'Player 0 is dealer';

ok my $player = $game.get-player(1), "Get player 1";
ok $player.is-dealer == False, 'Player 1 is not dealer';

not-ok $game.get-player(2), "Can't get non-existent player.";

done-testing();
