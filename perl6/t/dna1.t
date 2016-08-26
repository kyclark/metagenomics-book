#!/usr/bin/env perl6

use v6;
use Test;
use Test::Output;

plan 3;

my $prog   = IO::Path.new($*PROGRAM-NAME);
my $script = $*SPEC.catfile($prog.parent.parent, 'dna1.pl6');
my $proc1  = run $script, :merge;

say $proc1.out.slurp-rest
isnt $proc1.exitcode, 0, "Error with no input";


my $dna = 
  'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC';

#put "script ($script)";
#put "script exists ({$script.IO.e})";
#put "dna ($dna)";
my $proc2  = run $script, $dna;

is $proc2.exitcode, 0, "No error with input";
#dd $proc2;

is $proc2.out.get, "20 12 17 21", "Proper counts";

#put "exit = '{$proc2.exitcode}'";
#put "out = '{$proc2.out}'";
