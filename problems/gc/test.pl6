#!/usr/bin/env perl6

use Test;

plan 3;

my $script := './gc.pl6';

my $proc1 = run $script, 'foo', :err;
my $err1  = $proc1.err.slurp-rest.chomp;
ok $err1 ~~ m:i/"not a file"/, 'Bad arg gives usage';

my $out1 = runner($script, '--threshold=.5', 'burk.fa');
is $out1, q:to/EOF/.chomp, 'Burkholderia';
0.52: burkholderia
0.51: burkholderia
0.50: anthrax
0.47: anthrax
0.51: burkholderia
0.46: anthrax
0.50: anthrax
0.44: anthrax
0.49: anthrax
EOF

my $out2 = runner($script, 'anthrax.fa');
is $out2, q:to/EOF/.chomp, 'Anthrax';
0.20: anthrax
0.26: anthrax
0.35: burkholderia
0.35: burkholderia
0.35: burkholderia
0.30: anthrax
0.32: burkholderia
0.32: burkholderia
0.41: burkholderia
0.36: burkholderia
0.30: anthrax
0.34: burkholderia
0.24: anthrax
0.22: anthrax
0.31: burkholderia
0.41: burkholderia
0.32: burkholderia
0.35: burkholderia
0.49: burkholderia
0.35: burkholderia
0.30: anthrax
0.19: anthrax
0.35: burkholderia
EOF

sub runner(Str $script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
