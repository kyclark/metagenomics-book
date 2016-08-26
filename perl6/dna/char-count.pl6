#!/usr/bin/env perl6

sub MAIN (Str $input!) {
    my $text  = $input.IO.e ?? $input.IO.slurp !! $input;
    my $bag   = $text.comb.Bag;
    for $bag.keys.grep(/<[a..zA..Z]>/).sort -> $char {
        put join "\t", $char, $bag{$char};
    }
}
