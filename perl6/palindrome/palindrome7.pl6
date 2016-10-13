#!/usr/bin/env perl6

sub MAIN (Str $phrase="A man, a plan, a canal. Panama") {
    my $forward = $phrase.lc.subst(/<-[a..z]>/, '', :g);
    printf "%s\n%s\n",
        $phrase,
        $forward eq $forward.comb.reverse.join ?? 'Yes' !! 'No';
}
