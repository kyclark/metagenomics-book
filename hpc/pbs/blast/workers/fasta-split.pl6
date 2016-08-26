#!/usr/bin/env perl6

sub MAIN (Str :$in-dir! where *.IO.d, Str :$out-dir!, Int :$max=50000) {
    mkdir $out-dir unless $out-dir.IO.d;

    for dir($in-dir) -> $file {
        my &next-fh = sub {
            state $file-num = 1;
            open $*SPEC.catfile($out-dir, 
                sprintf('%03d-%s', $file-num++, $file.basename)
            ), :w;
        };

        my $out-fh = &next-fh();
        my @buffer;
        my $i = 0;
        for $file.IO.lines -> $line {
            $i++ if $line ~~ /^'>'/;

            if $i == $max {
                $out-fh.put(@buffer.join("\n")) if @buffer;
                $out-fh.close;
                $out-fh = &next-fh();
                $i      = 0;
                @buffer = ();
            }

            @buffer.push($line);
        }

        $out-fh.put(@buffer.join("\n")) if @buffer;
    }
}
