#!/usr/bin/env perl6

use lib '.';
use Blackjack;

sub MAIN (Int :$chips where * > 0 = 200, Bool :$aces-high=False) {
    my $stack = $chips;
    loop {
        if $stack < 1 {
            put "Looks like you ran out of chips.  Better luck next time.";
            last;
        }

        my $bet = 
        (prompt "How much you wanna bet? (max $stack, default 20) ").Int || 20;

        if $bet < 1 {
            put "Come on, sissy.  You gotta bet something.";
            next;
        }
        elsif $bet > $stack {
            put "You can't bet more than you have, numbskull!";
            next;
        }

        put "$bet on the line!";
        $stack += $bet * play(:$aces-high);
        my $answer = prompt "You now have $stack. Play again? [Yn] ";
        if $answer.lc ~~ /^n/ {
            put "Bye now.";
            last;
        }
    }

    printf "You started with %s chip%s and ended with %s chip%s.\n", 
        $chips, $chips == 1 ?? '' !! 's',
        $stack, $stack == 1 ?? '' !! 's';
}

sub play (Bool :$aces-high) {
    my Blackjack $game   .= new(:$aces-high);
    my Blackjack $dealer .= new(:$aces-high);
    $game.deal;
    $dealer.deal;

    loop {
        put "You   : ", ~$game;
        put "Dealer: ", ~$dealer;

        my $sum = $game.sum;
        if $sum > 21 {
            put "Bust! You lose";
            return -1;
        }

        if $sum == 21 {
            put "Blackjack! You win!";
            return 1;
        }

        my $dealer-sum = $dealer.sum;
        if $dealer-sum > 21 {
            put "Dealer busts! You win!";
            return 1;
        }

        if $dealer-sum == 21 {
            put "Dealer has blackjack. You lose!";
            return -1;
        }

        my $action = prompt "Hit it or quit it? [Yn] ";
        if $action.lc ~~ /^n/ {
            while $dealer.sum <= 18 {
                $dealer.hit;
                printf "Dealer hits (%s)\n", $dealer.sum;
            }

            if $dealer.sum < $sum <= 21 {
                put "You win.";
                return 1;
            }
            elsif $dealer.sum <= 21 {
                put "You lose.";
                return -1;
            }
        }
        else {
            $game.hit;
            put "You drew ", $game.last-card;
        }

        if $dealer.sum >= 18 {
            put "Dealer stands";
        }
        else {
            put "Dealer hits, draws ", $game.last-card;;
            $dealer.hit;
        }
    }
}
