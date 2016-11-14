#!/usr/bin/env perl6

class DNA {
    has Str $.seq;

    multi method ACCEPTS (Str $seq) {
        return $seq.uc ~~ /^ <[ACGTN]>+ $/;
    }

    method new (*%args) {
        my $str = %args{'seq'}.Str;
        if $str.uc !~~ DNA {
            fail "Not a DNA sequence.";
        }
        self.bless(|%args);
    }
}

sub MAIN (Str $seq) {
    my $dna = DNA.new(seq => $seq);
    CATCH {
        default { die .Str.say }
    }

    dd $dna;
}
