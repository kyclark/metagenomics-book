#!/usr/bin/env perl6

sub MAIN (Str $file='/usr/share/dict/words', :$min=2) {
    die "$file not a file" unless $file.IO.f;

    sub is-palindrome ($s) { $s.chars >= $min && $s eq $s.flip }

    my $i = 0;
    for $file.IO.lines -> $line {
        for $line.words.map(*.lc).grep({is-palindrome($_)}) -> $word {
            printf "%3d: %s\n", ++$i, $word;
        }
    }
}
