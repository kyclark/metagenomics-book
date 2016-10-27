use utf8;
package Compass::Schema::Result::CaseWorker;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Compass::Schema::Result::CaseWorker

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<case_worker>

=cut

__PACKAGE__->table("case_worker");

=head1 ACCESSORS

=head2 case_worker_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "case_worker_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);

=head1 PRIMARY KEY

=over 4

=item * L</case_worker_id>

=back

=cut

__PACKAGE__->set_primary_key("case_worker_id");

=head1 RELATIONS

=head2 clients

Type: has_many

Related object: L<Compass::Schema::Result::Client>

=cut

__PACKAGE__->has_many(
  "clients",
  "Compass::Schema::Result::Client",
  { "foreign.case_worker_id" => "self.case_worker_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2016-10-26 13:49:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LU5BsglN8greCTIUfAwHtQ
#
sub clients {
    my $self = shift;
    return $self->case_worker_to_clients->search;
}

sub num_clients {
    my $self = shift;
    return $self->clients->count;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
