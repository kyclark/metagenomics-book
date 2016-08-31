#!/usr/bin/env perl6

use File::Temp;
use JSON::Tiny;

# http://www.ncbi.nlm.nih.gov/books/NBK25499/
constant $PUBMED_URL = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/'
                     ~ 'esummary.fcgi?db=pubmed&retmode=json&id=';

sub MAIN (Int $pubmed-id=27208118) {
    my ($tmpfile, $tmpfh) = tempfile();
    $tmpfh.close;
    run(«wget --quiet -O $tmpfile "$PUBMED_URL$pubmed-id"»);
    my $json = $tmpfile.IO.slurp;
    my $data = from-json($json);
    $tmpfile.IO.unlink;

    if $data{'result'}{$pubmed-id}.defined {
        my %pubmed = $data{'result'}{$pubmed-id};
        put "$pubmed-id = %pubmed{'title'} (%pubmed{'lastauthor'})";
    }
    else {
        put "Cannot find PubMed ID '$pubmed-id'";
        exit 1;
    }
}
