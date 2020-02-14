package PWA::BusinessLogic::Rides;

use common::sense;

use Moose;

use Data::FormValidator;

has 'model' => (
    is  => 'ro',
    isa => 'Object',
);

=head2 rides

=cut

sub rides {
    my ($self, $search) = @_;

    return $self->model->get_rides($search);
}

=head2 save_ride

=cut

sub save_ride {
    my ($self, $params) = @_;

    $params->{start_dt}  = sprintf("%s %s", delete $params->{start_on}, delete $params->{start_at});
    $params->{driver_id} = 1;

    $self->model->save_ride($params);

    return 1;
}

=head2 validate

=cut

sub validate {
    my ($self, $params) = @_;

    return Data::FormValidator->check($params, $self->validation_profile);
}

=head2 validation_profile

=cut

sub validation_profile {
    return {
        required => [qw(start_from start_at start_on go_to seats)],
        msgs     => {
            format  => '%s',
            missing => 'missing',
        }
    }
}

1;
