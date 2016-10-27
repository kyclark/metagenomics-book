#!/usr/bin/env perl6

use Test;

plan 3;

my $script := './txt2fasta.pl6';

my $proc1 = run $script, :err;
my $err   = $proc1.err.slurp-rest.chomp;
ok $err ~~ /Usage/, 'No args gives usage';

my $expected1 = q:to/END/;
>1
TTTGATACTCCTATTAAGTAAAAGTTTTTAGGGTCTGTATAAAACGAAGC
CTGAGCATACCCTCTTGCTGTAT
>2
TGTGCTCCCGATGCTTTTATCGCAGCCTCCATCAAGTCATTTGAGCGGAA
TTTGCCTGTTCCTACAAATAGGCGGGAGCTG
>3
GAAAACGAAAACGGAGAGTTAGCCCTTATAGTTCCAGAAAAAGAAATGGA
TGCAGGAGCGG
END
my $out1 = runner($script, 'input1.txt');
is $out1, $expected1.chomp, 'Got expected output';

my $expected2 = q:to/END/;
>1
CCTACAAATAGGCGGGAGCT
GTGTGCTCCCGATGCTTTTA
TCGCAGCCTCCATCAAGTCA
TT
>2
TGAGCGGAATTTGCCTGTTT
T
>3
TGATACTCCTATTAAGTAAA
AGTTTTTAGGGTCTG
>4
TATAAAACGAAGCCTGAGCA
TACCCTCTTGCTGTATGAAA
ACGAAAA
>5
CGGAGAGTTAGCCCTTATAG
TTCCAGAAAAAGAAATGGAT
GCAGGAGCGG
END
my $out2 = runner($script, '--max=20', 'input2.txt');
is $out2, $expected2.chomp, 'Got expected output';

sub runner($script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
