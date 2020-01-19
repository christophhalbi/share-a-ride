package PWA::Model;

use common::sense;

use Moose;

has 'source' => (
    is => 'ro',
);

sub get {
    my $self = shift;

    return ($self->source->{rides} or ());
}

sub add {
    my ($self, $data) = @_;

    push @{ $self->source->{rides} }, $data;

    return;
}

1;