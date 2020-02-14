package PWA::Model;

use common::sense;

use Moose;

has 'source' => (
    is => 'ro',
);

sub get_rides {
    my ($self, $search) = @_;

    my $resultset = $self->source->resultset('Ride');

    $resultset = $resultset->search_by($search) if $search;

    return $resultset->all;
}

sub save_ride {
    my ($self, $data) = @_;

    $self->source->resultset('Ride')->create($data);

    return;
}

1;
