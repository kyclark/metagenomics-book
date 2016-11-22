class Card {
    #subset Face  of Str where * ~~ @faces.any;
    #subset Suite of Str where * ~~ @suites.any;

    subset Face  of Str where * eq any <2 3 4 5 6 7 8 9 10 J Q K A>;
    subset Suite of Str where * eq any <Diamonds Hearts Spades Clubs>;

    has Face  $.face  is required;
    has Suite $.suite is required;
    has Bool  $.aces-high = False;
    has Int   $.value;
    has Str   $.suite-symbol;

    method Str { sprintf "[%2s %s]", $!face, $.suite-symbol }

    submethod TWEAK {
        $!suite-symbol = do given $!suite {
            when 'Clubs'    { "\x2663" }
            when 'Diamonds' { "\x2666" }
            when 'Hearts'   { "\x2665" }
            when 'Spades'   { "\x2660" }
        }

        $!value = do given $!face {
            when 'A'     { $!aces-high == True ?? 11 !! 1 } # ace hi/lo
            when /^\d+$/ { +$!face } # 2..10
            default      { 10 } # face card
        }
    }
}

class Deck {
    has Int  $.num-decks = 2;
    has Bool $.aces-high = False;
    has $.cards;

    submethod TWEAK {
        my @faces  = <2 3 4 5 6 7 8 9 10 J Q K A>;
        my @suites = <Diamonds Hearts Spades Clubs>;
        put "num-decks ($!num-decks)";
        $!cards  = ( 
            map { Card.new(:face($_.key), :suite($_.value)) },
            ((@faces X @suites) xx $!num-decks).flat.pairup
        ).BagHash;
    }
}

class Player {
    has Int  $.player-num is required;
    has Deck $.deck       is required;
    has Str  $.name;
    has Bool $.is-dealer = False;
    has @.cards is rw;

    method deal { @!cards = $!deck.cards.grab(2) }

    method hit  { @!cards.push($!deck.cards.grab[0]) }

    method sum  { @!cards.map(*.value).sum }

    method last-card { @!cards[*-1] }

    method Str { sprintf "%2d %s", $.sum, @!cards.map(~*).join(' ') }

    submethod TWEAK {
        $!name ||= "Player " ~ $!player-num;
        $!is-dealer = $!player-num == 0;
    }
}

class Blackjack {
    has Int  $.num-decks   = 2;
    has Int  $.num-players = 1;
    has Deck $.deck;
    has @.players is rw;

    method Str {
        sprintf "%s player%s", $!num-players, $!num-players == 1 ?? '' !! 's'
    }

    method get-player (Int $player-num) {
        if @!players[$player-num]:exists {
            @!players[$player-num];
        }
        else {
            fail "Not a valid player number ($player-num)";
        }
    }

    submethod TWEAK {
        $!deck    = Deck.new(:num-decks($!num-decks));
        @!players = Player.new(:player-num(0), :deck($!deck));

        for 1..$!num-players -> $i {
            push @!players, Player.new(:player-num($i), :deck($!deck));
        }
        .deal for @!players;
    }
}
