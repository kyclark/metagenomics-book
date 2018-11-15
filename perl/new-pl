#!/usr/bin/env perl

=head1 NAME

new-pl - stub out a new Perl script

=head1 SYNOPSIS

  new-pl <script-name-or-path> [description]

Options:

  -n|--name        You full name ("John Smith")
  -e|--email       Your email address
  -c|--copyright   Who gets the copyright
  -p|--perl        Preferred Perl for shebang line
  --help           Show brief help and exit

=head1 DESCRIPTION

This script will stub out a new Perl script with POD sections and
basic optional handling and usage printing.

Unless the script name is an absolute path (e.g., "/tmp/foo"), the
created script will be placed into the current working directory.  An
optional description can be provided to place into the POD.

You can put all the above options into a "~/.newplrc" file, e.g.:

    full_name=Ken Youens-Clark
    email=kyclark@email.arizona.edu
    perl_path=/uaopt/perl/5.14.2/bin/perl
    copyright=Hurwitz Lab

=head1 AUTHOR

Ken Youens-Clark E<lt>kyclark@gmail.com<gt>.

=head1 COPYRIGHT

Copyright (c) Ken Youens-Clark

This library is free software;  you can redistribute it and/or modify 
it under the same terms as Perl itself.

=cut

# --------------------------------------------------

use common::sense;
use Cwd;
use Config;
use English qw(-no_match_vars);
use Env qw($EDITOR);
use File::Basename;
use File::Spec::Functions;
use Getopt::Long;
use IO::Prompt;
use Template;
use Perl6::Slurp;
use Readonly;

main();

# --------------------------------------------------
sub main {
    my %default       = get_defaults();
    my $user_name     = $default{'user_name'}     || 'Larry Wall';
    my $full_name     = $default{'full_name'}     || $user_name;
    my $copyright     = $default{'copyright'}     || $user_name;
    my $perl_path     = $default{'perl_path'}     || '/usr/bin/env perl';
    my $email_address = $default{'email_address'} 
                     || "$user_name\@email.arizona.edu",

    my $help;
    GetOptions(
        'n|name:s'      => \$full_name,
        'e|email:s'     => \$email_address,
        'c|copyright:s' => \$copyright,
        'p|perl:s'      => \$perl_path,
        'help'          => \$help,
    );

    #
    # Can't use Pod::Usage as it gets confused by the POD in the template.
    #
    if ($help) {
        my $prog = basename($PROGRAM_NAME);
        printf qq(Usage:\n\t%s <script> [description]\n\nSee perldoc "%s".\n),
            $prog, $prog;
        exit 0;
    }

    my $fname  = shift @ARGV or die "No file name\n";
    my $desc   = shift @ARGV || 'a script';
    my $editor = $EDITOR     || 'vim';

    my $path;
    if (file_name_is_absolute($fname)) {
        $path  = $fname;
        $fname = basename($fname);
    }
    else {
        $path = catfile(cwd(), $fname);
    }

    if (-e $path) {
        unless (prompt( -yn, "'$path' exists.\nOK to overwrite? ")) {
            print "Exiting.\n"; 
            exit 0;
        }
    }


    my $t        = Template->new;
    my $template = slurp \*DATA;
    my $output; 

    $t->process( 
        \$template, 
        {
            fname         => $fname,
            desc          => $desc, 
            full_name     => $full_name,
            user_name     => $user_name,
            email_address => $email_address,
            perl_path     => $perl_path,
            copyright     => $copyright,
            year          => (localtime)[5] + 1900,
        },
        \$output
    ) or die $t->error;

    open my $fh, ">$path" or die "Can't write to '$path': $!\n";
    print $fh $output;
    close $fh;

    chmod oct 775, $path;

    my $cmd = sprintf "$editor%s$path", ( $editor =~ /vim?$/ ) ? ' +24 ' : q{ };
    exec $cmd or die "Couldn't exec '$cmd': $!\n";
}

# --------------------------------------------------
sub get_defaults {
    my ($name, $passwd, $uid, $gid, $quota, $comment, $gcos,
        $home_dir, $shell) = getpwuid $EFFECTIVE_USER_ID;

    my %defaults = (
        user_name => $name,
        full_name => $gcos || $name,
    );

    my $rc = catfile($home_dir, '.newplrc');
    if (-e $rc) {
        if (open my $fh, '<', $rc) {
            while (<$fh>) {
                if ( /^(\w+)\s*=\s*(.*)$/ ) {
                    $defaults{ $1 } = $2;
                }
            }
        }
    }

    return %defaults;
}

# --------------------------------------------------

__DATA__
[%- SET pod_prefix = '='       -%]
[%- SET end_tag    = '__END__' -%]
#![% perl_path %]

use common::sense;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Readonly;

main();

# --------------------------------------------------
sub main {
    my %args = get_args();

    if ($args{'help'} || $args{'man_page'}) {
        pod2usage({
            -exitval => 0,
            -verbose => $args{'man_page'} ? 2 : 1
        });
    }; 

    say "OK";
}

# --------------------------------------------------
sub get_args {
    my %args;
    GetOptions(
        \%args,
        'help',
        'man',
    ) or pod2usage(2);

    return %args;
}

[% end_tag %]

# --------------------------------------------------

[% pod_prefix %]pod

[% pod_prefix %]head1 NAME

[% fname %][% IF desc; " - $desc"; END %]

[% pod_prefix %]head1 SYNOPSIS

  [% fname %] 

Options:

  --help   Show brief help and exit
  --man    Show full documentation

[% pod_prefix %]head1 DESCRIPTION

Describe what the script does, what input it expects, what output it
creates, etc.

[% pod_prefix %]head1 SEE ALSO

perl.

[% pod_prefix %]head1 AUTHOR

[% full_name %] E<lt>[% email_address %]E<gt>.

[% pod_prefix %]head1 COPYRIGHT

Copyright (c) [% year %] [% copyright OR full_name %]

This module is free software; you can redistribute it and/or
modify it under the terms of the GPL (either version 1, or at
your option, any later version) or the Artistic License 2.0.
Refer to LICENSE for the full license text and to DISCLAIMER for
additional warranty disclaimers.

[% pod_prefix %]cut
