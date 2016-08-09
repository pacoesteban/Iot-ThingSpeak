use strict;
use Test::More;
use Test::LWP::UserAgent;

BEGIN {
    use_ok('IoT::ThingSpeak');
}

can_ok( 'IoT::ThingSpeak', qw(api_key _ua) );

my $test_ua = Test::LWP::UserAgent->new;
$test_ua->map_response(
    qr{/channels/public.json},
    HTTP::Response->new(
        '200',
        HTTP::Status::status_message('200'),
        [ 'Content-Type' => 'application/json' ],
        '{
              "pagination":
              {
                "current_page": 1,
                "per_page": 15,
                "total_entries": 653
              },
              "channels":
              [
                {
                  "id": 9,
                  "name": "my_house",
                  "description": "Netduino Plus connected to sensors around the house",
                  "latitude": "40.44",
                  "longitude": "-79.996",
                  "created_at": "2010-12-13T20:20:06-05:00",
                  "elevation": "",
                  "last_entry_id": 6062691,
                  "ranking" :100,
                  "username":"hans",
                  "tags":
                  [
                    {
                      "id": 9,
                      "name": "temp"
                    },{
                      "id": 25,
                      "name": "light"
                    }
                  ]
                },
                {
                  "id": 5683,
                  "name": "Residential Data Points",
                  "description": "Arduino Uno + Ethernet Shield",
                  "latitude": "35.664548",
                  "longitude": "-78.654972",
                  "created_at": "2013-05-15T12:33:57-04:00",
                  "elevation": "100",
                  "last_entry_id": 731713,
                  "ranking": 100,
                  "username": "samlro",
                  "tags":
                  [
                    {
                      "id": 950,
                      "name": "Analog Inputs"
                    }
                  ]
                }
              ]
            }',
    ),
);

my $ts = IoT::ThingSpeak->new( '_ua' => $test_ua );

like( $ts->channels, qr/\w{10}/, 'public channels test' );

done_testing;
