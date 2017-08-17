#!/usr/bin/env perl6

use lib '.';
use Blackjack1;
enum Result <Win Loss Push>;

my $DEALER-MAX := 18;
my $BLACKJACK  := 21;

sub MAIN (
    UInt :$default-bet=20,
    UInt :$num-decks=2,
    UInt :$chips=200
) {
    my $name   = prompt "Name for player (Player)? ";
    my $player = Player.new(:$name, :$chips);

    while $player.chips > 0 {
        play(:$num-decks, :$default-bet, :$player);

        my $answer = prompt "Play again? [Yn] ";
        if $answer.lc ~~ /^n/ {
            put "Bye now.";
            last;
        }
    }

    printf "{$player.name} started with %s and ended with %s chip%s.\n",
            $player.chips, $chips, $chips == 1 ?? '' !! 's';
}

sub play (Int :$num-decks, Int :$default-bet, :$player) {
    my Blackjack $game .= new(:$num-decks, :$player);

    while !$player.bet {
        my $bet = prompt(sprintf(
            "How much you wanna bet? (max %s, default %s) ",
            $player.chips, $default-bet
        )) || $default-bet;

        if $bet < 1 {
            put "Sissy. You gotta put something on the line.";
        }
        elsif $bet > $player.chips {
            put "That's more than you have.";
        }
        else {
            $player.bet = $bet;
        }
    }

    my $dealer = $game.dealer;
    my $result;

    loop {
        printf "%10s: %s\n", $dealer.name, ~$dealer;
        printf "%10s: %s\n", $player.name, ~$player;

        # win, lose, or draw, any result means we're out
        given $result {
            when Win { 
                put "{$player.name} wins.";
                $player.chips += $player.bet;
            }

            when Loss {
                put "{$player.name} loses.";
                $player.chips -= $player.bet;
            }

            when Push {
                put "Push, no winner.";
            }

            when .defined {
                last;
            }
        }

        #last if $player.is-out;

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
                #$player.has-lost = True;
                $result = Loss;
            }
        }
        else {
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

#            if $dealer.has-blackjack {
#                put "Dealer has blackjack. {$player.name} loses!";
#                $player.has-lost = True;
#                $result = Loss;
#            }

            if $dealer.has-bust {
                put "Dealer busts ({$dealer.sum})! {$player.name} wins!";
                $result = Win;
            }
        }

        unless $result {
            my $action = prompt "Hit it or quit it? [Yn] ";
            if $action.lc ~~ /^n/ {
                $player.stands = True;
            }
            else {
                $player.hit;
                printf "%s draws %s\n", $player.name, $player.last-card;
            }
        }

        if $player.stands {
            while !$dealer.stands {
                $dealer.hit;
                put "Dealer draws ", $dealer.last-card;
            }
        }
        else {
            if $dealer.stands {
                put "Dealer stands.";
            }
            else {
                $dealer.hit;
                put "Dealer draws ", $dealer.last-card;
            }
        }
    }
}
