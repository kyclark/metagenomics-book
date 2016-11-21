class Card {
    #subset Face  of Str where * ~~ @faces.any;
    #subset Suite of Str where * ~~ @suites.any;

    subset Face of Str where * eq any <2 3 4 5 6 7 8 9 10 Jack Queen King Ace>;
    subset Suite of Str where * eq any <Diamond Heart Spade Club>;

    has Face  $.face  is required;
    has Suite $.suite is required;
    has Bool  $.aces-high = False;

    method Str { sprintf "%s of %s (%s)", $!face, $!suite, $.value }

    method value {
        given ($!face, $!aces-high) {
            when (/^\d+$/, $)  { +$!face } # 2..10
            when ('Ace',  :so) { 11 }      # aces high
            when ('Ace', :!so) {  1 }      # aces low
            default            { 10 }      # face card
        }
    }
}

class Deck {
    has $.cards;

    submethod BUILD {
        my @faces  = <2 3 4 5 6 7 8 9 10 Jack Queen King Ace>;
        my @suites = <Diamond Heart Spade Club>;
        my @cards  = map { Card.new(:face($_[0]), :suite($_[1])) },
                     (@faces X @suites);
        $!cards    = @cards.SetHash;
    }
}

class Blackjack {
    has Int $.chips  = 0;
    has Deck $.deck .= new;
    has @.cards is rw;

    method deal {
        @!cards = $!deck.cards.grab(2);
    }

    method hit {
        @!cards.push($!deck.cards.grab[0]);
    }

    method Str {
        sprintf "%2d (%s)", $.sum, @!cards.map(~*).join(', ');
    }

    method sum {
        @!cards.map(*.value).sum;
    }
}
