#!/usr/bin/env perl6

use lib '.';
use Blackjack;
enum Result <Win Loss Push>;

my $DEALER-MAX := 18;
my $BLACKJACK  := 21;

sub MAIN (
    UInt :$num-players=1,
    UInt :$default-bet=20,
    UInt :$num-decks=2,
    UInt :$chips=200
) {
    my @players = do for 1..$num-players -> $i {
        my $name = prompt "Name for player $i (Player $i)? ";
        Player.new(:player-num($i), :$name, :$chips);
    }

    loop {
        play(:$num-decks, :$default-bet, :@players);

        my $answer = prompt "Play again? [Yn] ";
        if $answer.lc ~~ /^n/ {
            put "Bye now.";
            last;
        }
    }

    for @players -> $player {
        printf "{$player.name} started with %s and ended with %s chip%s.\n",
            $player.chips, $chips, $chips == 1 ?? '' !! 's';
    }
}

sub play (Int :$num-decks, Int :$default-bet, :@players) {
    my Blackjack $game .= new(:$num-decks, :@players);

    # take bets
    for $game.players -> $player {
        if $player.chips == 0 {
            $player.bet = 0;
            put "{$player.name} ran out of chips.  Better luck next time.";
        }
        else {
            my $bet = prompt(sprintf(
                "How much you wanna bet? (max %s, default %s)",
                $player.chips, $default-bet)) || $default-bet;

            if $bet < 1 {
                put "Sissy. I'll put you down for $default-bet";
                $player.bet = $bet;
            }
            elsif $bet > $player.chips {
                put "You can't bet that much, but you're all-in.";
                $player.bet = $player.chips;
            }
            else {
                $player.bet = $bet;
            }
        }
    }

    my $dealer = $game.dealer;

    loop {
        for $game.players -> $player {
            printf "%10s: %s\n", $dealer.name, ~$dealer;
            printf "%10s: %s\n", $player.name, ~$player;

            my Result $result;
            if $player.stands {
                if $dealer.sum == $player.sum {
                    put "Push. No winner.";
                    $result = Push;
                }
                elsif $dealer.has-bust ||
                      ($dealer.sum < $player.sum <= $BLACKJACK) {
                    put "{$player.name} wins.";
                    $result = Win;
                }
                else {
                    put "{$player.name} loses.";
                    $player.has-lost = True;
                    $result = Loss;
                }
            }

            if $dealer.has-blackjack && ($dealer.sum == $player.sum) {
                put "Push. No winner.";
                $result = Push;
            }

            if $dealer.has-bust && $player.has-bust {
                put "Everyone loses!";
                $result = Push;
            }

            if $player.has-blackjack {
                put "Blackjack! {$player.name} wins!";
                $result = Win;
            }

            if $player.has-bust {
                put "Bust ({$player.sum})! {$player.name} loses";
                $result = Loss;
            }

            if $dealer.has-blackjack {
                put "Dealer has blackjack. {$player.name} loses!";
                $player.has-lost = True;
                $result = Loss;
            }

            if $dealer.has-bust {
                put "Dealer busts ({$dealer.sum})! {$player.name} wins!";
                $result = Win;
            }

            my $action = prompt "Hit it or quit it? [Yn] ";
            if $action.lc ~~ /^n/ {
                $player.stands = True;
            }
            else {
                $player.hit;
                printf "%s draws %s\n", $player.name, $player.last-card;
            }

            # win, lose, or draw, any result means we're out
            given $result {
                when Win      { $player.chips += $player.bet }
                when Loss     { $player.chips -= $player.bet }
                when .defined { $player.bet = 0 }
            }
        }

        if all($game.players».stands) {
            while $dealer.would-hit {
                $dealer.hit;
                put "Dealer draws ", $dealer.last-card;
            }
        }
        else {
            if $dealer.would-hit {
                $dealer.hit;
                put "Dealer draws ", $dealer.last-card;
            }
            else {
                put "Dealer stands.";
            }
        }

        last if all($game.players».is-out);
    }
}
