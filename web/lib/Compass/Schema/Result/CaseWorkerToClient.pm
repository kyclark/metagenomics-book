use utf8;
package Compass::Schema::Result::CaseWorkerToClient;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Compass::Schema::Result::CaseWorkerToClient

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<case_worker_to_client>

=cut

__PACKAGE__->table("case_worker_to_client");

=head1 ACCESSORS

=head2 case_worker_to_client_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 case_worker_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 client_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "case_worker_to_client_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "case_worker_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "client_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</case_worker_to_client_id>

=back

=cut

__PACKAGE__->set_primary_key("case_worker_to_client_id");

=head1 RELATIONS

=head2 case_worker

Type: belongs_to

Related object: L<Compass::Schema::Result::CaseWorker>

=cut

__PACKAGE__->belongs_to(
  "case_worker",
  "Compass::Schema::Result::CaseWorker",
  { case_worker_id => "case_worker_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);

=head2 client

Type: belongs_to

Related object: L<Compass::Schema::Result::Client>

=cut

__PACKAGE__->belongs_to(
  "client",
  "Compass::Schema::Result::Client",
  { client_id => "client_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2016-10-26 10:15:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4fW0egb7wdmGLDByvtBh+g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
