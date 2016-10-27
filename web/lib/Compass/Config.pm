package Compass::Config;

use namespace::autoclean;
use Carp qw( croak );
use File::Basename qw( dirname );
use File::Spec::Functions;
use Moose::Util::TypeConstraints;
use Moose;
use YAML qw( LoadFile );

subtype 'ExistingFile'
    => as 'Str' 
    => where   { -f $_ && -r _ && -s _ }
    => message { 'File must exist and be non-empty' } 
;

has default_filename => (
    is      => 'ro',
    default => '/usr/local/compass/lib/conf/compass.yaml',
);

has config     => (
    is         => 'ro',
    isa        => 'HashRef',
    lazy_build => 1,
);

has filename   => (
    is         => 'rw',
    isa        => 'ExistingFile',
    lazy_build => 1,
    trigger    => sub { 
        my $self = shift;
        $self->clear_config(@_);
    },
);

#
# Allow for calling "->new( $filename )" 
#
around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( filename => $_[0] );
    }
    else {
        return $class->$orig(@_);
    }
};

# ----------------------------------------------------------------
sub _build_filename {
    my $self = shift;

    $self->clear_config;

    return $_[0] || $ENV{'IMICROBE_CONF'} || $self->default_filename;
}

# ----------------------------------------------------------------
sub _build_config {
    my $self = shift;
    my $file = $self->filename or croak('No filename');
    my $conf = LoadFile($file) or croak("Error reading config file: '$file'");
    
    return $conf;
}

# ----------------------------------------------------------------
sub get {
    my $self   = shift;
    my $config = $self->config;
    
    if ( my $section_name = shift ) {
        if ( defined $config->{ $section_name } ) {
            if ( my $value = $config->{ $section_name } ) {
                # If we want an array AND our value is an array or a hash, 
                # dereference it and hand it back
                if ( wantarray && ref $value eq 'ARRAY' ) {
                    return @$value;
                } 
                elsif ( wantarray && ref $value eq 'HASH' ) {
                    return %$value;
                }
                # otherwise (don't want an array, or don't know what it is), 
                # just return as is
                else {
                    return $value;
                }
            }
            else {
                return wantarray ? () : '';
            }
        }
        else {
            croak(sprintf("No config section named '%s' in '%s'",
                $section_name, $self->filename
            ));
        }
    }
    else {
        return $config;
    }
}

__PACKAGE__->meta->make_immutable;

1;

__END__

# ----------------------------------------------------------------

=pod

=head1 NAME

Compass::Config - Read local configuration information

=head1 SYNOPSIS

  use Compass::Conf;

  my $config  = Compass::Conf->new;
  my $db_info = $config->get('db');

=head1 DESCRIPTION

Certain configuration items are specific to the machine they are 
deployed on, and should, therefore, be available locally to the apps 
that need them without any code changing.  With this module, only the
one location of the configuration file needs to be changed, and then
all the calling modules can read the correct info.  

This module relies on Config::General, so perldoc that module for more
information on how the configuration options can be set.  It is hoped
that module-specific information (e.g., for QTL, mutants, etc.) will
be wrapped in specific tags (e.g., "<qtl>...</qtl>") to logically
group like elements.

=head1 METHODS

=head2 new

Constructor for object.  Takes an optional "filename" argument of the 
path to the configuration file.

  my $config = Gramene::Conf->new( filename => '/path/to/config.conf' );

Or:

  my $config = Gramene::Conf->new('/path/to/config.conf');

=head2 filename

Gets or sets the complete path to the configuration file.  If a file is
already opened, then the handle on it will be closed and a new one
opened on the new file.

  $config->filename('/path/to/config.conf');

=head2 get

Returns one or all options from the config file.

  my $foo = $config->get('foo');
  
=head2 config

Returns the full config hashref.

  my $conf_hashref = $config->config;

=head1 AUTHOR

Ken Youens-Clark E<lt>kclark@cshl.orgE<gt>.

=head1 COPYRIGHT

Copyright (c) 2012 Cold Spring Harbor Laboratory

This library is free software;  you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
