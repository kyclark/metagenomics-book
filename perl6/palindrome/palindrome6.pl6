#!/usr/bin/env perl6

sub MAIN (Str $file='/usr/share/dict/words', :$min=2) {
    die "$file not a file" unless $file.IO.f;

    my $i = 0;
    for $file.IO.lines -> $line {
        for $line.words.grep(*.chars >= $min).map(*.lc) -> $word {
            if $word eq $word.flip {
                printf "%3d: %s\n", ++$i, $word;
            }
        }
    }
}
