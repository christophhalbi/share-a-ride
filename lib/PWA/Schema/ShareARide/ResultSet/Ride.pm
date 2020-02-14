package PWA::Schema::ShareARide::ResultSet::Ride;

use common::sense;

use base 'DBIx::Class::ResultSet';

sub search_by {
    my ($self, $search) = @_;

    return $self->search(
        {
            -or => [
                'go_to'       => { ilike => "%$search%" },
                'start_from'  => { ilike => "%$search%" },
                'driver.name' => { ilike => "%$search%" },
            ],
        },
        {
            join => [qw(driver)],
        }
    );
}

1;
