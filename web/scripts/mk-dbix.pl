#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use feature 'say';
use DBIx::Class::Schema::Loader qw/ make_schema_at /;
use FindBin '$Bin';
use File::Path 'mkpath';
use File::Spec::Functions 'canonpath';
use Getopt::Long;
use Compass::DB;
use Pod::Usage;
use Readonly;

#my $out_dir = canonpath("$Bin/../lib");
my $out_dir = "/usr/local/compass/lib";
my $debug   = 0;
my ( $help, $man_page );
GetOptions(
    'd|debug' => \$debug,
    'help'    => \$help,
    'man'     => \$man_page,
) or pod2usage(2);

if ( $help || $man_page ) {
    pod2usage({
        -exitval => 0,
        -verbose => $man_page ? 2 : 1
    });
}; 

if (!-d $out_dir) {
    mkpath $out_dir;
}

my $db = Compass::DB->new;

make_schema_at(
    'Compass::Schema',
    {
        debug          => 0,
        dump_directory => $out_dir,
        use_moose      => 1,
        overwrite_modifications => 1,
    },
    [ $db->dsn, $db->user, $db->password ]
);

__END__

# ----------------------------------------------------

=pod

=head1 NAME

mk-dbix.pl - creates the DBIx::Schema classes

=head1 SYNOPSIS

  mk-dbix.pl 

Options:

  -o|--out    Output directory (defaults to ../lib)
  -d|--debug  Show debug info
  --help      Show brief help and exit
  --man       Show full documentation

=head1 DESCRIPTION

Reads the configured "imicrobe" db and creates the DBIx::Class schema.

=head1 SEE ALSO

DBIx::Class.

=head1 AUTHOR

Ken Youens-Clark E<lt>E<gt>.

=head1 COPYRIGHT

Copyright (c) 2014 Ken Youens-Clark

This module is free software; you can redistribute it and/or
modify it under the terms of the GPL (either version 1, or at
your option, any later version) or the Artistic License 2.0.
Refer to LICENSE for the full license text and to DISCLAIMER for
additional warranty disclaimers.

=cut
