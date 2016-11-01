#!/usr/bin/env perl6

use MONKEY-TYPING;

sub MAIN (Str $file='/usr/share/dict/words', :$min=2) {
    die "$file not a file" unless $file.IO.f;

    augment class Str {
        method is-palindrome {
            self.chars >= $min && self.lc eq self.lc.flip
        }
    }

    my $i = 0;
    for $file.IO.lines -> $line {
        for $line.words.grep(*.is-palindrome) -> $word {
            printf "%3d: %s\n", ++$i, $word;
        }
    }
}
