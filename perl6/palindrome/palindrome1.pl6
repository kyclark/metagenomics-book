#!/usr/bin/env perl6

sub MAIN (Str $file='/usr/share/dict/words') {
    die "$file not a file" unless $file.IO.f;

    for $file.IO.lines -> $word {
        my $lc  = $word.lc;
        my $rev = $lc.comb.reverse.join;

        if $lc eq $rev {
            put $word;
        }
    }
}
