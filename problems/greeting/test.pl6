#!/usr/bin/env perl6

use v6;
use Test;

my $script := './greeting.pl6';
my $proc1 = run $script, :err;
my $err   = $proc1.err.slurp-rest.chomp;
ok $err ~~ /Usage/, 'No args gives usage';

my $out1 = runner($script, 'Sir Galahad');
is $out1, "Hello, Sir Galahad, your name has 11 characters.", "Correct output";

sub runner(Str $script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
