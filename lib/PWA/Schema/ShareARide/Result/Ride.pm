use utf8;
package PWA::Schema::ShareARide::Result::Ride;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PWA::Schema::ShareARide::Result::Ride

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<rides>

=cut

__PACKAGE__->table("rides");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'rides_id_seq'

=head2 driver_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 start_from

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 start_dt

  data_type: 'timestamp'
  is_nullable: 0

=head2 go_to

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 seats

  data_type: 'numeric'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "rides_id_seq",
  },
  "driver_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "start_from",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "start_dt",
  { data_type => "timestamp", is_nullable => 0 },
  "go_to",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "seats",
  { data_type => "numeric", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 driver

Type: belongs_to

Related object: L<PWA::Schema::ShareARide::Result::Driver>

=cut

__PACKAGE__->belongs_to(
  "driver",
  "PWA::Schema::ShareARide::Result::Driver",
  { id => "driver_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-01-24 12:43:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mNwtxSVaPy3jLMFl+ollMw


=head2 as_json

=cut

sub as_json {
    my $self = shift;

    my $driver = $self->has_column_loaded('driver_id') ? $self->driver : undef;

    return {
        $self->get_columns,
        ( $driver
            ? (
                driver => $driver->name,
            )
            : ()
        )
    };
}

__PACKAGE__->meta->make_immutable;
1;
