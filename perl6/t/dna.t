#!/usr/bin/env perl6

use Test;
use lib $*PROGRAM.dirname;
use Runner;

plan 30;

my $dir     = $*SPEC.catdir($*PROGRAM.dirname, '..', 'dna');
my @scripts = map { "$dir/dna$_.pl6" }, 1..9;

my $dna = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTG"
        ~ "GATTAAAAAAAGAGTGTCTGATAGCAGC";

for @scripts -> $script {
  ok $script.IO.f, "$script exists";
  my $err = runner-err($script);
  ok $err, "error on no args";
  my $out = runner-out($script, $dna);
  is $out, '20 12 17 21', 'correct count';
}

my $out = runner-out("$dir/char-count.pl6", 'AANCTANGNACTAGG');
my $exp = q:to/END/.chomp;
A	5
C	2
G	3
N	3
T	2
END
is $out, $exp, 'char-count OK';

my $out2 = runner-out("$dir/fasta-stat.pl6", "$dir/mouse.fa");
is $out2.lines.elems, 500, 'fasta-stat counts 500 seqs';

my $out3 = runner-out("$dir/fasta-stat.pl6", "$dir/mouse.fa");
is $out3.lines.elems, 500, 'fasta-stat2 counts 500 seqs';
