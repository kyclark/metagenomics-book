enum Direction <Forward Reverse>;

class DNA is Str {
    has Direction $.direction = Forward;

    multi method ACCEPTS (Str $seq) {
        return $seq ~~ /^ :i <[ACGTN]>+ $/;
    }

    method new (*%args) {
        my $value = %args<value>.Str;
        if $value !~~ DNA {
            fail "Not a DNA sequence.";
        }
        self.bless(|%args);
    }

    method length { self.chars }

    method revcom {
        self.trans(<A C G T a c g t> => <T G C A t g c a>).flip;
    }
}
