use utf8;
package Compass::Schema::Result::ClientPhone;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Compass::Schema::Result::ClientPhone

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<client_phone>

=cut

__PACKAGE__->table("client_phone");

=head1 ACCESSORS

=head2 client_phone_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 client_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 phone

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "client_phone_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "client_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "phone",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</client_phone_id>

=back

=cut

__PACKAGE__->set_primary_key("client_phone_id");

=head1 RELATIONS

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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2016-10-26 10:20:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+F3zNzJTuY5NUk+VRFR+Ow


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
