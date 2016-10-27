#!/usr/bin/env perl

use strict;
use lib '../lib';
use DateTime;
use Data::Dump 'dump';
use Date::Parse 'str2time';
use feature 'say';
use Compass::DB;
use Text::RecordParser;

my $schema = Compass::DB->new->schema;
case_workers($schema);
clients($schema);
dependents($schema);

sub case_workers {
    my $schema = shift;
    my $file   = 'data/case_worker.csv';
    my $p      = Text::RecordParser->new($file);

    my $i = 0;
    REC:
    while (my $rec = $p->fetchrow_hashref) {
        my ($CaseWorker) = $schema->resultset('CaseWorker')->find_or_create({
            name => $rec->{'name'}
        });

        printf "%5d: cw %s (%s)\n", ++$i, $CaseWorker->name, $CaseWorker->id;
    }

    say "Done, imported $i case workers";
}

sub dependents {
    my $schema = shift;
    my $file   = 'data/dependent.csv';
    my $p      = Text::RecordParser->new($file);

    my $i = 0;
    REC:
    while (my $rec = $p->fetchrow_hashref) {
        my $case_num = $rec->{'case_num'} or next;
        my ($Client) = $schema->resultset('Client')->search({
            case_num => $case_num
        });

        unless ($Client) {
            say STDERR "Can't find case_num '$case_num'";
            next REC;
        }

        my ($Dependent) = $schema->resultset('Dependent')->find_or_create({
            client_id   => $Client->id,
            first_name  => $rec->{'first_name'},
            last_name   => $rec->{'last_name'},
        });

        $Dependent->update;

        printf "%5d: dep %s (%s)\n", 
            ++$i, 
            join(' ', $Dependent->first_name, $Dependent->last_name), 
            $Dependent->id;
    }

    say "Done, imported $i dependents";
}

sub clients {
    my $schema = shift;
    my $file   = 'data/client.csv';
    my $p      = Text::RecordParser->new($file);

    $p->field_filter( sub { $_ = shift; s/^"|"$//g; $_ } );

    my $i = 0;
    REC:
    while (my $rec = $p->fetchrow_hashref) {
        my $case_num = $rec->{'case_num'} or next;

        my $Client = $schema->resultset('Client')->find_or_create({
            case_num => $case_num,
        });

        unless ($Client) {
            say STDERR "$i: Cound't find this guy.";
            say STDERR dump($rec);
            next REC;
        }

        printf "%5d: client %s (%s)\n", 
            ++$i, 
            join(' ', $rec->{'first_name'}, $rec->{'last_name'}), 
            $Client->id;

        for my $fld (
            qw[first_name last_name address_city address_street
            address_state address_zip]
        ) {
            my $val = $rec->{ $fld } or next;
            $Client->$fld( $val );
        }

        if (my $case_worker = $rec->{'case_worker'}) {
            my $CaseWorker = $schema->resultset('CaseWorker')->find_or_create({
                name => $case_worker
            });
            $Client->case_worker_id($CaseWorker->id);
        }

        $Client->update;

        if (my $phone = $rec->{'phone'}) {
            say "Adding phone '$phone'";
            my $Phone = $schema->resultset('ClientPhone')->find_or_create({
                client_id => $Client->id,
                phone     => $phone,
            });
        }
    }

    say "Done, imported $i clients";
}
