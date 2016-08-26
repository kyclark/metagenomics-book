#!/usr/bin/env perl6

use v6;
use Test;

plan 2;

my $script := './txt2fasta.pl6';

my $proc1 = run $script, :err;
my $err   = $proc1.err.slurp-rest.chomp;
ok $err ~~ /Usage/, 'No args gives usage';

my $expected = q:to/END/;
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
my $out = runner($script, 'input.txt');
is $out, $expected.chomp, 'Got expected output';

sub runner($script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
