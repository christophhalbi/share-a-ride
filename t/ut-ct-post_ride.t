use common::sense;

use lib 't/lib';

use Mocker;

use Catalyst::Test 'PWA';
use HTTP::Request::Common;
use JSON qw(from_json);
use Test::More;

my $mocker = Mocker->new;

subtest "post_ride empty" => sub {

    my $response = request POST '/post_ride', [];
    ok $response->is_success;

    is_deeply(
        from_json($response->decoded_content),
        {
            validation_errors => {
                from  => 'missing',
                to    => 'missing',
                on    => 'missing',
                at    => 'missing',
                seats => 'missing',
            },
        },
    );
};

subtest "post_ride" => sub {

    my $response = request POST '/post_ride', [
        from  => 'Linz',
        to    => 'Leonding',
        on    => '2019-01-01',
        at    => '11:00',
        seats => '2',
    ];
    ok $response->is_success;

    is_deeply(
        from_json($response->decoded_content),
        {
            saved             => 1,
            validation_errors => {},
        },
    );
};

done_testing();