use utf8;
package Compass::Schema::Result::Dependent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Compass::Schema::Result::Dependent

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<dependent>

=cut

__PACKAGE__->table("dependent");

=head1 ACCESSORS

=head2 dependent_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 client_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 sex

  data_type: 'enum'
  default_value: 'U'
  extra: {list => ["U","M","F"]}
  is_nullable: 1

=head2 relationship

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 dob

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 ethnicity

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 race

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 is_disabled

  data_type: 'enum'
  default_value: 'N'
  extra: {list => ["Y","N"]}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "dependent_id",
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
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "sex",
  {
    data_type => "enum",
    default_value => "U",
    extra => { list => ["U", "M", "F"] },
    is_nullable => 1,
  },
  "relationship",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "dob",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "ethnicity",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "race",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "is_disabled",
  {
    data_type => "enum",
    default_value => "N",
    extra => { list => ["Y", "N"] },
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</dependent_id>

=back

=cut

__PACKAGE__->set_primary_key("dependent_id");

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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2016-10-26 13:57:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qKYUbRcA3iOpwMMlDiBDMQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
