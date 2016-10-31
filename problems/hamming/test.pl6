#!/usr/bin/env perl6

use Test;

plan 3;

my $script := './hamming.pl6';

my $proc1 = run $script, :err;
my $err   = $proc1.err.slurp-rest.chomp;
ok $err ~~ /Usage/, 'No args gives usage';

my $out1 = runner($script, 'GAGCCTACTAACGGGAT', 'CATCGTAATGACGGCCT');
is $out1, '7', 'Got expected output (7)';

my $out2 = runner($script, 'AACT', 'AACGGG');
is $out2, '3', 'Got expected output (3)';

sub runner($script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
