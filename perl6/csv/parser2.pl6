#!/usr/bin/env perl6

sub MAIN (Str $file!, Str :$field!, Str :$sep=',', Int :$limit=0) {
    die "Not a file ($file)" unless $file.IO.f;

    my $fh     = open $file;
    my @fields = $fh.get.split($sep);

    unless one(@fields) eq $field {
        die "No $field in $file";
    }

    my $i = 0;
    for $fh.lines -> $line {
        $i++;
        my @values = $line.split($sep);
        my %record;
        for 0..^@fields.elems -> $i {
            my $key = @fields[$i];
            my $val = @values[$i];
            %record{ $key } = $val;
        }

        put %record{ $field } // "";

        last if $limit > 0 && $i == $limit;
    }
}
