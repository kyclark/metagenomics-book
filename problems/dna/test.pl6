#!/usr/bin/env perl6

use v6;
use Test;

plan 3;

my $script := './dna.pl6';
my $proc1 = run $script, :err;
my $err   = $proc1.err.slurp-rest.chomp;
ok $err ~~ /Usage/, 'No args gives usage';

my $out1 = runner($script,
  'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC');

is $out1, "20 12 17 21", 'Correct count from command line';

my $out2 = runner($script, 'test.txt');

is $out2, "20 12 17 21", 'Correct count from file';

sub runner(Str $script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
