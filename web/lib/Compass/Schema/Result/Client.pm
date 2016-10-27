use utf8;
package Compass::Schema::Result::Client;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Compass::Schema::Result::Client

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<client>

=cut

__PACKAGE__->table("client");

=head1 ACCESSORS

=head2 client_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 case_worker_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=head2 case_num

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 aka

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 dob

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 sex

  data_type: 'enum'
  default_value: 'U'
  extra: {list => ["U","M","F"]}
  is_nullable: 1

=head2 ethnicity

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 race

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 is_homeless

  data_type: 'enum'
  default_value: 'N'
  extra: {list => ["Y","N"]}
  is_nullable: 1

=head2 is_disabled

  data_type: 'enum'
  default_value: 'N'
  extra: {list => ["Y","N"]}
  is_nullable: 1

=head2 is_employed

  data_type: 'enum'
  default_value: 'N'
  extra: {list => ["Y","N"]}
  is_nullable: 1

=head2 marital_status

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 original_date_service

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 address_street

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 address_city

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 address_state

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 address_zip

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 notes

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "client_id",
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
    is_nullable => 1,
  },
  "case_num",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "aka",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "dob",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "sex",
  {
    data_type => "enum",
    default_value => "U",
    extra => { list => ["U", "M", "F"] },
    is_nullable => 1,
  },
  "ethnicity",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "race",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "is_homeless",
  {
    data_type => "enum",
    default_value => "N",
    extra => { list => ["Y", "N"] },
    is_nullable => 1,
  },
  "is_disabled",
  {
    data_type => "enum",
    default_value => "N",
    extra => { list => ["Y", "N"] },
    is_nullable => 1,
  },
  "is_employed",
  {
    data_type => "enum",
    default_value => "N",
    extra => { list => ["Y", "N"] },
    is_nullable => 1,
  },
  "marital_status",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "original_date_service",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "address_street",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "address_city",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "address_state",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "address_zip",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "notes",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</client_id>

=back

=cut

__PACKAGE__->set_primary_key("client_id");

=head1 RELATIONS

=head2 case_worker

Type: belongs_to

Related object: L<Compass::Schema::Result::CaseWorker>

=cut

__PACKAGE__->belongs_to(
  "case_worker",
  "Compass::Schema::Result::CaseWorker",
  { case_worker_id => "case_worker_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);

=head2 client_phones

Type: has_many

Related object: L<Compass::Schema::Result::ClientPhone>

=cut

__PACKAGE__->has_many(
  "client_phones",
  "Compass::Schema::Result::ClientPhone",
  { "foreign.client_id" => "self.client_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dependents

Type: has_many

Related object: L<Compass::Schema::Result::Dependent>

=cut

__PACKAGE__->has_many(
  "dependents",
  "Compass::Schema::Result::Dependent",
  { "foreign.client_id" => "self.client_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2016-10-26 13:57:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fBWNhrCjqVIa6yfHmh5vvQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
