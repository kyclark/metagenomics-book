class Card {
    #subset Face  of Str where * ~~ @faces.any;
    #subset Suite of Str where * ~~ @suites.any;

    subset Face of Str where * eq any <2 3 4 5 6 7 8 9 10 J Q K A>;
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

    method Str { sprintf "%2s%s (%2d)", $!face, $.suite-symbol, $.value }

    submethod TWEAK {
        printf "face '%s' aces-high '%s'\n", $!face.Str, $!aces-high;
        $!value = do given $!face {
            # Aces high/low
            when 'A'     { $!aces-high == True ?? 11 !! 1 }

            # 2..10
            when /^\d+$/ { +$!face }

            # face card
            default      { 10 }
        }
        put "value = ", $!value;
    }
}
