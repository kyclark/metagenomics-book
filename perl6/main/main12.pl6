#!/usr/bin/env perl6

subset DNA of Str where /^ :i <[ACTGN]>+ $/;

multi MAIN ('revcom', DNA $dna) {
    put $dna.trans(<A C G T a c g t> => <T G C A t g c a>).flip;
}

multi MAIN ('rna', DNA $dna) {
    put $dna.subst('T', 'U', :g);
}
