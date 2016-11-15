#!/usr/bin/env perl6

class DNA is Str {
    multi method ACCEPTS (Str $seq) {
        return $seq ~~ /^ :i <[ACGTN]>+ $/;
    }
}

sub MAIN (Str $seq) {
    if $seq ~~ DNA {
        my $dna = DNA.new(value => $seq);
        dd $dna;
    }
    else {
        put "'$seq' not a DNA sequence.";
    }
}
