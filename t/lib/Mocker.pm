package Mocker;

use Moose;

use Test::MockObject;

sub mock {
    my ($self, $class, %mocks) = @_;

    my $mock = Test::MockObject->new;

    $mock->fake_module ($class,
        new   => sub {
            return bless {}, shift;
        },
        %mocks
    );

    return $mock;
}

1;