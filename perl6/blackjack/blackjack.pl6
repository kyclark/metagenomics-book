#!/usr/bin/env perl6

use lib '.';
use Blackjack;

my $DEALER-MAX := 18;

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
    my Blackjack $player .= new(:$aces-high);
    my Blackjack $dealer .= new(:$aces-high);

    my $stand = False;
    loop {
        put "Player: ", ~$player;
        put "Dealer: ", ~$dealer;

        my $player-sum = $player.sum;
        my $dealer-sum = $dealer.sum;

        if $stand {
            if ($dealer-sum == $player-sum) {
                put "Push. No winner.";
                return 0;
            }
            elsif ($dealer-sum < $player-sum <= 21) || $dealer-sum > 21 {
                put "Player wins.";
                return 1;
            }
            else {
                put "Player loses.";
                return -1;
            }
        }

        if $dealer-sum == $player-sum == 21 {
            put "Push. No winner.";
            return 0;
        }

        if $dealer-sum > 21 && $player-sum > 21 {
            put "Everyone loses!";
            return 0;
        }

        if $player-sum == 21 {
            put "Blackjack! Player wins!";
            return 1;
        }

        if $player-sum > 21 {
            put "Bust ($player-sum)! Player loses";
            return -1;
        }

        if $dealer-sum == 21 {
            put "Dealer has blackjack. Player loses!";
            return -1;
        }

        if $dealer-sum > 21 {
            put "Dealer busts ($dealer-sum)! Player wins!";
            return 1;
        }

        my $action = prompt "Hit it or quit it? [Yn] ";
        if $action.lc ~~ /^n/ {
            $stand = True;
            while $dealer.sum < $DEALER-MAX {
                $dealer.hit;
                put "Dealer draws ", $dealer.last-card;
            }
        }
        else {
            $player.hit;
            put "Player draws ", $player.last-card;
            if $dealer.sum < $DEALER-MAX {
                $dealer.hit;
                put "Dealer draws ", $dealer.last-card;
            }
            else {
                put "Dealer stands.";
            }
        }
    }
}
