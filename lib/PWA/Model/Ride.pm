package PWA::Model::Ride;

use common::sense;

use Moose;

has 'data' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { {} },
);

=head2 as_json

=cut

sub as_json {
    my $self = shift;

    return $self->data;
}

=head2 validation_profile

=cut

sub validation_profile {
    return {
        required => [qw(from to at on seats)],
        msgs     => {
            format  => '%s',
            missing => 'missing',
        }
    }
}

1;