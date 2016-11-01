#!/usr/bin/env perl6

my %aa = Isoleucine    => <ATT ATC ATA>,
         Leucine       => <CTT CTC CTA CTG TTA TTG>,
         Valine        => <GTT GTC GTA GTG>,
         Phenylalanine => <TTT TTC>,
         Methionine    => <ATG>,
         Cysteine      => <TGT TGC>,
         Alanine       => <GCT GCC GCA GCG>,
         Glycine       => <GGT GGC GGA GGG>,
         Proline       => <CCT CCC CCA CCG>,
         Threonine     => <ACT ACC ACA ACG>,
         Serine        => <TCT, TCC, TCA, TCG, AGT, AGC>,
         Tyrosine      => <TAT TAC>,
         Tryptophan    => <TGG>,
         Glutamine     => <CAA CAG>,
         Asparagine    => <AAT AAC>,
         Histidine     => <CAT CAC>,
         Glutamic_acid => <GAA GAG>,
         Aspartic_acid => <GAT GAC>,
         Lysine        => <AAA AAG>,
         Arginine      => <CGT CGC CGA CGG AGA AGG>,
         Stop          => <TAA TAG TGA>;

for %aa.keys.sort -> $key {
    printf "%-15s = %s\n", $key, %aa{ $key }.sort.join(", ");
}
