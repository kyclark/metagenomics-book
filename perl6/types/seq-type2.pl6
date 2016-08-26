#!/usr/bin/env perl6

sub MAIN (Str $input!) {
    given $input {
        when /^ :i <[ACTGN]>+ $/ { put "Looks like DNA" }
        when /^ :i <[ACUGN]>+ $/ { put "Looks like RNA" }
        when /^ :i <[A..Z]>+  $/ { put "Looks like protein";
        default { put "Unknown sequence type" }
   }
}
