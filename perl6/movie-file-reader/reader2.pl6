#!/usr/bin/env perl6

sub MAIN (Str $file) {
    for $file.IO.comb {
        .print;
        sleep  /<[.!?]>/ ?? .30
            !! /<[,;]>/  ?? .10
            !!              .05;
    }
}
