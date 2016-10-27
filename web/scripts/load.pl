#!/usr/bin/env perl

use lib '../lib';
use DateTime;
use Data::Dump 'dump';
use Date::Parse 'str2time';
use feature 'say';
use Compass::DB;
use Text::RecordParser;

my $schema = Compass::DB->new->schema;
#clients($schema);
household($schema);

sub household {
    my $schema = shift;
    my $file   = 'tbl_Other_HH_Members.csv';
    my $p      = Text::RecordParser->new($file);

    $p->field_filter( sub { $_ = shift; s/^"|"$//g; $_ } );

    my %fld_map = (
        first_name   => 'First Name',
        last_name    => 'Last Name',
        sex          => 'Sex',
        relationship => 'Relationship',
        race         => 'Race',
        ethnicity    => 'Ethnicity',
    );

    my %bool_flds = (
        is_disabled => 'Disabled?',
    );

    my %date_flds = (
        dob => 'DOB',
    );

    my $i = 0;
    REC:
    while (my $rec = $p->fetchrow_hashref) {
        my $case_num = $rec->{'Case#'} or next;
        my ($Client) = $schema->resultset('Client')->search({
            case_num => $case_num
        });

        unless ($Client) {
            say STDERR "Can't find case_num '$case_num'";
            next REC;
        }

        my $fname = $rec->{'First Name'} || '';
        my $lname = $rec->{'Last Name'}  || '';

        my ($Dependent) = $schema->resultset('Dependent')->find_or_create({
            client_id   => $Client->id,
            first_name  => $fname,
            last_name   => $lname,
        });

        printf "%5d: dep %s (%s)\n", ++$i, join(' ', $fname, $lname), $Dependent->id;
        while (my ($fld, $alias) = each %fld_map) {
            say "checking $alias";
            my $val = $rec->{ $alias };
            next unless $val =~ /\S+/;
            say "$fld => '$val'";
            $Dependent->$fld( $val );
        }

        while (my ($fld, $alias) = each %bool_flds) {
            my $val = $rec->{ $alias };
            next unless $val =~ /\S+/;
            say "checking $alias '$val'";

            if ($val =~ /^([yn])/i) {
                $val = uc $1;
            }
            elsif ($val == '1') {
                $val = 'Y'
            }
            elsif ($val == '0') {
                $val = 'N'
            }

            say "$fld => '$val'";
            $Dependent->$fld( $val );
        }

        while (my ($fld, $alias) = each %date_flds) {
            my $val = $rec->{ $alias };
            next unless $val =~ /\S+/;

            my $dt = DateTime->from_epoch(epoch => str2time($val));
            say "$fld => ", $dt->ymd;

            $Dependent->$fld( $dt->ymd );
        }

        $Dependent->update;
    }

    say "Done, imported $i household members";
}

sub clients {
    my $schema = shift;
    my $file   = 'tbl_Client_Data.csv';
    my $p      = Text::RecordParser->new($file);

    $p->field_filter( sub { $_ = shift; s/^"|"$//g; $_ } );

    my %fld_map = (
        aka => 'AKA',
        first_name => 'First Name',
        last_name => 'Last Name',
        sex => 'Sex',
        race => 'Race',
        email => 'Email',
        ethnicity => 'Ethnicity',
        marital_status => 'Marital Status',
        address_street => 'Finding Address',
        address_city => 'FindingCity',
        address_state => '',
        address_zip => 'Zipcode',
        notes => 'Notes:'
    );

    my %bool_flds = (
        is_employed => 'Employed',
        is_disabled => 'Disabled?',
        is_homeless => 'Homeless',
    );

    my %date_flds = (
        dob => 'DOB',
        original_date_service => 'OriginalDateService',
    );

    my $i = 0;
    REC:
    while (my $rec = $p->fetchrow_hashref) {
        $i++;
        my $fname    = $rec->{'First Name'} || '';
        my $lname    = $rec->{'Last Name'}  || '';
        my $case_num = $rec->{'Case#'}      || '';

        my $Client;
        if (my $case_num = $rec->{'Case#'}) {
            $Client = $schema->resultset('Client')->find_or_create({
                case_num => $case_num,
            });
        }
        elsif ($fname && $lname) {
            $Client = $schema->resultset('Client')->find_or_create({
                first_name => $fname,
                last_name  => $lname,
            });
        }

        unless ($Client) {
            say STDERR "$i: Cound't find this guy.";
            say STDERR dump($rec);
            next REC;
        }

        printf "%5d: client %s (%s)\n", 
            $i, join(' ', $fname, $lname), $Client->id;
        #say dump($rec);

        while (my ($fld, $alias) = each %fld_map) {
            say "checking $alias";
            my $val = $rec->{ $alias };
            next unless $val =~ /\S+/;
            if ($alias =~ /\?$/) {
                $val = $val =~ /^[Yy]/ ? 'Y' : 'N';
            }

            say "$fld => '$val'";
            $Client->$fld( $val );
        }

        while (my ($fld, $alias) = each %bool_flds) {
            my $val = $rec->{ $alias };
            next unless $val =~ /\S+/;
            say "checking $alias '$val'";

            if ($val =~ /^([yn])/i) {
                $val = uc $1;
            }
            elsif ($val == '1') {
                $val = 'Y'
            }
            elsif ($val == '0') {
                $val = 'N'
            }

            say "$fld => '$val'";
            $Client->$fld( $val );
        }

        while (my ($fld, $alias) = each %date_flds) {
            my $val = $rec->{ $alias };
            next unless $val =~ /\S+/;

            my $dt = DateTime->from_epoch(epoch => str2time($val));
            say "$fld => ", $dt->ymd;

            $Client->$fld( $dt->ymd );
        }

        unless ($Client->address_state) {
            $Client->address_state('AZ');
        }

        if (my $case_worker = $rec->{'CaseWorkerName'}) {
            say "Adding case worker '$case_worker'";
            my $CaseWorker = $schema->resultset('CaseWorker')->find_or_create({
                name => $case_worker
            });
            $Client->case_worker_id($CaseWorker->id);
        }

        $Client->update;

        if (my $phone = $rec->{'Phone#'}) {
            say "Adding phone '$phone'";
            my $Phone = $schema->resultset('ClientPhone')->find_or_create({
                client_id => $Client->id,
                phone     => $phone,
            });
        }
    }

    say "Done, imported $i clients";
}
