package PWA::Model;

use common::sense;

use Moose;

has 'source' => (
    is => 'ro',
);

sub get_rides {
    my $self = shift;

    return $self->source->resultset('Ride')->all;
}

sub save_ride {
    my ($self, $data) = @_;

    $self->source->resultset('Ride')->create($data);

    return;
}

1;
