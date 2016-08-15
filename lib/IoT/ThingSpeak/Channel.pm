package IoT::ThingSpeak::Channel;

use strict;
use warnings;
use 5.008_005;
use Carp;
use Moose;
use DateTime;

has [qw( name username)] => (
    is  => 'ro',
    isa => 'Str',
);

has [qw( description metadata latitude longitude elevation )] => (
    is  => 'ro',
    isa => 'Maybe[Str]',
);

has id => (
    is  => 'ro',
    isa => 'Int',
);

has [qw(last_entry_id ranking)] => (
    is  => 'ro',
    isa => 'Maybe[Int]',
);

has created_at => (
    is => 'ro',

    # isa     => 'DateTime',
);

has tags => (
    is => 'ro',
    # isa     => 'Array',
);

no Moose;
__PACKAGE__->meta->make_immutable;

1;
