#!/usr/bin/env perl6

use Test;

#plan 8;

my $script := './common.pl6';

my $proc1 = run $script, :err;
my $err1  = $proc1.err.slurp-rest.chomp;
ok $err1 ~~ m:i/usage/, "No args gives usage";

my $out1 = runner($script, 'dec.txt', 'const.txt');
is $out1, "262", "dec/const = 262";

my $out2 = runner($script, 'foo', 'bar');
is $out2, "0", "foo/bar = 0";

my $out3 = runner($script, 'text1.txt', 'text2.txt');
is $out3, "8", "text1/text2 = 8";

sub runner(Str $script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
