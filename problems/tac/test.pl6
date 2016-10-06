#!/usr/bin/env perl6

use v6;
use Test;

plan 3;

my $script := './tac.pl6';
my $proc1 = run $script, :err;
my $err1  = $proc1.err.slurp-rest.chomp;
ok $err1 ~~ m:i/usage/, 'No args gives usage';

my $proc2 = run $script, 'foo', :err;
my $err2  = $proc2.err.slurp-rest.chomp;
ok $err2 ~~ m:i/"not a file"/, 'Dies on "Not a file"';

my $out1 = runner($script, 'input.txt');
is $out1, "quux\nbaz\nbar\nfoo", 'Correct output';

sub runner(Str $script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
