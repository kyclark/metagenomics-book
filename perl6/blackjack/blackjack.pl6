#!/usr/bin/env perl6


class Deck {
    #<♠ ♣ ♦ ♥>;
    #my @suites = <\x2665 \x2660 \x2666 \x2663>;

    has $.cards;
    submethod BUILD {
        my @cards = <2 3 4 5 6 7 8 9 10 Jack Queen King Ace> X
                    <Diamond Heart Spade Club>;
        $!cards = @cards.SetHash;
    }
}

class Blackjack {
    has Int $.chips  = 0;
    has Deck $.deck .= new;
    has $.hand is rw;

    method deal {
        $!hand = [ $!deck.cards.grab(2) ];
    }

    method hit {
        $!hand.push($!deck.cards.grab(1));
    }

    method Str {
        #"hand = " ~ $!hand
        dd self;
    }

    method sum {
        $!hand.map(*[0]).sum;
    }
}


sub MAIN (Int :$chips where * > 0 = 200) {
    my $stack = $chips;
    loop {
        $stack = play($stack);
        my $answer = prompt "Play again? [Yn] ";
        if $answer.lc ~~ /^n/ {
            put "Bye now.";
            last;
        }
    }

    put "You started with %s %s and ended with %s chip%s\n", 
        $chips, $chips == 1 ?? '' !! 's',
        $stack, $stack == 1 ?? '' !! 's';
}

sub play (Int $chips) {
    my Blackjack $game .= new(chips => $chips);
    $game.deal;

    loop {
        dd $game.hand;
        my $sum = $game.sum;
        put "sum = $sum";
        if $sum > 21 {
            put "You have $sum. You lose!";
            exit;
        }

        if $sum == 21 {
            put "You win!";
            exit;
        }

        my $action = prompt "Hit it or quit it? [Yn] ";
        $game.hit unless $action.lc ~~ /^n/;
    }
    return $chips;
}
