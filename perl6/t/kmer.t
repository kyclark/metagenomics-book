#!/usr/bin/env perl6

use Test;
use lib $*PROGRAM.dirname.Str;
use Runner;

plan 9;

my $dir     = $*SPEC.catdir($*PROGRAM.dirname, '..', 'kmers');
my $input   = $*SPEC.catfile($dir, 'input.txt');

ok $input.IO.f, "$input exists";

my $expect = q:to/END/.chomp;
AGCTTTTCATTCTGACTG
GCTTTTCATTCTGACTGC
CTTTTCATTCTGACTGCA
TTTTCATTCTGACTGCAA
TTTCATTCTGACTGCAAC
TTCATTCTGACTGCAACG
TCATTCTGACTGCAACGG
CATTCTGACTGCAACGGG
END

for 1..3 -> $i {
    my $script = $*SPEC.catfile($dir, "kmer$i.pl6");
    ok $script.IO.f, "$script exists";
    my $err1 = runner-err($script, '-k=3', 'AA');
    is $err1, "Cannot extract 3-mers from seq length 2", 
       "$script fails on too short";

    my $out1 = runner-err($script, '-k=-3', 'AAAAAAAAA');
    is $out1, "$script fails on negative k";

    my $out2 = runner-out($script, '-k=3', 'ACTG');
    is $out2, "ACT\nCTG", "$script runs from command line";

    my $out3   = runner-out($script, '-k=18', $input);
    is $out3, $expect, "$script uses file argument";
}

for 1..3 -> $i {
    my $script = $*SPEC.catfile($dir, "fasta-kmer$i.pl6");
    ok $script.IO.f, "$script exists";
}
