#!/usr/bin/env perl6

class DNA is Str {
    multi method ACCEPTS (Str $seq) {
        return $seq.uc ~~ /^ <[ACGTN]>+ $/;
    }

    method new (Str $str) {
        if $str.uc !~~ DNA {
            fail "'$str' not a DNA sequence.";
        }

        self.bless(value => $str);
    }
}

sub MAIN (Str $str) {
    try {
        my $dna = DNA.new($str);
        dd $dna;

        CATCH {
            default { .Str.say }
        }
    }
}
