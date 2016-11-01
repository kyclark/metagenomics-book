#!/usr/bin/env perl6

use Test;

my $script = './cat-n.sh';

my $out1 = run($script, :out).out.slurp-rest;

ok $out1 ~~ /Usage/, 'Prints usage';

my $out2 = run($script, 'input.txt', :out).out.slurp-rest;

is $out2, "1 foo\n2 bar\n", 'Correct output';
