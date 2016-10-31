#!/usr/bin/env perl6

sub MAIN {
    my @cw = 'case_worker.csv'.IO.lines[1..*];

    for (1..* Z 'client.csv'.IO.lines) -> ($i, $line) {
        printf "%s,%s\n", $line, $i == 1 ?? 'case_worker' !! @cw.pick;
    }
}
