package PWA::BusinessLogic::Rides;

use common::sense;

use Moose;

use PWA::Model::Ride;

=head2 rides

=cut

sub rides {
    my ($self, $model) = @_;

    return map { PWA::Model::Ride->new( data => $_ ) } $model->get;
}

1;