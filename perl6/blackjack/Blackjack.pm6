class Card {
    #subset Face  of Str where * ~~ @faces.any;
    #subset Suite of Str where * ~~ @suites.any;

    subset Face  of Str where * eq any <2 3 4 5 6 7 8 9 10 J Q K A>;
    subset Suite of Str where * eq any <Diamonds Hearts Spades Clubs>;

    has Face  $.face  is required;
    has Suite $.suite is required;
    has Bool  $.aces-high = False;
    has Int   $.value;

    method suite-symbol {
        given $.suite {
            when 'Clubs'    { "\x2663" }
            when 'Diamonds' { "\x2666" }
            when 'Hearts'   { "\x2665" }
            when 'Spades'   { "\x2660" }
        }
    }

    method Str { sprintf "[%2s %s]", $!face, $.suite-symbol }

    submethod TWEAK {
        $!value = do given $!face {
            # Aces high/low
            when 'A'     { $!aces-high == True ?? 11 !! 1 }

            # 2..10
            when /^\d+$/ { +$!face }

            # face card
            default      { 10 }
        }
    }
}

class Deck {
    has Bool $.aces-high = False;
    has $.cards;

    submethod TWEAK {
        my @faces  = <2 3 4 5 6 7 8 9 10 J Q K A>;
        my @suites = <Diamonds Hearts Spades Clubs>;
        $!cards  = ( map { 
            Card.new(:face($_[0]), :suite($_[1]), :$!aces-high) 
        }, (@faces X @suites)).SetHash;
    }
}

class Blackjack {
    has Bool $.aces-high = False;
    has Deck $.deck .= new(:$!aces-high);
    has @.cards is rw;

    method deal {
        @!cards = $!deck.cards.grab(2);
    }

    method hit {
        @!cards.push($!deck.cards.grab[0]);
    }

    method Str {
        sprintf "%2d %s", $.sum, @!cards.map(~*).join(' ');
    }

    method sum {
        @!cards.map(*.value).sum;
    }

    method last-card {
        @!cards[*-1]
    }
}
