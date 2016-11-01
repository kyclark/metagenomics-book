#!/usr/bin/env perl6

subset DNA     of Str where * ~~ /^ :i <[ACTGN]>+ $/;
subset RNA     of Str where * ~~ /^ :i <[ACUGN]>+ $/;
subset Protein of Str where * ~~ /^ :i <[A..Z]>+  $/;

multi MAIN (DNA     $input!) { put "Looks like DNA" }
multi MAIN (RNA     $input!) { put "Looks like RNA" }
multi MAIN (Protein $input!) { put "Looks like Protein" }
multi MAIN (Str     $input!) { put "Unknown sequence type" }
