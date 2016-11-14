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

    method revcomp {
        self.trans(<A C G T a c g t> => <T G C A t g c a>).flip;
    }
}
