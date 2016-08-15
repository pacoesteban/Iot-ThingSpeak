use strict;
use Test::More;

BEGIN {
    use_ok('IoT::ThingSpeak');
    use_ok('IoT::ThingSpeak::Channel');
}

can_ok( 'IoT::ThingSpeak', qw(api_key channel_id _ua) );
can_ok( 'IoT::ThingSpeak::Channel',
    qw( name description metadata latitude longitude elevation username id last_entry_id ranking created_at tags )
);

done_testing;
