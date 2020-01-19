package PWA::BusinessLogic::Rides;

use common::sense;

use Moose;

use PWA::Model::Ride;

use Data::FormValidator;

=head2 rides

=cut

sub rides {
    my ($self, $model) = @_;

    return map { PWA::Model::Ride->new( data => $_ ) } $model->get;
}

=head2 save_ride

=cut

sub save_ride {
    my ($self, $model, $params) = @_;

    $model->add($params);

    return 1;
}

=head2 validate

=cut

sub validate {
    my ($self, $params) = @_;

    return Data::FormValidator->check($params, PWA::Model::Ride->new->validation_profile);
}

1;