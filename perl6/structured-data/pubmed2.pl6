#!/usr/bin/env perl6

use LWP::Simple;
use JSON::Tiny;

# http://www.ncbi.nlm.nih.gov/books/NBK25499/
constant $PUBMED_URL = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/'
                     ~ 'esummary.fcgi?db=pubmed&retmode=json&id=';

sub MAIN (Int $pubmed-id=27208118) {
    my $lwp  = LWP::Simple.new;
    my $json = $lwp.get("$PUBMED_URL$pubmed-id");
    my $data = from-json($json);

    if my %pubmed = $data{'result'}{$pubmed-id} {
        put "$pubmed-id = %pubmed{'title'} (%pubmed{'lastauthor'})";
    }
    else {
        put "Cannot find PubMed ID '$pubmed-id'";
        exit 1;
    }
}
