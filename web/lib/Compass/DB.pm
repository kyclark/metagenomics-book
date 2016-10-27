package Compass::DB;

use Compass::Config;
use Compass::Schema;
use DBI;
use Moose;
use Data::Dump 'dump';

has config     => (
    is         => 'rw',
    isa        => 'Compass::Config',
    lazy_build => 1,
);

has dbd => (
    is         => 'rw',
    isa        => 'Str',
    default    => 'mysql',
    predicate  => 'has_dbd',
);

has dbh => (
    is         => 'rw',
    isa        => 'DBI::db',
    lazy_build => 1,
);

has dsn => (
    is         => 'rw',
    isa        => 'Str',
    lazy_build => 1,
);

has db_options => (
    is         => 'rw',
    isa        => 'HashRef',
    default    => sub { { RaiseError => 1, mysql_enable_utf8 => 1 } },
);

has host => (
    is         => 'rw',
    isa        => 'Str',
    default    => 'localhost',
);

has name => (
    is         => 'rw',
    isa        => 'Str',
    default    => 'imicrobe',
    predicate  => 'has_name',
);

has password   => (
    is         => 'rw',
    isa        => 'Str',
    lazy_build => 1,
);

has schema => (
    is         => 'ro',
    isa        => 'DBIx::Class::Schema',
    lazy_build => 1,
);

has user => (
    is         => 'rw',
    isa        => 'Str',
    default    => 'imicrobe',
    predicate  => 'has_user',
);

# ----------------------------------------------------------------
sub BUILD {
    my $self    = shift;
    my $opts    = shift || {};
    my $config  = $opts->{'config'} || $self->config;
    my $db_conf = $config->get('db');

    if (my $user = $opts->{'user'} || $db_conf->{'user'}) {
        $self->user($user);
    }

    if (my $password = $opts->{'password'} || $db_conf->{'password'}) {
        $self->password($password);
    }

    if (my $name = $opts->{'name'} || $db_conf->{'name'}) {
        $self->name($name);
    }

    if (my $host = $opts->{'host'} || $db_conf->{'host'}) {
        $self->host($host);
    }

    if (!$self->has_dsn) {
        my $host = $self->host || 'localhost';
        my $name = $self->name;

        $self->dsn(
            sprintf( "dbi:%s:%s",
                $self->dbd,
                $host ? "database=$name;host=$host" : $name
            )
        );
    }
}

# ----------------------------------------------------------------
sub _build_config {
    return Compass::Config->new;
}

# ----------------------------------------------------------------
sub _build_dbh {
    my $self = shift;
    my $dbh;

    eval {
        $dbh = DBI->connect(
            $self->dsn, 
            $self->user, 
            $self->password, 
            $self->db_options
        );
    };

    if ( my $err = $@ ) {
        die "Error: $err";
    }
    else {
        return $dbh;
    }
}

# ----------------------------------------------------------------
sub _build_schema {
    my $self = shift;

    return Compass::Schema->connect( sub { $self->dbh } );
}

1;
