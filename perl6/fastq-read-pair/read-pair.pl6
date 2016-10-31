#!/usr/bin/env perl6

class Fastq {
    has Str $.header;
    has Str $.seq;
    has Str $.qual;
    has IO::Handle $.fh;
    has Str $.name = "";
    has Int $.num  = 0;
    has Int $.dir  = 0;

    submethod BUILD (Str :$header, Str :$seq, Str :$qual, IO::Handle :$fh) {
        $!header = $header;
        $!seq    = $seq;
        $!qual   = $qual;
        $!fh     = $fh;

        # isolate ID from header, take off "@"
        (my $id = $header) ~~ s/\s.*//;
        $id ~~ s/^ '@'//;

        # e.g., "SRR1647045.4.1" where 4 is read num, 1 is direction
        if my $match = $id ~~ /(.*) '.' (\d+) '.' (<[12]>)$/ {
            $!name = ~$match[0];
            $!num  = +$match[1];
            $!dir  = +$match[2];
        }
    }

    method Str {
        return join "\n", $.header, $.seq, '+', $.qual;
    }
}

# --------------------------------------------------
subset File of Str where *.IO.f;
sub MAIN (
    File :$r1!, 
    File :$r2!, 
    Str :$out-dir=$*SPEC.catdir($*CWD, 'out')
) {
    mkdir $out-dir unless $out-dir.IO.d;
    my $fh1_in = open $r1;
    my $fh2_in = open $r2;

    # e.g., SRR1647045_1.trim.fastq => SRR1647045_R1.fastq
    (my $basename = $r1) ~~ s/'_1' .*//;
    my $r1_out    = $*SPEC.catfile($out-dir, $basename ~ '_R1.fastq');
    my $r2_out    = $*SPEC.catfile($out-dir, $basename ~ '_R2.fastq');
    my $sing_out  = $*SPEC.catfile($out-dir, $basename ~ '_singletons.fastq');
    my $r1_fh     = open $r1_out, :w;
    my $r2_fh     = open $r2_out, :w;
    my $sing_fh   = open $sing_out, :w;

    my $i = 0;
    loop {
        #put "top o' the loop";
        my $read1 = read_fq($fh1_in);
        my $read2 = read_fq($fh2_in);

        last unless $read1 && $read2;

        #put "read1 ({$read1.num}) read2 ({$read2.num})";

        given ($read1, $read2) {
            when (Fastq, Nil) { $sing_fh.put(~$read1) }

            when (Nil, Fastq) { $sing_fh.put(~$read2) }

            when (Fastq, Fastq) {
                if $read1.num == $read2.num {
                    $r1_fh.put(~$read1);
                    $r2_fh.put(~$read2);
                }
                else {
                    my ($low, $high) = ($read1, $read2).sort(*.num);
                    loop {
                        #put "low ({$low.num}) high ({$high.num})";
                        if $low.num == $high.num {
                            my ($r1, $r2) = 
                              $low.dir == 1 ?? ($low, $high) !! ($high, $low);
                            $r1_fh.put(~$r1);
                            $r2_fh.put(~$r2);
                            last;
                        }
                        else {
                            $sing_fh.put($low);
                            $low = read_fq($low.fh);
                        }
                    }
                }
            }
        }
    }

    put "Done.";
}

sub read_fq (IO::Handle $fh) {
    if $fh.eof {
        return Nil;
    }
    else {
        my ($header, $seq="", $="", $qual="") = $fh.lines;

        return Fastq.new(
            header => ~$header, 
            seq    => ~$seq, 
            qual   => ~$qual, 
            fh     => $fh
        );
    }
}
