#!/usr/bin/env perl6

sub MAIN (Str $file) {
    for $file.IO.lines(:chomp(False)) -> $line {
        for $line.comb -> $letter {
            print $letter;
            my $pause = do given $letter {
                when /<[.!?]>/ { .50 }
                when /<[,;]>/  { .20 }
                default        { .05 }
            }
            sleep $pause;
        }
    }
}
