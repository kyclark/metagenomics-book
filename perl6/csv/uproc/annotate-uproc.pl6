#!/usr/bin/env perl6

sub MAIN (
    Str :$kegg-out, 
    Str :$pfam-out, 
    Str :$kegg-desc, 
    Str :$pfam-desc, 
    Str :$out="out"
) {
    die "Must have --kegg-out or --pfam-out" unless $kegg-out || $pfam-out;

    my $out-fh = open $out, :w;
    $out-fh.put(<gene_callers_id source accession function e_value>.join("\t"));
    process('kegg', $kegg-out, $kegg-desc, $out-fh);
    process('pfam', $pfam-out, $pfam-desc, $out-fh);
    put "Done, see output '$out'";
}

sub process ($source, $uproc-out, $desc-file, $fh) {
    return unless $uproc-out && $desc-file;
    my %id_to_desc;
    for $desc-file.IO.lines -> $line {
        my ($id, $desc) = $line.split(/\t/);
        %id_to_desc{ $id } = $desc;
    }

    for $uproc-out.IO.lines -> $line {
        my @fields = $line.split(',');
        my $gene   = @fields[1].subst(/'|' .*/, '');
        my $id     = @fields[6];
        my $score  = @fields[7];
        my $desc   = %id_to_desc{ $id } || "NONE";
        $fh.put(join("\t", $gene, $source, $id, $desc, $score));
    }
}
