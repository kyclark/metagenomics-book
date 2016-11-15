enum Direction <Forward Reverse>;

class DNA is Str {
    has Direction $.direction = Forward;

    multi method ACCEPTS (Str $seq) {
        return $seq ~~ /^ :i <[ACGTN]>+ $/;
    }

    # e.g., DNA.new($seq1);
    multi method new ($seq) {
        if $seq !~~ DNA {
            fail "'$seq' not a DNA sequence.";
        }
        self.bless(value => $seq);
    }

    # e.g., DNA.new(value => $seq1);
    multi method new (*%args) {
        my $value = %args<value>.Str;
        if $value !~~ DNA {
            fail "'$value' not a DNA sequence.";
        }
        self.bless(|%args);
    }

    method revcom {
        self.trans(<A C G T a c g t> => <T G C A t g c a>).flip;
    }

    method length { self.chars }

    method hamming (DNA $other) {
        return (self.chars - $other.chars).abs +
               (self.comb Z $other.comb).grep({ $^a[0] ne $^a[1] });
    }

    method infix:<(&)> (DNA $self, DNA $other) {
        my $set1 = $self.Str.Set;
        dd $set1;
        my $set2 = $other.Str.Set;
        dd $set2;
        return $set1 (&) $set2;
    }
}
