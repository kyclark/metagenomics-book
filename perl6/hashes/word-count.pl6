#!/usr/bin/env perl6

sub MAIN (Str $file where *.IO.f) {
    my %count;
    for $file.IO.words -> $word {
        %count{ $word }++;
    }

    for %count.grep(*.value > 1) -> (:$key, :$value) {
        printf "Saw '%s' %s times.\n", $key, $value;
    }
}
