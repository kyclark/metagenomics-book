unit module DNA;

subset DNA of Str is export where /^ :i <[ACGTN]>+ $/;

sub revcom (DNA $seq) is export {
    $seq.trans(<A C G T a c g t> => <T G C A t g c a>).flip;
}

sub hamming (DNA $s1, DNA $s2) is export {
    ($s1.chars - $s2.chars).abs +
    ($s1.comb Z $s2.comb).grep({ $^a[0] ne $^a[1] });
}
