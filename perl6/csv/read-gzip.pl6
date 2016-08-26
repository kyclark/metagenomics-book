#!/usr/bin/env perl6

sub MAIN (Str $file! where *.IO.f) {
    my $fh   = $file ~~ /\.gz$/ 
             ?? run(«gunzip -c $file |», :out).out 
             !! open $file;

    for $fh.lines -> $line {
        put $line;
    }
}
