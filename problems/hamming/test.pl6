#!/usr/bin/env perl6

use v6;
use Test;

plan 2;

my $script := './prot.pl6';

my $proc1 = run $script, :err;
my $err   = $proc1.err.slurp-rest.chomp;
ok $err ~~ /Usage/, 'No args gives usage';

my $out = runner($script, 'GAGCCTACTAACGGGAT', 'CATCGTAATGACGGCCT');
is $out, '7', 'Got expected output';

sub runner($script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
