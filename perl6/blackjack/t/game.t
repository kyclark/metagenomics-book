#!/usr/bin/env perl6

use Test;

use lib '.';
use Blackjack;

my $game1 = Blackjack.new;
is $game1.num-players, 1, 'One player';

ok my $dealer = $game1.get-player(0), "Get player 0";
is $dealer.player-num, 0, 'Is player "0"';
ok $dealer.is-dealer == True, 'Player 0 is dealer';
is $dealer.name, 'Dealer', '"Dealer" is the name';

ok my $player = $game1.get-player(1), "Get player 1";
is $player.player-num, 1, 'Is player "1"';
ok $player.is-dealer == False, 'Player 1 is not dealer';
is $player.name, 'Player 1', '"Player 1" is the name';

ok $player.stands == False, 'Player 1 does not stand by default';
ok ($player.stands = True), 'Tell Player 1 to stand';
ok $player.stands == True, 'Player 1 now stands';

ok $player.has-lost == False, 'Player 1 has not lost by default';
ok ($player.has-lost = True), 'Tell Player 1 he has lost';
ok $player.has-lost == True, 'Player 1 has now lost';

ok $player.has-bust == False, 'Player 1 has not bust by default';
ok $player.sum < 21, 'Player 1 has less than 21';
$player.hit while $player.sum < 21;
ok $player.sum > 21, 'Player 1 has more than 21';
ok $player.has-bust == True, 'Player 1 knows he has bust';

dies-ok { $game1.get-player(2) }, "Can't get non-existent player.";

my $game2 = Blackjack.new(:num-players(3));
is $game2.num-players, 3, 'Three players';

done-testing();
