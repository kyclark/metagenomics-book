#!/usr/bin/env perl6

use v6;
use Test;

plan 2;

my $script := './wc.pl6';

my $proc1 = run $script, 'foo', :err;
my $err1  = $proc1.err.slurp-rest.chomp;
ok $err1 ~~ m:i/"not a file"/, 'Bad arg gives usage';

my $out1 = runner($script, 'const.txt');
is $out1, "lines (872) words (7652) chars (45119)", "Correct output";

sub runner(Str $script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
