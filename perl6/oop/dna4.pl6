#!/usr/bin/env perl6

class DNA is Str {
    multi method ACCEPTS (Str $seq) {
        return $seq.uc ~~ /^ :i <[ACGTN]>+ $/;
    }

    method new (*%args) {
        my $value = %args<value>.Str;
        if $value !~~ DNA {
            fail "'$value' not a DNA sequence.";
        }
        self.bless(|%args);
    }
}

sub MAIN (Str $seq) {
    try {
        my $dna = DNA.new(value => $seq);
        dd $dna;
        CATCH {
            default { .Str.say }
        }
    }
}
