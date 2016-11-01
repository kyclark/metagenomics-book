#!/usr/bin/env perl6

sub MAIN {
    my @case_nums = 1..100;
    for (1..* Z 'dependent.csv'.IO.lines) -> ($i, $line) {
        if $i == 1 {
            put $line;
        }
        else {
            my ($fname, $lname, $) = $line.split(',');
            put ($fname, $lname, @case_nums.pick).join(',');
        }
    }
}
