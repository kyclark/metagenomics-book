#!/usr/bin/env perl6

class DNA is Str {
    multi method ACCEPTS (Str $seq) {
        return $seq.uc ~~ /^ <[ACGTN]>+ $/;
    }

    method new (Str $str) {
        if $str.uc !~~ DNA {
            fail "Not a DNA sequence.";
        }

        self.bless(value => $str);
    }

    method revcom {
        self.trans(<A C G T a c g t> => <T G C A t g c a>).flip;
    }
}

sub MAIN (Str $str) {
    try {
        my $dna = DNA.new($str);
        printf "Input : %s\nRevcom: %s\n", $dna, $dna.revcom;

        CATCH {
            default { .Str.say }
        }
    }
}
