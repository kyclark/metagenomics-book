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
            when /^\d+$/ { +$!face } # 2..10
            when 'A'     { 11 }
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
        $!cards  = ( 
            map { Card.new(:face($_.key), :suite($_.value)) },
            ((@faces X @suites) xx $!num-decks).flat.pairup
        ).BagHash;
    }
}

class Player {
    has Str  $.name;
    has Int  $.stands-at       = 0;
    has Int  $.bet       is rw = 0;
    has Int  $.chips     is rw = 0;
    has Bool $.has-lost  is rw = False;
    has Deck $.deck      is rw;
    has @.cards is rw;
    my $BLACKJACK = 21;

    method stands {
        $!stands-at > 0 ?? $!stands-at < $.sum !! False;
    }

    method is-out {
        $.chips == 0 || $.bet == 0 || $.has-bust || 
        $.has-lost   || $.has-blackjack;
    }

    method has-blackjack { $.sum == $BLACKJACK }

    method has-bust { $.sum > $BLACKJACK }

    method deal { @!cards = $!deck.cards.grab(2) }

    method hit { @!cards.push($!deck.cards.grab[0]) unless $.stands }

    method sum {
        my $sum  = @!cards.map(*.value).sum;
        my @aces = @!cards.grep(*.face eq 'A');
        while $sum > $BLACKJACK && @aces.pop {
            $sum -= 10;
        }
        $sum;
    }

    method last-card { @!cards[*-1] }

    method Str { sprintf "%2d %s", $.sum, @!cards.map(~*).join(' ') }

    submethod TWEAK { $!name ||= "Player" }
}

class Blackjack {
    has Player $.player is required;
    has Int    $.num-decks = 2;
    has Player $.dealer;
    has Deck   $.deck;

    submethod TWEAK {
        $!deck   = Deck.new(:num-decks($!num-decks));
        $!dealer = Player.new(
            :deck($!deck), :name('Dealer'), :stands-at(18)
        );

        $!player.deck = $!deck;
        .deal for $!dealer, $!player;
    }
}
