package IoT::ThingSpeak::Channel::Feed;

use strict;
use warnings;
use 5.008_005;
use Carp;
use Moose;
use DateTime;
use DateTime::Format::ISO8601;

has entry_id => (
    is  => 'ro',
    isa => 'Int',
);

foreach my $f (1..8) {
    has "field$f" => (
        is  => 'ro',
        isa => 'Maybe[Num]',
    );
}

has created_at => (
    is  => 'ro',
    isa => 'DateTime',
);

around BUILDARGS => sub {
    my ( $orig, $class, %args ) = @_;
    $args{created_at} =
      DateTime::Format::ISO8601->parse_datetime( $args{created_at} );
    return $class->$orig(%args);
};

no Moose;
__PACKAGE__->meta->make_immutable;

1;
