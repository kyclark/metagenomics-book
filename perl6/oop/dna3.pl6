#!/usr/bin/env perl6

class DNA {
    has Str $.seq;

    multi method ACCEPTS (Str $seq) {
        return $seq.uc ~~ /^ <[ACGTN]>+ $/;
    }

}

sub MAIN (Str $str) {
    if $str ~~ DNA {
        my $dna = DNA.new(seq => $str);
        dd $dna;
    }
    else {
        put "Not a DNA sequence.";
    }
}
